package com.selina.mall.order.pojo;

import lombok.Getter;

@Getter
public enum OrderStatus {
    UNPAY(1, "待付款"),
    DELIVER(2, "待发货"),
    RECEIVE(3, "待收货"),
    COMPLETE(5, "已完成"),
    COMMENT(4, "待评价"),
    CANCEL(0, "已取消");

    private final int code;
    private final String desc;

    OrderStatus(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

}