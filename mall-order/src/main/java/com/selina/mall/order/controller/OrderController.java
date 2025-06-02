package com.selina.mall.order.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.github.pagehelper.PageInfo;
import com.selina.mall.order.entity.Order;
import com.selina.mall.order.pojo.OrderDetailDTO;
import com.selina.mall.order.pojo.OrderRequest;
import com.selina.mall.order.pojo.OrderVO;
import com.selina.mall.order.pojo.OrderVOFront;
import com.selina.mall.order.service.IOrderService;
import com.selina.mall.order.service.impl.AliPayService;
import com.selina.mall.order.utils.AlipayConfig;
import com.selina.mall.util.ResponseResult;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 订单表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @ApiOperation("提交订单")
    @PostMapping("/create-order")
    public ResponseResult createOrder(@RequestBody OrderRequest orderRequest) {
        try {
            // 下单成功 返回订单编号
            Order order = orderService.submitOrder(orderRequest);
            System.out.println("order:" + order);
            return new ResponseResult(200, "下单成功", order);
        } catch (Exception exception) {
            exception.printStackTrace();
            return new ResponseResult(500, "下单失败", exception.getMessage());
        }
    }

    @GetMapping("/get-order/{orderSn}")
    public ResponseResult getOrder(@PathVariable("orderSn") String orderSn) {
        Order order = orderService.getOrderByOrderSn(orderSn);
        OrderVO orderVO = new OrderVO(order.getId(), order.getMemberId(), order.getTotalAmount());
        return ResponseResult.success(orderVO);
    }


    @Autowired
    private AliPayService aliPayService;

    // 支付配置（推荐放在配置类中）
    private String defaultReturnUrl = "http://localhost:5137/paycallback";

    /**
     * 用户下单:支付宝支付
     * 1、让支付页让浏览器展示
     * 2、支付成功以后，跳转到用户的订单列表页
     *
     * @param orderSn
     * @return
     * @throws AlipayApiException
     */
    @ResponseBody
    @GetMapping(value = "/aliPayOrder", produces = "text/html;charset=UTF-8")
    public String aliPayOrder(@RequestParam("orderSn") String orderSn) throws AlipayApiException {
        try {
            Order order = orderService.getOrderByOrderSn(orderSn);
            System.out.println("order信息：" + order);
            String htmlResult = aliPayService.createPayForm(order);
            System.out.println(htmlResult);
            return htmlResult;
        } catch (Exception e) {
            return "<h3 style='color:red;text-align:center'>支付错误：" + e.getMessage() + "</h3>";
        }
    }

    @GetMapping("/get")
    @ApiOperation("分页查询用户订单")
    public ResponseResult<PageInfo<OrderVOFront>> queryUserOrders(
//            @RequestHeader(name = "Authorization") String token,
            @RequestParam(required = false) Integer orderState,
            @RequestParam Long memberId,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "5") Integer pageSize) {

        // 1. 解析token获取用户ID
//        Long userId = AuthUtil.getUserId(token);

        // 2. 查询订单
        PageInfo<OrderVOFront> result = orderService.queryUserOrders(memberId, orderState, page, pageSize);

        return ResponseResult.success(result);
    }

    //    @PostMapping("/notify")
