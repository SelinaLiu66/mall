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
 * 产品评价回复表
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@TableName("pms_comment_replay")
@ApiModel(value = "CommentReplay对象", description = "产品评价回复表")
public class CommentReplay implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("评论id")
    private Integer commentId;

    @ApiModelProperty("回复评论的会员昵称")
    private String memberNickName;

    @ApiModelProperty("回复评论的会员头像")
    private String memberIcon;

    @ApiModelProperty("回复的内容")
    private String content;

    @ApiModelProperty("时间")
    private LocalDateTime createTime;

    @ApiModelProperty("评论人员类型；0->会员；1->管理员")
    private Integer type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public String getMemberNickName() {
        return memberNickName;
    }

    public void setMemberNickName(String memberNickName) {
        this.memberNickName = memberNickName;
    }

    public String getMemberIcon() {
        return memberIcon;
    }

    public void setMemberIcon(String memberIcon) {
        this.memberIcon = memberIcon;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "CommentReplay{" +
                "id = " + id +
                ", commentId = " + commentId +
                ", memberNickName = " + memberNickName +
                ", memberIcon = " + memberIcon +
                ", content = " + content +
                ", createTime = " + createTime +
                ", type = " + type +
                "}";
    }
}
