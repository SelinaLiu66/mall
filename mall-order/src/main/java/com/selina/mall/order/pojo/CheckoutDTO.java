package com.selina.mall.order.pojo;

import lombok.Data;

import java.util.List;

// CheckoutDTO.java
@Data
public class CheckoutDTO {
    private Long memberId;
    private List<CartItemDTO> items;
}

