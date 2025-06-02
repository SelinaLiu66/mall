package com.selina.mall.order.pojo;

import com.selina.mall.order.entity.OrderItem;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderDetailDTO {
    private String orderNo;
    private String statusName;
    private LocalDateTime createTime;
    private LocalDateTime payTime;
    private LocalDateTime deliverTime;
    private LocalDateTime receiveTime;
    private BigDecimal totalMoney;
    private BigDecimal postFee;
    private BigDecimal payMoney;
    private List<OrderItem> items;
    private DeliveryInfoDTO deliverInfo;
}

