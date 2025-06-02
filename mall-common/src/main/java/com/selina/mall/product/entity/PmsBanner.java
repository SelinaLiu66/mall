package com.selina.mall.product.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * <p>
 * 商品轮播图表
 * </p>
 *
 * @author Selina
 * @since 2025-05-04
 */
@TableName("pms_banner")
@ApiModel(value = "PmsBanner对象", description = "商品轮播图表")
public class PmsBanner implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("轮播图ID")
    private Long id;

    @ApiModelProperty("图片地址")
    private String imgUrl;

    @ApiModelProperty("类型（1-商品轮播）")
    private Byte type;

    @ApiModelProperty("关联商品ID")
    private Long productId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return "PmsBanner{" +
                "id = " + id +
                ", imgUrl = " + imgUrl +
                ", type = " + type +
                ", productId = " + productId +
                "}";
    }
}
