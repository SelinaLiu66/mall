package com.selina.mall.user.entity;

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
 * 积分消费设置
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@TableName("ums_integration_consume_setting")
@ApiModel(value = "IntegrationConsumeSetting对象", description = "积分消费设置")
public class IntegrationConsumeSetting implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("每一元需要抵扣的积分数量")
    private Integer deductionPerAmount;

    @ApiModelProperty("每笔订单最高抵用百分比")
    private Integer maxPercentPerOrder;

    @ApiModelProperty("每次使用积分最小单位100")
    private Integer useUnit;

    @ApiModelProperty("是否可以和优惠券同用；0->不可以；1->可以")
    private Integer couponStatus;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDeductionPerAmount() {
        return deductionPerAmount;
    }

    public void setDeductionPerAmount(Integer deductionPerAmount) {
        this.deductionPerAmount = deductionPerAmount;
    }

    public Integer getMaxPercentPerOrder() {
        return maxPercentPerOrder;
    }

    public void setMaxPercentPerOrder(Integer maxPercentPerOrder) {
        this.maxPercentPerOrder = maxPercentPerOrder;
    }

    public Integer getUseUnit() {
        return useUnit;
    }

    public void setUseUnit(Integer useUnit) {
        this.useUnit = useUnit;
    }

    public Integer getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(Integer couponStatus) {
        this.couponStatus = couponStatus;
    }

    @Override
    public String toString() {
        return "IntegrationConsumeSetting{" +
                "id = " + id +
                ", deductionPerAmount = " + deductionPerAmount +
                ", maxPercentPerOrder = " + maxPercentPerOrder +
                ", useUnit = " + useUnit +
                ", couponStatus = " + couponStatus +
                "}";
    }
}
