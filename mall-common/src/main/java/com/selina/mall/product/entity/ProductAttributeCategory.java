package com.selina.mall.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.io.Serializable;

/**
 * <p>
 * 产品属性分类表
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_product_attribute_category")
@ApiModel(value = "ProductAttributeCategory对象", description = "产品属性分类表")
public class ProductAttributeCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("属性分类名称")
    private String name;

    @ApiModelProperty("属性数量")
    private Integer attributeCount;

    @ApiModelProperty("参数数量")
    private Integer paramCount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAttributeCount() {
        return attributeCount;
    }

    public void setAttributeCount(Integer attributeCount) {
        this.attributeCount = attributeCount;
    }

    public Integer getParamCount() {
        return paramCount;
    }

    public void setParamCount(Integer paramCount) {
        this.paramCount = paramCount;
    }

    @Override
    public String toString() {
        return "ProductAttributeCategory{" +
                "id = " + id +
                ", name = " + name +
                ", attributeCount = " + attributeCount +
                ", paramCount = " + paramCount +
                "}";
    }
}
