package com.selina.mall.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.CustomExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class RabbitMQConfig {
    // 延迟交换机类型
    public static final String DELAYED_EXCHANGE_TYPE = "x-delayed-message";

    // 订单延迟交换机
    @Bean
    public CustomExchange orderDelayedExchange() {
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type", "direct");
        return new CustomExchange("order.delayed.exchange",
                DELAYED_EXCHANGE_TYPE,
                true,
                false,
                args);
    }

    // 订单延迟队列
    @Bean
    public Queue orderDelayQueue() {
        return new Queue("order.delay.queue", true);
    }

    // 绑定关系
    @Bean
    public Binding orderDelayBinding() {
        return BindingBuilder.bind(orderDelayQueue())
                .to(orderDelayedExchange())
                .with("order.delay.routingkey")
                .noargs();
    }
}