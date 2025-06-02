package com.selina.mall.product.entity;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductVO {
    private Long id;
    private String name;
    private String desc;
    private BigDecimal price;
    private String picture;
    private Integer orderNum;
}
