package com.selina.mall.order.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

// 创建订单DTO
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateOrderDTO {
    private Integer deliveryTimeType;
    private Integer payType;
    private Integer payChannel;
    private String buyerMessage;
    private List<OrderItemDTO> goods;
    private Long addressId;
}
