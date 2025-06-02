package com.selina.mall.order.pojo;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class CartRemoveRequest {
    @NotNull(message = "用户ID不能为空")
    private Long memberId;

    @NotEmpty(message = "商品列表不能为空")
    private List<String> skuIds;
}