package com.selina.mall.product.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * <p>
 * 热门推荐表
 * </p>
 *
 * @author Selina
 * @since 2025-05-04
 */
@Data
@Getter
@Setter
@ApiModel(value = "Hot对象", description = "热门推荐表")
public class Hot implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("推荐ID")
    private Integer id;

    @ApiModelProperty("图片地址")
    private String picture;

    @ApiModelProperty("推荐标题")
    private String title;

    @ApiModelProperty("推荐描述")
    private String alt;


    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    @Override
    public String toString() {
        return "Hot{" +
                "id = " + id +
                ", picture = " + picture +
                ", title = " + title +
                ", alt = " + alt +
                "}";
    }
}
