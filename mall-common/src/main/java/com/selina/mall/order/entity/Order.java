package com.selina.mall.order.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 订单表
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@TableName("oms_order")
@ApiModel(value = "Order对象", description = "订单表")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("订单id")
    @TableId(value = "id", type = IdType.AUTO)
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("会员ID")
    private Integer memberId;

    @ApiModelProperty("优惠券ID")
    private Integer couponId;

    @ApiModelProperty("订单编号")
    private String orderSn;

    @ApiModelProperty("提交时间")
    private LocalDateTime createTime;

    @ApiModelProperty("用户帐号")
    private String memberUsername;

    @ApiModelProperty("订单总金额")
    @TableField("total_amount")
    private BigDecimal totalAmount;

    @ApiModelProperty("应付金额（实际支付金额）")
    private BigDecimal payAmount;

    @ApiModelProperty("运费金额")
    private BigDecimal freightAmount;

//    @ApiModelProperty("促销优化金额（促销价、满减、阶梯价）")
//    private BigDecimal promotionAmount;

//    @ApiModelProperty("积分抵扣金额")
//    private BigDecimal integrationAmount;

//    @ApiModelProperty("优惠券抵扣金额")
//    private BigDecimal couponAmount;

//    @ApiModelProperty("管理员后台调整订单使用的折扣金额")
//    private BigDecimal discountAmount;

    @ApiModelProperty("支付方式：0->未支付；1->支付宝；2->微信")
    private Integer payType;

//    @ApiModelProperty("订单来源：0->PC订单；1->app订单")
//    private Integer sourceType;

    @ApiModelProperty("订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单")
    private Integer status;

    @ApiModelProperty("订单类型：0->正常订单；1->秒杀订单")
    private Integer orderType;

    @ApiModelProperty("物流公司(配送方式)")
    private String deliveryCompany;

    @ApiModelProperty("物流单号")
    private String deliverySn;

    @ApiModelProperty("自动确认时间（天）")
    private Integer autoConfirmDay;

    @ApiModelProperty("收货人姓名")
    private String receiverName;

    @ApiModelProperty("收货人电话")
    private String receiverPhone;

    @ApiModelProperty("收货人邮编")
    private String receiverPostCode;

    @ApiModelProperty("省份/直辖市")
    private String receiverProvince;

    @ApiModelProperty("城市")
    private String receiverCity;

    @ApiModelProperty("区")
    private String receiverRegion;

    @ApiModelProperty("详细地址")
    private String receiverDetailAddress;

    @ApiModelProperty("订单备注")
    private String note;

    @ApiModelProperty("确认收货状态：0->未确认；1->已确认")
    private Integer confirmStatus;

    @ApiModelProperty("删除状态：0->未删除；1->已删除")
    private Integer deleteStatus;

//    @ApiModelProperty("下单时使用的积分")
//    private Integer useIntegration;

    @ApiModelProperty("支付时间")
    private LocalDateTime paymentTime;

    @ApiModelProperty("发货时间")
    private LocalDateTime deliveryTime;

    @ApiModelProperty("确认收货时间")
    private LocalDateTime receiveTime;

    @ApiModelProperty("评价时间")
    private LocalDateTime commentTime;

    @ApiModelProperty("修改时间")
    private LocalDateTime modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMemberId() {
        return memberId;
    }


    @Override
    public String toString() {
        return "Order{" +
                "id = " + id +
                ", couponId = " + couponId +
                ", memberId = " + memberId +
                ", orderSn = " + orderSn +
                ", createTime = " + createTime +
                ", memberUsername = " + memberUsername +
                ", totalAmount = " + totalAmount +
                ", payAmount = " + payAmount +
                ", freightAmount = " + freightAmount +
                ", payType = " + payType +
                ", status = " + status +
                ", orderType = " + orderType +
                ", deliveryCompany = " + deliveryCompany +
                ", deliverySn = " + deliverySn +
                ", autoConfirmDay = " + autoConfirmDay +
                ", receiverName = " + receiverName +
                ", receiverPhone = " + receiverPhone +
                ", receiverPostCode = " + receiverPostCode +
                ", receiverProvince = " + receiverProvince +
                ", receiverCity = " + receiverCity +
                ", receiverRegion = " + receiverRegion +
                ", receiverDetailAddress = " + receiverDetailAddress +
                ", note = " + note +
                ", confirmStatus = " + confirmStatus +
                ", deleteStatus = " + deleteStatus +
                ", paymentTime = " + paymentTime +
                ", deliveryTime = " + deliveryTime +
                ", receiveTime = " + receiveTime +
                ", commentTime = " + commentTime +
                ", modifyTime = " + modifyTime +
                "}";
    }
}
