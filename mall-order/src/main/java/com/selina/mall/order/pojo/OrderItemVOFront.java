package com.selina.mall.order.pojo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class OrderItemVOFront {
    private String name;
    private String picture;
    private BigDecimal price;
    private Integer count;
}