package com.selina.mall.order.pojo;

import lombok.*;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@Setter
@Getter
@NoArgsConstructor
public class OrderVO {
    private Integer id;
    private Integer memberId;
    private BigDecimal totalPrice;
}
