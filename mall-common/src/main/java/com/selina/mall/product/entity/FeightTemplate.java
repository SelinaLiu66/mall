package com.selina.mall.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 运费模版
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_feight_template")
@ApiModel(value = "FeightTemplate对象", description = "运费模版")
public class FeightTemplate implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("名称")
    private String name;

    @ApiModelProperty("计费类型:0->按重量；1->按件数")
    private Integer chargeType;

    @ApiModelProperty("首重kg")
    private BigDecimal firstWeight;

    @ApiModelProperty("首费（元）")
    private BigDecimal firstFee;

    @ApiModelProperty("增加重量标准（例如：每增加1Kg）")
    private BigDecimal continueWeight;

    @ApiModelProperty("增加运费（例如：增加5元运费）")
    private BigDecimal continmeFee;

    @ApiModelProperty("目的地（省、市）")
    private String dest;

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

    public Integer getChargeType() {
        return chargeType;
    }

    public void setChargeType(Integer chargeType) {
        this.chargeType = chargeType;
    }

    public BigDecimal getFirstWeight() {
        return firstWeight;
    }

    public void setFirstWeight(BigDecimal firstWeight) {
        this.firstWeight = firstWeight;
    }

    public BigDecimal getFirstFee() {
        return firstFee;
    }

    public void setFirstFee(BigDecimal firstFee) {
        this.firstFee = firstFee;
    }

    public BigDecimal getContinueWeight() {
        return continueWeight;
    }

    public void setContinueWeight(BigDecimal continueWeight) {
        this.continueWeight = continueWeight;
    }

    public BigDecimal getContinmeFee() {
        return continmeFee;
    }

    public void setContinmeFee(BigDecimal continmeFee) {
        this.continmeFee = continmeFee;
    }

    public String getDest() {
        return dest;
    }

    public void setDest(String dest) {
        this.dest = dest;
    }

    @Override
    public String toString() {
        return "FeightTemplate{" +
                "id = " + id +
                ", name = " + name +
                ", chargeType = " + chargeType +
                ", firstWeight = " + firstWeight +
                ", firstFee = " + firstFee +
                ", continueWeight = " + continueWeight +
                ", continmeFee = " + continmeFee +
                ", dest = " + dest +
                "}";
    }
}
