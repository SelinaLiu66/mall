package com.selina.mall.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import com.selina.mall.order.entity.Order;
import com.selina.mall.order.pojo.OrderDetailDTO;
import com.selina.mall.order.pojo.OrderRequest;
import com.selina.mall.order.pojo.OrderVOFront;
import com.selina.mall.order.pojo.PayVo;
import com.selina.mall.util.ResponseResult;

/**
 * <p>
 * 订单表 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
public interface IOrderService extends IService<Order> {

    Order submitOrder(OrderRequest orderRequest);

    PayVo getPayVoByOrderSn(String outTradeNo);

    Order getOrderByOrderSn(String outTradeNo);

    void updateOrderPaid(String outTradeNo);

    PageInfo<OrderVOFront> queryUserOrders(Long userId, Integer orderState, Integer page, Integer pageSize);

    ResponseResult cancelOrder(Long orderNo);


    OrderDetailDTO getOrderDetail(String orderNo) throws Exception;

    boolean updateOrderToPaid(String outTradeNo);

    public void cancelDelayedMessage(String orderSn);

//        Page<OrderVO> queryUserOrders(Long userId, Integer orderState, Integer page, Integer pageSize);
}
