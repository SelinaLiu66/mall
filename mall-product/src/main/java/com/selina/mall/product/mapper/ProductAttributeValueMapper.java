package com.selina.mall.product.mapper;

import com.selina.mall.product.entity.ProductAttributeValue;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 存储产品参数信息的表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductAttributeValueMapper extends BaseMapper<ProductAttributeValue> {
//    @Select("SELECT * FROM pms_product_attribute_value " +
//            "WHERE product_id = #{productId} AND attribute_type = 1")
//        // 1表示规格参数
//    List<ProductAttributeValue> selectSpecValues(@Param("productId") Long productId);

    @Select("SELECT * FROM pms_product_attribute_value " +
            "WHERE product_id = #{productId}")
        // 0表示基础属性
    List<ProductAttributeValue> selectBaseAttributes(@Param("productId") Long productId);

    @Select("SELECT * FROM pms_product_attribute_value WHERE product_id = #{productId}")
    List<ProductAttributeValue> selectByProductId(@Param("productId") Long productId);
}