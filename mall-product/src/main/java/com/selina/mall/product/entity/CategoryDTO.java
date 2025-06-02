package com.selina.mall.product.entity;

import lombok.*;

import java.util.List;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDTO {
    private String id;
    private String name;
    private String icon;
    private List<CategoryDTO> children;
    private List<ProductDTO> goods;

    // getters and setters
}

