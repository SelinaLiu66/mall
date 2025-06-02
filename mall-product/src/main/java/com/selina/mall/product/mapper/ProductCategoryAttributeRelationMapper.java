package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.ProductCategoryAttributeRelation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类） Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductCategoryAttributeRelationMapper extends BaseMapper<ProductCategoryAttributeRelation> {
    /*
    <select id="selectSpecificationsByCategoryId" resultType="CategorySpecification">

     */
    @Select("SELECT \n" +
            "        s.id,\n" +
            "        s.name,\n" +
            "        s.`values`\n" +
            "    FROM category_specification cs\n" +
            "    JOIN specification s ON cs.specification_id = s.id\n" +
            "    WHERE cs.category_id = #{categoryId}")
    List<ProductCategoryAttributeRelation> selectSpecificationsByCategoryId(long categoryId);
}
