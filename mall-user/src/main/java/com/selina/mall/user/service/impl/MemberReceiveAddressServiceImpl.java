package com.selina.mall.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.user.dto.AddressDTO;
import com.selina.mall.user.dto.AddressVO;
import com.selina.mall.user.entity.MemberReceiveAddress;
import com.selina.mall.user.mapper.MemberReceiveAddressMapper;
import com.selina.mall.user.service.IMemberReceiveAddressService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 会员收货地址表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Service
public class MemberReceiveAddressServiceImpl extends ServiceImpl<MemberReceiveAddressMapper, MemberReceiveAddress> implements IMemberReceiveAddressService {


    @Autowired
    private MemberReceiveAddressMapper addressMapper;

    //    @Transactional
    @Override
    public AddressVO addAddress(AddressDTO dto) {
        // 处理默认地址
        if (dto.getDefaultStatus()) {
            addressMapper.clearDefaultStatus(Long.valueOf(dto.getMemberId()));
        }

        // 构建实体
        MemberReceiveAddress address = new MemberReceiveAddress();
        BeanUtils.copyProperties(dto, address);
        address.setMemberId(Math.toIntExact(dto.getMemberId()));
        address.setDefaultStatus(dto.getDefaultStatus() ? 1 : 0);

        addressMapper.insert(address);

        // 返回VO对象
        return convertToVO(address);
    }

    private AddressVO convertToVO(MemberReceiveAddress address) {
        AddressVO vo = new AddressVO();
        BeanUtils.copyProperties(address, vo);
        vo.setIsDefault(address.getDefaultStatus() == 1);
        return vo;
    }


    @Override
    public List<MemberReceiveAddress> getByMemberId(Long memberId) {
        return this.lambdaQuery()
                .eq(MemberReceiveAddress::getMemberId, memberId)
                .orderByDesc(MemberReceiveAddress::getDefaultStatus) // 默认地址排前面
                .list();
    }

    @Override
    @Transactional
    public boolean setDefaultAddress(Long addressId, Long memberId) {
        // 1. 将该用户所有地址设为非默认
        this.update(new UpdateWrapper<MemberReceiveAddress>()
                .set("default_status", 0)
                .eq("member_id", memberId));

        // 2. 将指定地址设为默认
        return this.update(new UpdateWrapper<MemberReceiveAddress>()
                .set("default_status", 1)
                .eq("id", addressId)
                .eq("member_id", memberId));
    }
}