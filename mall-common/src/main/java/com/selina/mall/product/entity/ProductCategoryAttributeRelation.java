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
 * 产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_product_category_attribute_relation")
@ApiModel(value = "ProductCategoryAttributeRelation对象", description = "产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）")
public class ProductCategoryAttributeRelation implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("商品类别id")
    private Integer productCategoryId;

    @ApiModelProperty("商品属性id")
    private Integer productAttributeId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(Integer productCategoryId) {
        this.productCategoryId = productCategoryId;
    }

    public Integer getProductAttributeId() {
        return productAttributeId;
    }

    public void setProductAttributeId(Integer productAttributeId) {
        this.productAttributeId = productAttributeId;
    }

    @Override
    public String toString() {
        return "ProductCategoryAttributeRelation{" +
                "id = " + id +
                ", productCategoryId = " + productCategoryId +
                ", productAttributeId = " + productAttributeId +
                "}";
    }
}
