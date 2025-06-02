package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.ProductAttributeCategory;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 产品属性分类表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductAttributeCategoryMapper extends BaseMapper<ProductAttributeCategory> {
//    @Select("SELECT\n" +
//            "  attr.name AS attribute_name,\n" +
//            "  attr.type AS attribute_type,\n" +
//            "  val.value AS attribute_value,\n" +
//            "  attr.select_type,\n" +
//            "  attr.input_type\n" +
//            "FROM pms_product_attribute_value val\n" +
//            "INNER JOIN pms_product_attribute attr\n" +
//            "  ON val.product_attribute_id = attr.id\n" +
//            "WHERE val.product_id = 123; -- 替换目标商品ID")
//    List<ProductServiceImpl.GoodsProperty> selectByGoodsId(long id);
}
