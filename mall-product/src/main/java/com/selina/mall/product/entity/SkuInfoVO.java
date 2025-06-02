package com.selina.mall.product.entity;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class SkuInfoVO {
    private Long skuId;
    private String title;
    private String defaultImage;
    private BigDecimal price;
    private String status;
}