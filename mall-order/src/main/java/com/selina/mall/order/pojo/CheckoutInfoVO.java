package com.selina.mall.order.pojo;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class CheckoutInfoVO {
    private Long memberId;
    private List<AddressVO> userAddresses;
    private List<CheckoutGoodsVO> goods;
    private CheckoutSummaryVO summary;
}

