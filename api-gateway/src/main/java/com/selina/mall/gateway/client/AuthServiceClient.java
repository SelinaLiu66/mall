package com.selina.mall.gateway.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author SelinaLiu
 */
@FeignClient("shop-user")
public interface AuthServiceClient {
    @RequestMapping("/user/auth/")
    public Object auth(@RequestParam("token") String token);
}
