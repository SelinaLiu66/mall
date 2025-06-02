package com.selina.mall.order.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 订单项DTO
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemDTO {
    private Long skuId;
    private Integer count;
    // 其他需要的字段
}
