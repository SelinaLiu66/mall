package com.selina.mall.order.controller;

import com.selina.mall.order.pojo.CheckoutDTO;
import com.selina.mall.order.pojo.CheckoutInfoVO;
import com.selina.mall.order.service.impl.CheckoutService;
import com.selina.mall.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/checkout")
public class CheckoutController {

    @Autowired
    private CheckoutService checkoutService;

    @PostMapping("/info")
    public ResponseResult getCheckoutInfo(@RequestBody CheckoutDTO checkoutDTO) {
        try {

            CheckoutInfoVO checkoutInfo = checkoutService.getCheckoutInfo(checkoutDTO);
            return ResponseResult.success(checkoutInfo);

        } catch (Exception e) {
            return ResponseResult.failure(e);

        }
    }
}