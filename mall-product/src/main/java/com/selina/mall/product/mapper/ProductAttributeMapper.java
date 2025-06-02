package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.GoodsDetailVO;
import com.selina.mall.product.entity.ProductAttribute;
import com.selina.mall.product.entity.ProductAttributeCategory;
import com.selina.mall.product.entity.ProductAttributeValue;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * <p>
 * 商品属性参数表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductAttributeMapper extends BaseMapper<ProductAttribute> {
    @Select("SELECT * FROM pms_product_attribute " +
            "WHERE product_attribute_category_id = #{categoryId} " +
            "AND type = 0 " +
            "ORDER BY sort ASC")
    List<ProductAttribute> selectSpecAttributes(@Param("categoryId") Long categoryId);

    @Select({
            "SELECT pa.*",
            "FROM pms_product_attribute pa",
            "INNER JOIN pms_product_attribute_value pav ON pa.id = pav.product_attribute_id",
            "WHERE pav.product_id = #{productId}",
            "  AND pa.type = 0",
            "GROUP BY pa.id"
    })
    List<ProductAttribute> selectSpecAttributesByProduct(@Param("productId") Long productId);


    // 根据商品ID查询属性列表
    @Select("SELECT " +
            "a.id AS attributeId, " +
            "a.name AS attributeName, " +
            "v.value AS attributeValue, " +
            "a.select_type AS selectType, " +
            "a.input_type AS inputType, " +
            "a.input_list AS inputList " +
            "FROM pms_product_attribute_value v " +
            "JOIN pms_product_attribute a ON v.product_attribute_id = a.id " +
            "WHERE v.product_id = #{productId}")
    List<ProductAttribute> selectProductAttributes(Long productId);

    // 查询属性分类信息
    @Select("SELECT c.* FROM pms_product p " +
            "JOIN pms_product_attribute_category c ON p.product_attribute_category_id = c.id " +
            "WHERE p.id = #{productId}")
    ProductAttributeCategory selectCategoryByProductId(Long productId);

    // 属性分类
    @Insert("INSERT INTO pms_product_attribute_category(name, attribute_count, param_count) " +
            "VALUES(#{name}, #{attributeCount}, #{paramCount})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertAttributeCategory(ProductAttributeCategory category);

    // 商品属性
    @Insert("INSERT INTO pms_product_attribute(product_attribute_category_id, name, select_type, " +
            "input_type, sort, filter_type, search_type, type) " +
            "VALUES(#{productAttributeCategoryId}, #{name}, #{selectType}, #{inputType}, " +
            "#{sort}, #{filterType}, #{searchType}, #{type})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertAttribute(ProductAttribute attribute);

    // 属性值
    @Insert("INSERT INTO pms_product_attribute_value(product_id, product_attribute_id, value) " +
            "VALUES(#{productId}, #{productAttributeId}, #{value})")
    int insertAttributeValue(ProductAttributeValue value);

    // 更新商品属性分类ID
    @Update("UPDATE pms_product SET product_attribute_category_id = #{categoryId} WHERE id = #{productId}")
    int updateProductAttributeCategory(@Param("productId") Long productId,
                                       @Param("categoryId") Long categoryId);

    @Select("SELECT \n" +
            "    pa.name AS name,\n" +
//            "    pa.type AS attribute_type,\n" +
//            "    pa.select_type,\n" +
//            "    pa.input_type,\n" +
//            "    pa.input_list,\n" +
            "    pav.value AS value\n" +
            "FROM \n" +
            "    pms_product p\n" +
            "INNER JOIN \n" +
            "    pms_product_attribute_category pac \n" +
            "    ON p.product_attribute_category_id = pac.id\n" +
            "INNER JOIN \n" +
            "    pms_product_attribute pa \n" +
            "    ON pac.id = pa.product_attribute_category_id\n" +
            "INNER JOIN \n" +
            "    pms_product_attribute_value pav \n" +
            "    ON pa.id = pav.product_attribute_id \n" +
            "    AND p.id = pav.product_id\n" +
            "WHERE \n" +
            "    p.id = #{productId}\n" +
            "ORDER BY \n" +
            "    pa.sort DESC;")
    List<GoodsDetailVO.SpecGroup> selectByProductId(int productId);
}
