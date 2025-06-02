package com.selina.mall.order.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.selina.mall.order.entity.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

//package com.selina.mall.order.service.impl;
//
//import com.alipay.api.AlipayApiException;
//import com.alipay.api.AlipayClient;
//import com.alipay.api.domain.AlipayTradePagePayModel;
//import com.alipay.api.request.AlipayTradePagePayRequest;
//import com.selina.mall.order.entity.Order;
//import com.selina.mall.order.utils.AlipayConfig;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//@Service
//public class AliPayService {
//
//    @Autowired
//    private AlipayClient alipayClient;
//
//    @Autowired
//    private AlipayConfig alipayConfig;
//
//    public String createPayForm(Order order,String redirect) throws AlipayApiException {
//        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
//        request.setReturnUrl(redirect); // 前端同步回调地址
//        request.setNotifyUrl(alipayConfig.getNotifyUrl()); // 异步通知地址从配置读取
//
//        AlipayTradePagePayModel model = new AlipayTradePagePayModel();
//        model.setOutTradeNo(order.getOrderSn());
//        model.setTotalAmount(order.getPayAmount().toString());
//        model.setSubject("订单支付：" + order.getOrderSn());
//        model.setProductCode("FAST_INSTANT_TRADE_PAY");
//
//        request.setBizModel(model);
//        return alipayClient.pageExecute(request).getBody();
//    }
//}
@Service
public class AliPayService {

    @Autowired
    private AlipayClient alipayClient; // 支付宝SDK客户端
    public static String returnUrl = "http://localhost:5173/payBack";

    public static String notifyUrl = "http://dbcc2832.natappfree.cc/mall-order/order/notify";

    public String createPayForm(Order order) {
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", order.getOrderSn());
        bizContent.put("total_amount", order.getPayAmount().toString());
        bizContent.put("subject", "订单支付：" + order.getOrderSn());
        bizContent.put("product_code", "FAST_INSTANT_TRADE_PAY");

        // 3. 设置请求参数
        request.setBizContent(bizContent.toJSONString());
        request.setReturnUrl(returnUrl + "?orderSn=" + order.getOrderSn() + "&payResult=true");
        request.setNotifyUrl(notifyUrl);

        String timestamp = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try {
            // 1. 获取支付宝原始表单
            String form = alipayClient.pageExecute(request).getBody();

            // 2. 包裹完整的 HTML 结构，并增强自动提交逻辑
            return "<!DOCTYPE html>\n" +
                    "<html>\n" +
                    "<head>\n" +
                    "    <meta charset=\"utf-8\">\n" +  // 取消注释此行
                    "    <meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self' https://openapi-sandbox.dl.alipaydev.com; script-src 'unsafe-inline' 'self'\">\n" +
                    "    <title>支付宝支付跳转中...</title>\n" +
                    "    <style>\n" +
                    "        .loading {\n" +
                    "            text-align: center;\n" +
                    "            padding: 50px;\n" +
                    "            font-family: Arial;\n" +
                    "        }\n" +
                    "    </style>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "    <div class=\"loading\">正在安全连接到支付宝...</div>\n" +
                    "    <!-- 支付宝表单 -->\n" +
                    form + "\n" +  // 确保换行避免标签粘连
                    "    <script>\n" +
                    "        function safeSubmit() {\n" +
                    "            const maxRetries = 3;\n" +
                    "            let retries = 0;\n" +
                    "\n" +
                    "            function attemptSubmit() {\n" +
                    "                try {\n" +
                    "                    // 通过表单名称获取元素\n" +
                    "                    const form = document.forms.namedItem('punchout_form');\n" +
                    "                    if (form && form.action.includes('alipay')) {\n" +
                    "                        form.submit();\n" +
                    "                    } else if (retries < maxRetries) {\n" +
                    "                        retries++;\n" +
                    "                        setTimeout(attemptSubmit, 500 * retries);\n" +
                    "                    } else {\n" +
                    "                        throw new Error('表单加载失败，请手动提交');\n" +
                    "                    }\n" +
                    "                } catch (e) {\n" +
                    "                    document.body.innerHTML = \n" +
                    "                        '<h3 style=\"color: red\">支付跳转失败</h3>' +\n" +
                    "                        '<p>错误信息：' + e.message + '</p>' +\n" +
                    "                        '<button onclick=\"window.location.reload()\">点击重试</button>';\n" +
                    "                }\n" +
                    "            }\n" +
                    "            attemptSubmit();\n" +
                    "        }\n" +
                    "\n" +
                    "        // DOM 加载完成后触发\n" +
                    "        document.addEventListener('DOMContentLoaded', () => {\n" +
                    "            setTimeout(safeSubmit, 300);\n" +
                    "        });\n" +
                    "    </script>\n" +
                    "</body>\n" +
                    "</html>";
        } catch (AlipayApiException e) {
            throw new RuntimeException("支付宝接口调用失败", e);
        }
    }
}