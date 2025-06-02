package com.selina.mall.order.pojo;

import lombok.Data;

@Data
public class AddressVO {
    private Long id;
    private String province;
    private String city;
    private String region;
    private String detailAddress;
    private String name;
    private String phoneNumber;
    private Boolean isDefault;
}
