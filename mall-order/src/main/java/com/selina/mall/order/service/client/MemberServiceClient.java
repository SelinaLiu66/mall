package com.selina.mall.order.service.client;

//import com.selina.mall.entity.UserTmp;

import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.MemberReceiveAddress;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(value = "mall-user")
public interface MemberServiceClient {
    //    @RequestMapping("/user/detail/{uid}")
//    public UserTmp detail(@PathVariable("uid") int uid);
    @GetMapping("/member/address/valid")
    public MemberReceiveAddress validateAddress(@RequestParam("addressId") Long addressId,
                                                @RequestParam("memberId") Long memberId);

    @GetMapping("/ums/member/validate-user/{memberId}")
    public Member validateUser(@PathVariable("memberId") Long memberId);

    @GetMapping("/member/address/get-default-address/{memberId}")
    public MemberReceiveAddress getDefaultAddress(@PathVariable Long memberId);

    @GetMapping("/member/address/get-all-address/{memberId}")
    public List<MemberReceiveAddress> getAllAddress(@PathVariable Long memberId);
}