//    public ResponseResult handleAlipayNotify(HttpServletRequest request) {
//        try {
//            // 1. 将异步通知参数转换为Map
//            Map<String, String> params = convertRequestParamsToMap(request);
//
//            // 2. 验证支付宝签名（防止伪造请求）
//            boolean signVerified = AlipaySignature.rsaCheckV1(
//                    params,
//                    AlipayConfig.alipayPublicKey,
//                    AlipayConfig.charset,
//                    AlipayConfig.signType
//            );
//
//            if (!signVerified) {
//                return ResponseResult.failure("支付宝异步通知验签失败，参数：" + "params");
//            }
//
//            // 3. 解析关键参数
//            String tradeStatus = params.get("trade_status");
//            String outTradeNo = params.get("out_trade_no");
//            String tradeNo = params.get("trade_no"); // 支付宝交易号
//            System.out.println("tradeStatus=" + tradeStatus);
//            System.out.println("outTradeNo=" + outTradeNo);
//            System.out.println("tradeNo=" + tradeNo);
//
//            // 4. 处理交易状态
//            if ("TRADE_SUCCESS".equals(tradeStatus) || "TRADE_FINISHED".equals(tradeStatus)) {
//                // 4.1 根据订单号查询本地订单
//                Order order = orderService.getOrderByOrderSn(outTradeNo);
//                if (order == null) {
//                    return ResponseResult.failure("订单不存在，outTradeNo={}" + outTradeNo);
//                }
//
//                // 4.2 幂等性检查：防止重复处理（已支付订单不再更新）
//                if (order.getStatus() == 0) {
//                    return ResponseResult.success("订单已取消，无需重复处理，outTradeNo={}" + outTradeNo);
//                }
//                if(order.getStatus() == 2){
//                     return ResponseResult.success("订单已支付，无需重复处理，outTradeNo={}" + outTradeNo);
//                }
//
//                System.out.println("订单支付成功的flag");
//                // 4.3 更新订单状态为已支付，并保存支付宝交易号
//                orderService.updateOrderPaid(outTradeNo);
//
//                return ResponseResult.success("订单支付成功，outTradeNo=" + outTradeNo + ",tradeNo=" + tradeNo);
//            }
//
//            // 5. 返回success告知支付宝已处理成功
//            return ResponseResult.success("success");
//        } catch (AlipayApiException e) {
//            return ResponseResult.failure("支付宝通知处理异常" + e);
//        } catch (Exception e) {
//            return ResponseResult.failure("failure,系统异常" + e);
//        }
//    }
    @PostMapping("/notify")
    public String handleAlipayNotify(HttpServletRequest request) {
        System.out.println("handleAlipayNotify");
        try {
            // 1. 将异步通知参数转换为Map
            Map<String, String> params = convertRequestParamsToMap(request);

            // 2. 验证支付宝签名
            boolean signVerified = AlipaySignature.rsaCheckV1(
                    params,
                    AlipayConfig.alipayPublicKey,
                    AlipayConfig.charset,
                    AlipayConfig.signType
            );

            if (!signVerified) {
//            log.error("支付宝异步通知验签失败，参数：{}", params);
                return "failure";
            }

            // 3. 解析关键参数
            String tradeStatus = params.get("trade_status");
            String outTradeNo = params.get("out_trade_no");
            String tradeNo = params.get("trade_no");
            String totalAmount = params.get("total_amount");
            System.out.println("tradeStatus=" + tradeStatus);
            System.out.println("outTradeNo=" + outTradeNo);
            System.out.println("tradeNo=" + tradeNo);
            System.out.println("total_amount=" + totalAmount);

//        log.info("支付宝通知：订单号={}, 交易号={}, 状态={}, 金额={}",
//                outTradeNo, tradeNo, tradeStatus, totalAmount);

            // 4. 处理交易状态
            if ("TRADE_SUCCESS".equals(tradeStatus) || "TRADE_FINISHED".equals(tradeStatus)) {
                // 4.1 查询订单
                Order order = orderService.getOrderByOrderSn(outTradeNo);
                if (order == null) {
//                log.error("订单不存在：{}", outTradeNo);
                    return "failure";
                }

                // 4.2 幂等性检查
                if (order.getStatus() == 2) {
//                log.info("订单已支付，无需处理：{}", outTradeNo);
                    return "success";
                }
                if (order.getStatus() == 0) {
//                log.warn("订单已取消，无法支付：{}", outTradeNo);
                    return "failure";
                }

                // 4.3 金额验证
                if (!order.getPayAmount().toString().equals(totalAmount)) {
//                log.error("金额不匹配！订单金额={}, 通知金额={}",
//                        order.getPayAmount(), totalAmount);
                    return "failure";
                }

                // 4.4 更新订单状态
                boolean success = orderService.updateOrderToPaid(outTradeNo);

                if (success) {
                    // 4.5 清除RabbitMQ延迟消息
                    orderService.cancelDelayedMessage(outTradeNo);
                    return "success";
                } else {
                    return "failure";
                }
            }

            // 5. 其他状态直接返回成功
            return "success";
        } catch (AlipayApiException e) {
//        log.error("支付宝通知处理异常", e);
            return "failure";
        } catch (Exception e) {
//        log.error("系统异常", e);
            return "failure";
        }
    }

    /**
     * 将HttpServletRequest中的参数转换为Map
     */
    private Map<String, String> convertRequestParamsToMap(HttpServletRequest request) {
        Map<String, String> params = new HashMap<>();
        Map<String, String[]> requestParams = request.getParameterMap();

        for (String name : requestParams.keySet()) {
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            params.put(name, valueStr);
        }
        return params;
    }


    @GetMapping("/cancel/{orderNo}")
    public ResponseResult cancelOrder(@PathVariable("orderNo") String orderNo) {
        Order orderByOrderSn = orderService.getOrderByOrderSn(orderNo);
        return orderService.cancelOrder(Long.valueOf(orderByOrderSn.getId()));
    }


    @GetMapping("/detail/{orderNo}")
    @ApiOperation("获取订单详情")
    public ResponseResult<OrderDetailDTO> getOrderDetail(
            @PathVariable("orderNo") String orderNo) {
        try {
            OrderDetailDTO orderDetail = orderService.getOrderDetail(orderNo);
            return ResponseResult.success(orderDetail);

        } catch (Exception e) {
            return ResponseResult.failure(null);
        }
    }

}
