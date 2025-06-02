package com.selina.mall.user.service;

import com.selina.mall.user.dto.AddressDTO;
import com.baomidou.mybatisplus.extension.service.IService;
import com.selina.mall.user.dto.AddressVO;
import com.selina.mall.user.entity.MemberReceiveAddress;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 会员收货地址表 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
public interface IMemberReceiveAddressService extends IService<MemberReceiveAddress> {
    //    @Transactional
    AddressVO addAddress(AddressDTO dto);

    List<MemberReceiveAddress> getByMemberId(Long memberId);

    @Transactional
    boolean setDefaultAddress(Long addressId, Long memberId);

    //    @Transactional
}
