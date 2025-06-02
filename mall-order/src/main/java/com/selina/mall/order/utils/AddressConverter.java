package com.selina.mall.order.utils;

import com.selina.mall.order.pojo.AddressVO;
import com.selina.mall.user.entity.MemberReceiveAddress;

import java.util.List;
import java.util.stream.Collectors;

public class AddressConverter {

    public static List<AddressVO> convertToAddressVOList(List<MemberReceiveAddress> memberAddressList) {
        return memberAddressList.stream()
                .map(AddressConverter::convertToAddressVO)
                .collect(Collectors.toList());
    }

    private static AddressVO convertToAddressVO(MemberReceiveAddress memberAddress) {
        AddressVO addressVO = new AddressVO();
        addressVO.setId(memberAddress.getId() != null ? memberAddress.getId().longValue() : null);
        addressVO.setProvince(memberAddress.getProvince());
        addressVO.setCity(memberAddress.getCity());
        addressVO.setRegion(memberAddress.getRegion());
        addressVO.setDetailAddress(memberAddress.getDetailAddress());
        addressVO.setName(memberAddress.getName());
        addressVO.setPhoneNumber(memberAddress.getPhoneNumber());
        addressVO.setIsDefault(convertDefaultStatus(memberAddress.getDefaultStatus()));
        return addressVO;
    }

    private static Boolean convertDefaultStatus(Integer defaultStatus) {
        if (defaultStatus == null) return false;
        return defaultStatus == 1; // 根据实际数据库定义判断
    }
}