package com.selina.mall.order.pojo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class PayVo {
    /**
     * 商户订单号（必填）
     * 示例：202403202200141234567890
     */
    private String out_trade_no;

    /**
     * 订单总金额（必填）
     * 单位：元，精确到小数点后两位
     * 示例：new BigDecimal("199.99")
     */
    private BigDecimal total_amount;

    /**
     * 订单标题（必填）
     * 示例："iPhone 15 Pro Max 256GB"
     */
    private String subject;

    /**
     * 商品描述（可选）
     * 示例："苹果手机 银色 256GB存储"
     */
    private String body;
}