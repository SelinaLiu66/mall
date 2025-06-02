package com.selina.mall.product.entity;

import lombok.Data;

@Data
public class ProductAttributeDTO {
    //    @NotBlank
    private String categoryName;  // 分类名称（示例："中医保健-规格"）

    //    @NotBlank
    private String attributeName; // 属性名称（示例："规格"）

    //    @NotBlank
    private String attributeValue; // 属性值（示例："暖宫腰带3片/盒"）
}