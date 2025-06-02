package com.selina.mall.order.utils;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
@Getter
@Setter
public class AlipayConfig {

//    @Value("${alipay.app_id}")
//    public static String appId;
//
//    @Value("${alipay.app_private_key}")
//    public static String appPrivateKey;
//
//    @Value("${alipay.alipay_public_key}")
//    public static String alipayPublicKey;
//
//    @Value("${alipay.gatewayUrl}")
//    public static String gatewayUrl;
//
//    @Value("${alipay.notify_url}")
//    public static String notifyUrl;
//
//    @Value("${alipay.sign_type}")
//    public static String signType;
//
//    @Value("${alipay.charset}")
//    public static String charset;

    public static String appId = "XXX";

    public static String appPrivateKey = "XXXX";

    public static String alipayPublicKey = "XXXX";

    public static String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

    public static String notifyUrl = "http://XXXX/mall-order/order/notify";

    public static String signType = "RSA2";

    public static String charset = "utf-8";
    public static String returnUrl = "http://localhost:5137/paycallback";

    /**
     * 初始化支付宝客户端（沙箱环境）
     */
    @Bean
    public AlipayClient alipayClient() {
        return new DefaultAlipayClient(
                gatewayUrl,
                appId,
                appPrivateKey,
                "json",   // 请求格式
                charset,  // 编码（从配置读取）
                alipayPublicKey,
                signType  // 签名算法（从配置读取）
        );
    }

    /**
     * 获取异步通知地址
     */
    public static String getNotifyUrl() {
        return notifyUrl;
    }
}