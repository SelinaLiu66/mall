package com.selina.mall.product.entity;

import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {
    private String id;
    private String name;
    private String desc;
    private String price;
    private String picture;

    // getters and setters
}