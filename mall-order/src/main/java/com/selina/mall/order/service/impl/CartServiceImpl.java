package com.selina.mall.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.order.controller.CartController;
import com.selina.mall.order.entity.Cart;
import com.selina.mall.order.mapper.CartMapper;
import com.selina.mall.order.pojo.CartAddForm;
import com.selina.mall.order.pojo.OrderRequest;
import com.selina.mall.order.service.ICartService;
import com.selina.mall.order.service.client.ProductServiceClient;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.entity.SkuStock;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>
 * 购物车表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-05-03
 */

@Service
@RequiredArgsConstructor
public class CartServiceImpl extends ServiceImpl<CartMapper, Cart> implements ICartService {
    private final ProductServiceClient productServiceClient; // 商品服务Feign客户端

    @Override
    public List<Cart> getCartByMemberId(Long memberId) {
        return lambdaQuery()
                .eq(Cart::getMemberId, memberId)
                .list();
    }

    @Autowired
    private CartMapper cartMapper;

    @Override
    public List<CartController.CartVo> getCartVoByMemberId(Long member) {
        return cartMapper.getCartVoByMemberId(member);
    }

    @Override
    @Transactional
    public boolean addOrUpdateCart(CartAddForm form) {
//    public boolean addOrUpdateCart(Long memberId, Long skuId, Integer count) {
        // TODO: 查看用户是不是存在
        // 1. 校验商品状态
        SkuStock skuInfo = productServiceClient.getSkuStock(form.getSkuId());
        if (skuInfo == null) {
            return false;
        }

        // 2. 查询是否已存在
        Cart existItem = lambdaQuery()
                .eq(Cart::getMemberId, form.getMemberId())
                .eq(Cart::getSkuId, form.getSkuId())
                .one();

        if (existItem != null) {
            // 3. 更新数量
            existItem.setCount(existItem.getCount() + form.getCount());
            return updateById(existItem);
        } else {
            // 4. 新增记录
            Cart newItem = new Cart();
            newItem.setMemberId(Long.valueOf(form.getMemberId()));
            newItem.setSkuId(form.getSkuId());
            newItem.setCount(form.getCount());
            newItem.setSelected(true);
            newItem.setPrice(skuInfo.getPrice()); // 存储价格快照
            return save(newItem);
        }
    }

    @Override
    public boolean batchDelete(Long memberId, Long skuId) {
        if (skuId == null) return false;
        return baseMapper.deleteByMemberAndSku(memberId, skuId) > 0;
    }

    @Override
    @Transactional
    public void mergeCart(Long memberId, List<Cart> carts) {
        // 1. 获取现有购物车
        Map<Long, Cart> existMap = getCartByMemberId(memberId)
                .stream()
                .collect(Collectors.toMap(Cart::getSkuId, Function.identity()));

        // 2. 合并处理
        List<Cart> toAdd = new ArrayList<>();
        List<Cart> toUpdate = new ArrayList<>();

        for (Cart newItem : carts) {
            if (existMap.containsKey(newItem.getSkuId())) {
                // 合并数量
                Cart existItem = existMap.get(newItem.getSkuId());
                existItem.setCount(existItem.getCount() + newItem.getCount());
                existItem.setSelected(newItem.getSelected());
                toUpdate.add(existItem);
            } else {
                // 新增记录
                newItem.setMemberId(memberId);
                toAdd.add(newItem);
            }
        }

        // 3. 批量操作
        if (!toAdd.isEmpty()) saveBatch(toAdd);
        if (!toUpdate.isEmpty()) updateBatchById(toUpdate);
    }

