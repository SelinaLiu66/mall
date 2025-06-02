package com.selina.mall.order.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderRequest {
    Long memberId;
    Long addressId;
    String buyerMessage;
    Integer deliveryTimeType;
    List<GoodsVo> goods;
    Summary summary;
    Integer payChannel;
    Integer payType;

    @Data
    public static class GoodsVo {
        Long skuId;
        Integer count;
    }

    @Data
    public static class Summary {
        Long goodsCount;
        Long postFee;
        Long totalPayPrice;
        Long totalPrice;
    }
}
