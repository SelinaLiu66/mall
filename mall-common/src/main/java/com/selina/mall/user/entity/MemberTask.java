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
 * 会员任务表
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@TableName("ums_member_task")
@ApiModel(value = "MemberTask对象", description = "会员任务表")
public class MemberTask implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ApiModelProperty("任务名称")
    private String name;

    @ApiModelProperty("赠送成长值")
    private Integer growth;

    @ApiModelProperty("赠送积分")
    private Integer intergration;

    @ApiModelProperty("任务类型：0->新手任务；1->日常任务")
    private Integer type;

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

    public Integer getGrowth() {
        return growth;
    }

    public void setGrowth(Integer growth) {
        this.growth = growth;
    }

    public Integer getIntergration() {
        return intergration;
    }

    public void setIntergration(Integer intergration) {
        this.intergration = intergration;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "MemberTask{" +
                "id = " + id +
                ", name = " + name +
                ", growth = " + growth +
                ", intergration = " + intergration +
                ", type = " + type +
                "}";
    }
}
