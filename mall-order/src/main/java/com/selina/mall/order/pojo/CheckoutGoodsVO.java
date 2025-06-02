package com.selina.mall.order.pojo;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class CheckoutGoodsVO {
    private Long skuId;
    private String name;
    private String picture;
    private BigDecimal price;
    private Integer count;
    private BigDecimal totalPrice;
}
