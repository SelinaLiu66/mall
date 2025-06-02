package com.selina.mall.order;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;


@EnableCaching
@SpringBootApplication
@MapperScan("com.selina.mall.order.mapper")
// 开启服务注册及发现
@EnableDiscoveryClient
// 启用Feign客户端，若不启用可能导致Feign客户端失效
@EnableFeignClients
@ComponentScan(value = {"com.selina.mall"})
public class OrderApplication {
    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }
}