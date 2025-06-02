package com.selina.mall.order.pojo;

import lombok.Data;

// 参数对象
@Data
public class CartAddForm {
    private String memberId;
    private Long skuId;
    private Integer count;
}
