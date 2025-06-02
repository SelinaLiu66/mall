package com.selina.mall.order.pojo;

import lombok.Data;

import java.math.BigDecimal;

// CartItemDTO.java
@Data
public class CartItemDTO {
    private Long skuId;
    private Integer count;
    private BigDecimal price;
}
