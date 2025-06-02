package com.selina.mall.user.dto;

import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddressDTO {
    private String name;
    private String phoneNumber;
    private String province;
    private String city;
    private String region;
    private String detailAddress;
    private String postCode;
    private Boolean defaultStatus; // 保持 Boolean 类型

    private Integer memberId;
    // getters and setters
}