package com.selina.mall.user.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 会员表
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@TableName("ums_member")
@ApiModel(value = "Member对象", description = "会员表")
public class Member implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
//
//    @ApiModelProperty("会员等级ID")
//    private Integer memberLevelId;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("密码")
    private String password;

    @ApiModelProperty("昵称")
    private String nickname;

    @ApiModelProperty("手机号码")
    private String phone;

    @ApiModelProperty("帐号启用状态:0->禁用；1->启用")
    private Integer status;

    @ApiModelProperty("注册时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime createTime;

    @ApiModelProperty("头像")
    private String icon;

    @ApiModelProperty("性别：0->未知；1->男；2->女")
    private Integer gender;

    @ApiModelProperty("个性签名")
    private String personalizedSignature;

    @Override
    public String toString() {
        return "Member{" +
                "id = " + id +
//                ", memberLevelId = " + memberLevelId +
                ", username = " + username +
                ", password = " + password +
                ", nickname = " + nickname +
                ", phone = " + phone +
                ", status = " + status +
                ", createTime = " + createTime +
                ", icon = " + icon +
                ", gender = " + gender +
                "}";
    }
}
