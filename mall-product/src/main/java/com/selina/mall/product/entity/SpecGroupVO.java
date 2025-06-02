package com.selina.mall.product.entity;

import lombok.Data;

import java.util.List;

@Data
public class SpecGroupVO {
    /**
     * 规格组ID（对应pms_product_attribute.id）
     */
    private String id;

    /**
     * 规格组名称（对应pms_product_attribute.name）
     */
    private String name;

    /**
     * 规格值列表
     */
    private List<SpecValueVO> values;
//    private SpecValueVO value;

    @Data
    public static class SpecValueVO {
        /**
         * 规格值名称（对应pms_product_attribute_value.value）
         */
        private String name;

        /**
         * 规格图片（需要关联其他表获取）
         */
        private String picture;

        /**
         * 规格描述（组合生成）
         */
        private String desc;
    }
}