    @Override
    public boolean clearCart(OrderRequest orderRequest) {
        if (orderRequest == null || orderRequest.getGoods() == null || orderRequest.getGoods().isEmpty()) {
            // 如果请求参数或商品列表为空，直接返回失败
            return false;
        }

        Long memberId = orderRequest.getMemberId();
        if (memberId == null) {
            // 会员ID为空时无法操作购物车
            return false;
        }

        boolean allSuccess = true;
        for (OrderRequest.GoodsVo goodsVo : orderRequest.getGoods()) {
            Long skuId = goodsVo.getSkuId();
            if (skuId == null) {
                allSuccess = false; // 遇到无效SKU ID则标记失败
                continue;
            }

            // 调用购物车服务删除指定商品
            QueryWrapper<Cart> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("member_id", memberId);
            queryWrapper.eq("sku_id", skuId);
            boolean success = cartMapper.delete(queryWrapper) > 0;
            if (!success) {
                allSuccess = false; // 任意一次删除失败则整体失败
            }
        }

        return allSuccess;
    }

//    public List<CartController.CartVo> getCartVoByMemberIdAndCart(Long memberId, List<OrderRequest.GoodsVo> goods) {
//        QueryWrapper queryWrapper=new QueryWrapper();
//        queryWrapper.eq("memberId",memberId);
//        queryWrapper.in("sku_id",goods.stream().map(OrderRequest.GoodsVo::getSkuId).collect(Collectors.toList()));
//        List<Cart> carts  = cartMapper.selectList(queryWrapper);
//        for (Cart cart : carts) {
//            cart.getSkuId()
//        }
//    }
//    public List<CartController.CartVo> getCartVoByMemberIdAndCart(Long memberId, List<OrderRequest.GoodsVo> goods) {
//        // 1. 构建查询条件：根据用户ID和传入的sku_id列表查询购物车数据
//        QueryWrapper<Cart> queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("memberId", memberId);
//        List<Long> skuIds = goods.stream()
//                .map(OrderRequest.GoodsVo::getSkuId)
//                .collect(Collectors.toList());
//        queryWrapper.in("sku_id", skuIds);
//        List<Cart> carts = cartMapper.selectList(queryWrapper);
//
//        // 2. 将传入的goods转换为Map<skuId, GoodsVo>以便快速查找
//        Map<Long, OrderRequest.GoodsVo> goodsMap = goods.stream()
//                .collect(Collectors.toMap(OrderRequest.GoodsVo::getSkuId, Function.identity()));
//
//        String warningStr="";
//        // 3. 遍历数据库中的购物车商品，逐个比较数量
//        for (Cart cart : carts) {
//            Long skuId = cart.getSkuId();
//            OrderRequest.GoodsVo goodsVo = goodsMap.get(skuId);
//
//            // 3.1 检查传入的goods是否包含该sku（理论上不会发生，因为已通过in查询过滤）
//            if (goodsVo == null) {
//                throw new IllegalArgumentException("无效的SKU: " + skuId);
//            }
//
//            // 3.2 比较传入数量与数据库中的数量
//            int requestCount = goodsVo.getCount();
//            int dbCount = cart.getCount(); // 假设Cart类有getCount()方法
//
//            if (requestCount > dbCount) {
//                warningStr+=("商品SKU"+skuId+"的请求数量"+requestCount+"超过购物车中的数量(%d)"+dbCount);
//                throw new RuntimeException(String.format(
//                        "商品SKU[%s]的请求数量(%d)超过购物车中的数量(%d)",
//                        skuId, requestCount, dbCount
//                ));
//            }
//        }
//
//        // 4. 转换为CartVo返回（根据实际业务补充转换逻辑）
//        return carts.stream()
//                .map(cart -> {
//                    CartController.CartVo cartVo = new CartController.CartVo();
//                    cartVo.setSkuId(cart.getSkuId());
//                    cartVo.setCount(cart.getCount());
//                    return cartVo;
//                })
//                .collect(Collectors.toList());
//    }

    public List<CartController.CartVo> getCartVoByMemberIdAndCart(Long memberId, List<OrderRequest.GoodsVo> goods) {
        // 1. 查询购物车数据（同上）
        QueryWrapper<Cart> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("member_id", memberId);
        List<Long> skuIds = goods.stream()
                .map(OrderRequest.GoodsVo::getSkuId)
                .collect(Collectors.toList());
        queryWrapper.in("sku_id", skuIds);
        List<Cart> carts = cartMapper.selectList(queryWrapper);

        // 2. 获取商品信息（新增步骤）
        // 方式一：假设Cart中已经包含商品名称字段（需要确保查询时包含）
        // 方式二：通过skuIds查询商品服务获取商品信息
        Map<Long, String> skuNameMap = getSkuNames(skuIds); // 需要实现这个方法
        // 3. 转换goods为Map结构（同上）
        Map<Long, OrderRequest.GoodsVo> goodsMap = goods.stream()
                .collect(Collectors.toMap(OrderRequest.GoodsVo::getSkuId, Function.identity()));

        String warning = "";
        // 4. 比较逻辑（修改异常提示）
        for (Cart cart : carts) {
            Long skuId = cart.getSkuId();
            OrderRequest.GoodsVo goodsVo = goodsMap.get(skuId);

            if (goodsVo == null) {
                warning += ("无效的SKU: " + skuId + "\n");
                continue;
            }

            int requestCount = goodsVo.getCount();
            int dbCount = cart.getCount();

            if (requestCount > dbCount) {
                String goodsName = skuNameMap.get(skuId);
                warning += ((goodsName != null ? goodsName : "未知商品") + "库存不足");
            }
        }

        // 5. 转换返回（同上）
        return carts.stream()
                .map(cart -> convertToCartVo(cart, skuNameMap))
                .collect(Collectors.toList());
    }

