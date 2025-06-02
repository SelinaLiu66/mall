package com.selina.mall.order.componet;

import com.selina.mall.order.service.IOrderService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderDelayConsumer {
    @Autowired
    private IOrderService orderService;

    @RabbitListener(queues = "order.delay.queue")
    public void handleDelayedOrderCancel(Long orderId) {
        try {
            // 处理订单取消逻辑
            orderService.cancelOrder(orderId);
            System.out.println("订单超时取消: " + orderId);
        } catch (Exception e) {
            // 异常处理与重试逻辑
            System.err.println("处理订单取消失败: " + e.getMessage());
        }
    }
}