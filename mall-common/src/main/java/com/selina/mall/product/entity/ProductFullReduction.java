package com.selina.mall.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 产品满减表(只针对同商品)
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_product_full_reduction")
@ApiModel(value = "ProductFullReduction对象", description = "产品满减表(只针对同商品)")
public class ProductFullReduction implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("商品id")
    private Integer productId;

    @ApiModelProperty("满多少元，例如：满399")
    private BigDecimal fullPrice;

    @ApiModelProperty("减多少元，例如：减20")
    private BigDecimal reducePrice;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public BigDecimal getFullPrice() {
        return fullPrice;
    }

    public void setFullPrice(BigDecimal fullPrice) {
        this.fullPrice = fullPrice;
    }

    public BigDecimal getReducePrice() {
        return reducePrice;
    }

    public void setReducePrice(BigDecimal reducePrice) {
        this.reducePrice = reducePrice;
    }

    @Override
    public String toString() {
        return "ProductFullReduction{" +
                "id = " + id +
                ", productId = " + productId +
                ", fullPrice = " + fullPrice +
                ", reducePrice = " + reducePrice +
                "}";
    }
}
