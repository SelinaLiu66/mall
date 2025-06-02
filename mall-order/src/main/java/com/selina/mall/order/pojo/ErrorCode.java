package com.selina.mall.order.pojo;

public enum ErrorCode {
    SUCCESS(200, "操作成功"),
    ORDER_NOT_EXIST(4001, "订单不存在"),
    ORDER_STATUS_ERROR(4002, "订单状态异常"),
    ORDER_UPDATE_FAIL(4003, "订单更新失败");

    private final int code;
    private final String msg;

    ErrorCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    // getters...
}