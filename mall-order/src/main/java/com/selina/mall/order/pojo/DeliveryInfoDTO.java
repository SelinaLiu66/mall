package com.selina.mall.order.pojo;

import lombok.Data;

import java.util.List;

@Data
public class DeliveryInfoDTO {
    private String company;
    private String trackingNo;
    private List<Track> tracks;
}
