package com.selina.mall.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author JiangYingbo
 */
@SuppressWarnings("all")
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_user")
public class UserTmp {
    @TableId(type = IdType.AUTO)
    private Integer uid;//主键
    private String username;//用户名
    private String password;//密码
    private String telephone;//手机号
    @TableField(exist = false)
    private String token;
    @TableField(exist = false)
    private Integer memberId;
}