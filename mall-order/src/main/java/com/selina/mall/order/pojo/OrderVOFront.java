package com.selina.mall.order.pojo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderVOFront {
    private Long id;
    private String orderNo;
    private BigDecimal payMoney;
    private BigDecimal postFee;
    private Integer statusName;
    private List<OrderItemVOFront> items;
    private LocalDateTime createTime;
}