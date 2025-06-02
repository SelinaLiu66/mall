package com.selina.mall.order.pojo;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class CheckoutSummaryVO {
    private Integer goodsCount;
    private BigDecimal totalPrice;
    private BigDecimal postFee;
    private BigDecimal totalPayPrice;
}