    // 新增方法：获取商品名称
    private Map<Long, String> getSkuNames(List<Long> skuIds) {
        // 实现方式根据你的架构选择：
        // 方式1：直接查询商品表（假设有访问权限）
        // List<Product> products = productMapper.selectBatchIds(skuIds);
        // return products.stream().collect(Collectors.toMap(Product::getSkuId, Product::getName));

        // 方式2：调用商品服务接口
        // return productServiceClient.getSkuNames(skuIds);

        Map<Long, String> objectObjectHashMap = new HashMap<>();
        for (Long skuId : skuIds) {
            Product product = productServiceClient.getProductsInfoBySkuId(skuId);
            objectObjectHashMap.put(skuId, product.getName());
        }
//        List<Product> productsInfoBySkuIds = productServiceClient.getProductsInfoBySkuIds(skuIds);
//        productsInfoBySkuIds.stream().map(Product::getName)
        return objectObjectHashMap;
    }

    // 转换时携带商品名称（可选）
    private CartController.CartVo convertToCartVo(Cart cart, Map<Long, String> skuNameMap) {
        CartController.CartVo cartVo = new CartController.CartVo();
        cartVo.setSkuId(cart.getSkuId());
        cartVo.setCount(cart.getCount());
//        cartVo.setGoodsName(skuNameMap.get(cart.getSkuId())); // 需要CartVo有该字段
        return cartVo;
    }

    @Data
    public class SkuInfoVO {
        private Long skuId;
        private String title;
        private String defaultImage;
        private BigDecimal price;
        private String status;
    }

    //    @Override
//    public List<OrderController.CartItemVO> validateItems(Long memberId, List<OrderController.CheckoutItemDTO> items) {
//        if (items == null || items.isEmpty()) {
//            throw new IllegalArgumentException("结算商品不能为空");
//        }
//
//        // 1. 提取商品ID列表
//        List<Long> skuIds = items.stream()
//                .map(OrderController.CheckoutItemDTO::getSkuId)
//                .collect(Collectors.toList());
//
//        // 2. 远程调用商品服务获取商品信息
//        Map<Long, SkuInfoVO> skuMap = productServiceClient.getSkuInfoMap(skuIds);
//
//        // 3. 验证商品有效性并转换为CartItemVO
//        List<OrderController.CartItemVO> validItems = new ArrayList<>();
//        for (OrderController.CheckoutItemDTO item : items) {
//            Long skuId = item.getSkuId();
//            SkuInfoVO skuInfo = skuMap.get(skuId);
//
//            // 验证商品是否存在
////            if (skuInfo == null) {
////                log.warn("商品不存在, skuId: {}", skuId+"");
////                continue;
////            }
//
////            // 验证商品状态
////            if (!"上架".equals(skuInfo.getStatus())) {
////                log.warn("商品已下架, skuId: {}", skuId);
////                continue;
////            }
//
//            // 验证库存是否充足
//            if (!productServiceClient.subStock(skuId, item.getCount())) {
//                return null;
//            }
//
//            // 构建有效商品项
//            OrderController.CartItemVO cartItem = new OrderController.CartItemVO();
//            cartItem.setSkuId(skuId);
//            cartItem.setTitle(skuInfo.getTitle());
//            cartItem.setImage(skuInfo.getDefaultImage());
//            cartItem.setPrice(skuInfo.getPrice());
//            cartItem.setCount(item.getCount());
//            cartItem.setCheck(true);
//            cartItem.setTotalPrice(skuInfo.getPrice().multiply(BigDecimal.valueOf(item.getCount())));
//
//            // 获取商品销售属性
////            List<String> skuAttr = skuSaleAttrValueFeignService.getSkuSaleAttrValues(skuId);
//
//            cartItem.setSkuAttr(Collections.singletonList(productServiceClient.getSkuStock(item.getSkuId()).getSpData()));
//
//            validItems.add(cartItem);
//        }
//
//        if (validItems.isEmpty()) {
//            return null;
//        }
//
//        return validItems;
//    }
    @Override
    public int removeCartItems(Long memberId, List<String> skuIds) {
        // 验证商品是否属于该用户
//    List<String> validSkuIds = cartMapper.validateOwnership(memberId, skuIds);
//    if (validSkuIds.size() != skuIds.size()) {
//        throw new BusinessException("包含无效商品项");
//    }

        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("member_id", memberId);
        queryWrapper.in("sku_id", skuIds);
        List list = cartMapper.selectList(queryWrapper);
        if (list.size() == skuIds.size()) {
            return cartMapper.deleteByMemberAndSkus(memberId, skuIds);

        } else {
            return 0;
        }
        // 执行删除
    }
}
