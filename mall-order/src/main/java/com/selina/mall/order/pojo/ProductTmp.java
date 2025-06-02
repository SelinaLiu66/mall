package com.selina.mall.order.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author SelinaLiu
 */
@TableName("t_product")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductTmp implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer pid;//主键
    @TableField("pname")
    private String pname;//商品名称
    private Double pprice;//商品价格
    private Integer stock;//库存
}
