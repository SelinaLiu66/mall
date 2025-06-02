package com.selina.mall.user.dto;

import lombok.Data;

@Data
public class AddressVO {
    /**
     * 地址ID
     */
    private Long id;

    /**
     * 收货人姓名
     */
    private String name;

    /**
     * 联系电话
     */
    private String phoneNumber;

    /**
     * 省份
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 区县
     */
    private String region;

    /**
     * 详细地址
     */
    private String detailAddress;

    /**
     * 邮政编码
     */
    private String postCode;

    /**
     * 是否默认地址
     */
    private Boolean isDefault;

    /**
     * 完整地址（计算属性）
     */
    public String getFullAddress() {
        return String.join(" ", province, city, region, detailAddress);
    }
}