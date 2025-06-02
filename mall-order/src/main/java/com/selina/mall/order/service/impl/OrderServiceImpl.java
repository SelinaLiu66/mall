package com.selina.mall.order.service.impl;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.GetResponse;
import com.selina.mall.order.controller.CartController;
import com.selina.mall.order.entity.Order;
import com.selina.mall.order.entity.OrderItem;
import com.selina.mall.order.mapper.OrderItemMapper;
import com.selina.mall.order.mapper.OrderMapper;
import com.selina.mall.order.mapper.OrderOperateHistoryMapper;
import com.selina.mall.order.pojo.*;
import com.selina.mall.order.service.IOrderItemService;
import com.selina.mall.order.service.IOrderService;
import com.selina.mall.order.service.client.MemberServiceClient;
import com.selina.mall.order.service.client.ProductServiceClient;
import com.selina.mall.order.utils.SnowflakeIdGenerator;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.entity.SkuStock;
import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.MemberReceiveAddress;
import com.selina.mall.util.ResponseResult;
import io.seata.spring.annotation.GlobalTransactional;
import org.apache.commons.lang.StringUtils;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 订单表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements IOrderService {
    //注入一个商品服务的远程客户端实例 便于远程调用商品服务的接口
    @Autowired
    private ProductServiceClient productServiceClient;
    @Autowired
    private MemberServiceClient memberServiceClient;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderOperateHistoryMapper orderOperateHistoryMapper;

    @Autowired
    private IOrderItemService orderItemService;


    // 注解：用于设置将普通的类或方法定义成资源 取一个名字方便后续进行资源名的定位
    @SentinelResource("MSR01")
    public String message(int i) {
        return "message-" + i;
    }

    //    @Override
////    @Transactional  //本地事务注解
////    @GlobalTransactional //Seata框架用于全局事务处理的注解
//    public void submitOrder(Integer pid, Integer num, Integer memberId, String memberUsername, String receiverName, String receiverPhone) {
//        //先查询商品信息
//        Product product= (Product) productServiceClient.detail(pid).getData();
//        //判断库存是否充足
//        if(product.getStock()>=num){
//            synchronized (this){
//                //计算总价
//                float totalAmount=product.getPrice().floatValue() * num;
//                Order order = new Order();
//                order.setMemberId(memberId.intValue());
//                order.setMemberUsername(memberUsername);
//                order.setCreateTime(LocalDateTime.now());
//                order.setReceiverName(receiverName);
//                order.setReceiverPhone(receiverPhone);
//                order.setTotalAmount(new BigDecimal(totalAmount));
//                this.save(order);
//
//                OrderItem orderItem=new OrderItem();
//                orderItem.setOrderId(order.getId());
//                orderItem.setProductId(product.getId());
//                orderItem.setProductName(product.getName());
//                orderItem.setProductPrice(product.getPrice());
//                orderItem.setProductQuantity(num);
//                orderItemService.save(orderItem);
//                //远程调用商品服务，完成修改库存的操作
//                productServiceClient.subStock(Long.valueOf(pid),num);
//
//            }
//            // TODO:购买
//
//            System.out.println("下单成功");
//        }else {
//            //如果是热点数据
//            System.out.println("库存不足");
//        }
//
//    }
    @Autowired
    private CartServiceImpl cartService;


    // TODO: 加一个分布式锁
    @Override
    @GlobalTransactional
    public Order submitOrder(OrderRequest orderRequest) {
        // 1. 校验地址
        MemberReceiveAddress address = memberServiceClient.validateAddress(orderRequest.getAddressId(), orderRequest.getMemberId());
        if (address == null) {
            return null;
        }
        // 2. 获取购物车数据并校验库存
        // 根据用户传入的数据进行校验
//        List<CartController.CartVo> cartItems = cartService.getCartVoByMemberId(orderRequest.getMemberId());
        List<CartController.CartVo> cartItems = cartService.getCartVoByMemberIdAndCart(orderRequest.getMemberId(), orderRequest.getGoods());
        validateStock(cartItems);

        // 3. 生成订单
        Order order = this.createOrder(orderRequest, address);
        orderMapper.insert(order);
        // 4. 保存订单商品明细
        List<OrderItem> orderItems = this.createItems(cartItems, orderRequest, order);
        orderItemService.saveBatch(orderItems);
        // 5. 清理购物车
        cartService.clearCart(orderRequest);
        sendDelayedCancelOrder(Long.valueOf(order.getId()), 2 * 60 * 1000); // 30分钟

        return order;
    }

    @Override
    public PayVo getPayVoByOrderSn(String outTradeNo) {
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_sn", outTradeNo);
        Order order = orderMapper.selectOne(queryWrapper);

        PayVo payVo = new PayVo();
        payVo.setOut_trade_no(order.getOrderSn());
        payVo.setTotal_amount(order.getTotalAmount().setScale(2, RoundingMode.HALF_UP));
        payVo.setSubject(order.getMemberUsername() + " 下订单：" + order.getOrderSn());
        return payVo;
    }

    @Override
    public Order getOrderByOrderSn(String outTradeNo) {
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_sn", outTradeNo);
        return orderMapper.selectOne(queryWrapper);
    }

    @Override
    public void updateOrderPaid(String outTradeNo) {
        orderMapper.updateOrderPaidByOrderSn(outTradeNo);
    }

    public Order createOrder(OrderRequest orderRequest, MemberReceiveAddress address) {
        Member member = memberServiceClient.validateUser(orderRequest.getMemberId());
        Order order = new Order();
        order.setMemberUsername(member.getUsername());
        BeanUtils.copyProperties(orderRequest, order);
        order.setMemberId(Math.toIntExact(orderRequest.getMemberId()));
        order.setReceiverName(address.getName());
        order.setReceiverPhone(address.getPhoneNumber());
        order.setReceiverProvince(address.getProvince());
        order.setReceiverCity(address.getCity());
        order.setReceiverRegion(address.getRegion());
        order.setReceiverDetailAddress(address.getDetailAddress());
        order.setFreightAmount(BigDecimal.valueOf(orderRequest.getSummary().getPostFee()));
        order.setTotalAmount(BigDecimal.valueOf(orderRequest.getSummary().getTotalPrice()));
        order.setPayAmount(BigDecimal.valueOf(orderRequest.getSummary().getTotalPayPrice()));
        order.setCreateTime(LocalDateTime.now());
        //
        SnowflakeIdGenerator generator = new SnowflakeIdGenerator(1, 1);
        order.setOrderSn(generator.nextId() + "");

        return order;
    }

    public List<OrderItem> createItems(List<CartController.CartVo> cartItems, OrderRequest orderRequest, Order order) {
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartController.CartVo cartItem : cartItems) {
            OrderItem item = new OrderItem();
            BeanUtils.copyProperties(orderRequest, item);
            item.setOrderSn(order.getOrderSn());
            item.setOrderId(order.getId());
            SkuStock skuStock = productServiceClient.getSkuStock(cartItem.getSkuId());
            Product goodsInfo = productServiceClient.getGoodsInfo(Long.valueOf(skuStock.getProductId()));
            item = this.copyProduct(goodsInfo, item);
            item = this.copySkuStock(skuStock, item);
            item.setProductQuantity(cartItem.getCount());
            item.setProductPic(cartItem.getPicture());
            orderItems.add(item);
        }
        return orderItems;
    }

    private void validateStock(List<CartController.CartVo> items) {
        items.forEach(item -> {
            SkuStock skuStock = productServiceClient.getSkuStock(item.getSkuId());
            if (skuStock.getStock() < item.getCount()) {
                try {
                    throw new Exception("商品库存不足: " + item.getName());
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
        });
    }

    public static OrderItem copyProduct(Product product, OrderItem item) {
        if (product == null) return null;
        item.setProductId(product.getId());
        item.setProductName(StringUtils.defaultString(product.getName(), ""));
        item.setProductPic(StringUtils.defaultString(product.getPic(), ""));
        item.setProductSn(product.getProductSn());
        item.setProductPrice(product.getPrice() != null ? product.getPrice() : BigDecimal.ZERO);
        item.setProductCategoryId(convertLongToInt(product.getProductCategoryId()));
        item.setProductBrand(StringUtils.defaultString(product.getBrandName(), ""));
        return item;
    }

    public static OrderItem copySkuStock(SkuStock skuStock, OrderItem orderItem) {
        if (skuStock == null || orderItem == null) {
            return orderItem;
        }

        // 基础商品信息映射
        orderItem.setProductSkuId(skuStock.getId());
        orderItem.setProductId(skuStock.getProductId());
        orderItem.setProductSkuCode(skuStock.getSkuCode());
        orderItem.setProductPic(skuStock.getPic());
        orderItem.setProductAttr(skuStock.getSpData());

        // 价格信息映射
        // 使用促销价优先，若无则使用普通价格
        BigDecimal price = skuStock.getPromotionPrice();
        if (price == null || price.compareTo(BigDecimal.ZERO) <= 0) {
            price = skuStock.getPrice();
        }
        orderItem.setProductPrice(price);
        orderItem.setRealAmount(price); // 假设实付金额等于商品价格，实际场景可能需要计算

        // 库存和销售信息（可选映射）
        // 注意：库存信息通常不在订单项中直接反映，这里仅作为参考
        orderItem.setGiftIntegration(0); // 假设赠送积分为0，实际应根据业务规则计算
        orderItem.setGiftGrowth(0);     // 假设赠送成长值为0

        return orderItem;
    }

    private static Integer convertLongToInt(Long value) {
        return value != null ? value.intValue() : null;
    }

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Override
    public PageInfo<OrderVOFront> queryUserOrders(Long userId, Integer orderState, Integer page, Integer pageSize) {
        // 1. 分页参数处理
        PageHelper.startPage(page, pageSize);
        // 2. 查询订单
        List<Order> orders = orderMapper.selectOrdersByUserId(userId);
        Page<Order> orderPage = (Page<Order>) orders;
        // 3. 转换为VO
        List<OrderVOFront> orderVOS = orderPage.getResult().stream().map(order -> {
            OrderVOFront vo = new OrderVOFront();
//            System.out.println("查询order信息："+order);
            vo.setOrderNo(order.getOrderSn());
            vo.setId(Long.valueOf(order.getId()));
            vo.setPayMoney(order.getPayAmount());
            vo.setPostFee(order.getFreightAmount());
            // 设置状态名称
            vo.setStatusName(order.getStatus());
            vo.setCreateTime(order.getCreateTime());
            // 查询订单项
            List<OrderItem> orderItems = orderItemMapper.selectItemsByOrderId(Long.valueOf(order.getId()));
            List<OrderItemVOFront> items = new ArrayList<>();
            for (OrderItem item : orderItems) {
                OrderItemVOFront orderItemVOFront = new OrderItemVOFront();
                orderItemVOFront.setName(item.getProductName());
                orderItemVOFront.setPicture(item.getProductPic());
                orderItemVOFront.setPrice(item.getProductPrice());
                orderItemVOFront.setCount(item.getProductQuantity());
                items.add(orderItemVOFront);
            }
            vo.setItems(items);
            return vo;
        }).collect(Collectors.toList());

        // 4. 封装分页结果
//        Page<Order> p = (Page<Order>) orders;

        PageInfo<OrderVOFront> pageInfo = new PageInfo<>(orderVOS);
        pageInfo.setPageNum(page);
        pageInfo.setPageSize(pageSize);
        pageInfo.setTotal(orderPage.getTotal());
        return pageInfo;
    }

    //    private String getStatusName(Integer status) {
//        switch (status) {
//            case 1: return "待付款";
//            case 2: return "待发货";
//            case 3: return "待收货";
//            case 4: return "待评价";
//            case 5: return "已完成";
//            case 6: return "已取消";
//            default: return "未知状态";
//        }
//    }
    public ResponseResult cancelOrder(Long orderId) {
        // 查询订单
        Order order = orderMapper.selectOne(new LambdaQueryWrapper<Order>()
                .eq(Order::getId, orderId));
        // 验证订单是否存在
        if (order == null) {
            return ResponseResult.failure(ErrorCode.ORDER_NOT_EXIST);
        }
        // 验证订单状态是否可取消（只有待付款状态可取消）
        if (order.getStatus() != OrderStatus.UNPAY.getCode()) {
            return ResponseResult.failure(ErrorCode.ORDER_STATUS_ERROR);
        }

        // 更新订单状态
        Order updateOrder = new Order();
        updateOrder.setId(order.getId());
        updateOrder.setStatus(OrderStatus.CANCEL.getCode());
//        updateOrder.setCancelTime(LocalDateTime.now());

        int rows = orderMapper.updateById(updateOrder);
        return rows > 0 ? ResponseResult.success(ErrorCode.ORDER_UPDATE_FAIL) : ResponseResult.failure("订单信息更新失败");
    }


//    @Autowired
//    private OrderDeliveryMapper orderDeliveryMapper;

    @Override
    public OrderDetailDTO getOrderDetail(String orderNo) throws Exception {
        // 1. 验证订单归属
        Order order = this.getOrderByOrderSn(orderNo);
        if (order == null) {
            throw new Exception(String.valueOf(ErrorCode.ORDER_NOT_EXIST));
        }

        // 2. 查询订单商品
        List<OrderItem> items = orderItemMapper.selectItemsByOrderId(Long.valueOf(order.getId()));

        // 3. 查询物流信息
//        OrderDelivery delivery = orderDeliveryMapper.selectByOrderNo(orderNo);

        // 4. 组装DTO
        OrderDetailDTO dto = copyOrder(order);

        dto.setItems(items);
//        dto.setDeliverInfo(convertDelivery(delivery));

        System.out.println("返回给前端的dto信息：" + dto);
        return dto;
    }

    private OrderDetailDTO copyOrder(Order order) {
        OrderDetailDTO dto = new OrderDetailDTO();
        dto.setOrderNo(order.getOrderSn());
        dto.setStatusName(order.getStatus() + "");
        dto.setCreateTime(order.getCreateTime());
        dto.setPayTime(order.getPaymentTime());
        dto.setDeliverTime(order.getDeliveryTime());
        dto.setReceiveTime(order.getReceiveTime());
        dto.setTotalMoney(order.getTotalAmount());
        dto.setPostFee(order.getFreightAmount());
        dto.setPayMoney(order.getPayAmount());
        return dto;
    }

    @Autowired
    private RabbitTemplate rabbitTemplate;

//    @Autowired
//    public OrderService(RabbitTemplate rabbitTemplate) {
//        this.rabbitTemplate = rabbitTemplate;
//    }

    // 创建订单并发送延迟消息
//    public Order createOrder(OrderCreateDTO dto) {
//        // 1. 保存订单到数据库
//        Order order = new Order();
//        // ... 设置订单属性
//        order.setStatus(OrderStatus.UNPAID);
//        orderRepository.save(order);
//
//        // 2. 发送延迟消息（30分钟未支付自动取消）
//        sendDelayedCancelOrder(order.getId(), 30 * 60 * 1000); // 30分钟
//
//        return order;
//    }

    // 发送延迟取消订单消息
    private void sendDelayedCancelOrder(Long orderId, long delayMillis) {
        rabbitTemplate.convertAndSend(
                "order.delayed.exchange",
                "order.delay.routingkey",
                orderId,
                message -> {
                    // 设置消息ID（关键！）
                    String messageId = "order_delay_" + orderId;
                    message.getMessageProperties().setMessageId(messageId);

                    // 设置延迟时间
                    message.getMessageProperties().setHeader("x-delay", delayMillis);
                    return message;
                });
    }

    // 处理订单取消
//    public void cancelOrder(Long orderId) {
//        Order order = orderRepository.findById(orderId)
//                .orElseThrow(() -> new Exception("订单不存在"));
//
//        if (order.getStatus() == OrderStatus.UNPAID) {
//            order.setStatus(OrderStatus.CANCELLED);
//            order.setCancelReason("超时未支付");
//            orderRepository.save(order);
//
//            // 释放库存等后续操作...
//        }
//    }


    @Transactional
    public boolean updateOrderToPaid(String orderSn) {
        // 1. 查询订单（加锁）
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("order_sn", orderSn);
        Order order = orderMapper.selectOne(queryWrapper);
        if (order == null) return false;

        // 2. 更新状态
        order.setStatus(2); // 已支付
//        order.setPayId(tradeNo); // 支付宝交易号
        order.setPaymentTime(LocalDateTime.now()); // 支付时间

        // 3. 执行更新
        return orderMapper.updateById(order) > 0;
    }

    public void cancelDelayedMessage(String orderSn) {
        // 构造与发送时相同的消息ID
        String messageId = "order_delay_" + orderSn;

        // 删除延迟消息
        rabbitTemplate.execute(channel -> {
            // 声明原始交换机（确保存在）
            channel.exchangeDeclare("order.delayed.exchange", "x-delayed-message", true, false,
                    Map.of("x-delayed-type", "direct"));

            // 获取消息
            GetResponse response = channel.basicGet("order.delay.queue", false);
            while (response != null) {
                AMQP.BasicProperties props = response.getProps();
                String message = new String(response.getBody(), StandardCharsets.UTF_8);

                // 检查是否为目标消息
                if (message.contains(orderSn) ||
                        (props.getMessageId() != null && props.getMessageId().equals(messageId))) {

                    // 确认删除消息
                    channel.basicAck(response.getEnvelope().getDeliveryTag(), false);
//                    log.info("已清除延迟消息：orderSn={}", orderSn);
                    return null;
                }

                // 继续获取下一条消息
                response = channel.basicGet("order.delay.queue", false);
            }
            return null;
        });
    }
}
