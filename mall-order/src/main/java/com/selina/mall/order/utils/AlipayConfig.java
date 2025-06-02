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

    public static String appId = "2021000148674115";

    public static String appPrivateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD0RnEn+0OLlyj8zH2NMnRVEj1SkNkPziQH87KBV/l2aU38mkj/MkA1erouUD78kYoPaWmiR8eCdD1avEm3/KTodAo1/Ntzqg5+Be0hgloPxxbK9tDRS+RsxYh1w2FH6SExMGQbe2nHwCM+FzLiFELUAEYZ+N0BPQqeqTrReVm9p9/KTNzIe0076w12srqY0L9yaKgcLk9ef1d/OwjoyomIGWC9Ld34na654n7j4kk/fzhlhxDa9E8oKxHWvmg2eUtWNCuCuvfmsysUnDDnvdhda1+/rwIGeg6ADWReF8IYrAFwetWlOOpzqnPevpVJo8sVkrSxRY5gfc9dB4ETgspLAgMBAAECggEAMf9xDcPqEVpBM20PjaT0Fq2DC7FGHGwPB+mjccH193yaT8eshT9d0RRroysdmUiYv4rN6j9S4Kq2HCpJ1HTLtCB8Loywxj3adYT1AlTR5kTTr3tRRmWIPZM42RHCiZt4Bb9n3hAmmJIFJKJO8eM/wnDD6HD9m1FJKSxuM43pBl49lY0XrpkwPTSwN/9VDbUWyQcthyFpFE2mSwQXqNeWnfEttPo6RUpzUesIUyOVcHYPgVn0TYwedpt4oxbxj+yiQMSZjhCGXo8F3xippxe20FAA86MQKiZ4HlBZnBn1WxGX9Ih3uj/roFWeHU0zfikVlljvYUNciGtoiG6EV2NcoQKBgQD/fcu81zUf55128ZORGVuCpq1jG4qUy2m1KmqDFDC4R3y6HwqRvCzQbN7RTprofufPajsHZKBRFZzEwW2HrwkG+aXHSA2+sezbVFz/mnybnT+cQHgodmSb7LD/bEzwESPZcFrpy0bUTQTNoNQqm/A144qaUB2yDZBnpS0qCRPFIwKBgQD0wu4ctDmkQbJxECRfB31lcZOtdyL7AmjoW95TvBxT6gKbbmO91iJOA8Lcwb9e187LRznCtM2FybE9f+RZlbXFALSEKf7IUct0xc8wshwP+lM00+lBgyHis5ERsGq4ltawTMKXyhLz1QSROzf/0TnUCFdPIBn4kr9HWpX25QicuQKBgQC3i74Uel81/oVHcCHdeeQeJnQl4SFb6A6XElPWu2iM2v6mD6reK9veGHiy0c/D+3e5sM2bcBUka2xmhbeUZJENq8gHNKJ7PwO0RhVRo8ClYwDR1hb8qqF4y0AVH87eINIqYedOUrUdy/8JYuNJgSG+9Ssb1TagNdJqQ2YA7uh/FQKBgAykWNogsO17+zR9yfMiluZ7dE48XhEq8bI2tIgMqkXnS1Ut4Xb3rXPsG899Ll4+tU6okiItZoQng8ESbv/1jJrtS2WcKa29E84nPWldebeVjWCoJV8d380uyypnu0tndxVKEa73X/06Hm9F6MGM0/jQqXnLxauiIMEVu7Mx5zz5AoGBAMfe8UOd3ckObetbSDLi29H/Npnh9G2JEBsWpa+J4eCpddrz7jz5QsVkbjPaz2eVnQ1klbZu+SRwc6ms+QnOqe2/MlbhBBt4XWEEXSZzNL2F2v9jjBR9mh0yAt3IP32tNBAlPEV24x19doa0CdVnxRxRVlpq30gBGgy6SKASkrzg";

    public static String alipayPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnpG+oOS7UhEauERjEa2rYrRCFv/enFQOfB7xZ9EvVzQsoDGqcXaxQtN96G56hwFKLetVt/wpV73TZCHcDXuDLaJGEUnEgtiRC7XnrUB6lzNpIORn+/sMNq4C2qmjfzjJuaPbD1qxz6f5xI75dBfcvdSwA3NB1dHPCorcAyA9DYuV7/us9qCeEGwRSO9Go1uMDBIkYNLUT8PYYgP5K1oki1pWJr8sqi8RxVNjIqiotNsftTR11x2Zb8d8gL5rdfvZ6s0Eooqt+jkrSzK0KIZ4CUWnFPkGBXPpdo+1f94xx8F4nTt9vbkcKQ0E7Er2jXuYzR8KOURBpBCJMOTLK4wOiQIDAQAB";

    public static String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

    public static String notifyUrl = "http://zd82a3f5.natappfree.cc/mall-order/order/notify";

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