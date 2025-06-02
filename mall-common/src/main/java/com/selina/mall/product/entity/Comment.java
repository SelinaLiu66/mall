package com.selina.mall.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 商品评价表
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_comment")
@ApiModel(value = "Comment对象", description = "商品评价表")
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("商品id")
    private Integer productId;

    @ApiModelProperty("会员昵称")
    private String memberNickName;

    @ApiModelProperty("商品名称")
    private String productName;

    @ApiModelProperty("评价星数：0->5")
    private Integer star;

    @ApiModelProperty("评价的ip")
    private String memberIp;

    @ApiModelProperty("评价时间")
    private LocalDateTime createTime;

    @ApiModelProperty("是否显示")
    private Integer showStatus;

    @ApiModelProperty("购买时的商品属性")
    private String productAttribute;

    @ApiModelProperty("点赞数")
    private Integer collectCount;

    @ApiModelProperty("阅读次数")
    private Integer readCount;

    @ApiModelProperty("评论内容")
    private String content;

    @ApiModelProperty("上传图片地址，以逗号隔开")
    private String pics;

    @ApiModelProperty("评论用户头像")
    private String memberIcon;

    @ApiModelProperty("回复数量")
    private Integer replayCount;

    private Integer memberId;

    private String productPic;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getMemberNickName() {
        return memberNickName;
    }

    public void setMemberNickName(String memberNickName) {
        this.memberNickName = memberNickName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public String getMemberIp() {
        return memberIp;
    }

    public void setMemberIp(String memberIp) {
        this.memberIp = memberIp;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public Integer getShowStatus() {
        return showStatus;
    }

    public void setShowStatus(Integer showStatus) {
        this.showStatus = showStatus;
    }

    public String getProductAttribute() {
        return productAttribute;
    }

    public void setProductAttribute(String productAttribute) {
        this.productAttribute = productAttribute;
    }

    public Integer getCollectCount() {
        return collectCount;
    }

    public void setCollectCount(Integer collectCount) {
        this.collectCount = collectCount;
    }

    public Integer getReadCount() {
        return readCount;
    }

    public void setReadCount(Integer readCount) {
        this.readCount = readCount;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPics() {
        return pics;
    }

    public void setPics(String pics) {
        this.pics = pics;
    }

    public String getMemberIcon() {
        return memberIcon;
    }

    public void setMemberIcon(String memberIcon) {
        this.memberIcon = memberIcon;
    }

    public Integer getReplayCount() {
        return replayCount;
    }

    public void setReplayCount(Integer replayCount) {
        this.replayCount = replayCount;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id = " + id +
                ", productId = " + productId +
                ", memberNickName = " + memberNickName +
                ", productName = " + productName +
                ", star = " + star +
                ", memberIp = " + memberIp +
                ", createTime = " + createTime +
                ", showStatus = " + showStatus +
                ", productAttribute = " + productAttribute +
                ", collectCount = " + collectCount +
                ", readCount = " + readCount +
                ", content = " + content +
                ", pics = " + pics +
                ", memberIcon = " + memberIcon +
                ", replayCount = " + replayCount +
                ", memberId = " + memberId +
                ", productPic = " + productPic +
                "}";
    }
}
