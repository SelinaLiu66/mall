package com.selina.mall.product.entity;

import lombok.Data;

import java.util.List;

@Data
public class ProductCategoryVO {
    private Long id;
    private String name;
    private String picture;
    private List<ProductCategoryVO> children;
    private List<ProductVO> goods;
}

