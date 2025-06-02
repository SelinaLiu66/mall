package com.selina.mall.user.entity;

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
 * 后台用户登录日志表
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@TableName("ums_admin_login_log")
@ApiModel(value = "AdminLoginLog对象", description = "后台用户登录日志表")
public class AdminLoginLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("管理员id")
    private Integer adminId;

    @ApiModelProperty("登录时间")
    private LocalDateTime createTime;

    @ApiModelProperty("登录ip")
    private String ip;

    @ApiModelProperty("访问地址")
    private String address;

    @ApiModelProperty("浏览器登录类型")
    private String userAgent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    @Override
    public String toString() {
        return "AdminLoginLog{" +
                "id = " + id +
                ", adminId = " + adminId +
                ", createTime = " + createTime +
                ", ip = " + ip +
                ", address = " + address +
                ", userAgent = " + userAgent +
                "}";
    }
}
