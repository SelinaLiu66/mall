package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.CategoryDTO;
import com.selina.mall.product.entity.ProductCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 产品分类 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductCategoryMapper extends BaseMapper<ProductCategory> {
//    @Select("SELECT * FROM pms_product_category WHERE id = #{id}")
//    ProductCategory selectById(Long id);

    @Select("SELECT c.* FROM pms_product_category gc " +
            "JOIN pms_product_category c ON gc.category_id = c.id " +
            "WHERE gc.goods_id = #{goodsId} ORDER BY c.level")
    List<ProductCategory> selectCategoriesByGoodsId(Long goodsId);

    @Select(
            "WITH RECURSIVE sub_categories AS (" +
                    "   SELECT id, parent_id FROM pms_product_category WHERE id = #{categoryId} and show_status = 1" +
                    "   UNION ALL " +
                    "   SELECT c.id, c.parent_id FROM pms_product_category c  and show_status = 1" +
                    "   INNER JOIN sub_categories sc ON c.parent_id = sc.id" +
                    ") " +
                    "SELECT id FROM sub_categories"
    )
    List<Long> selectAllSubCategoryIds(@Param("categoryId") Long categoryId);

    @Select("SELECT CAST(id AS CHAR) AS id, name, icon FROM pms_product_category WHERE parent_id = 0 and show_status = 1 ")
    List<CategoryDTO> selectTopLevelCategories();

    @Select("SELECT CAST(id AS CHAR) AS id, name, picture FROM pms_product_category WHERE parent_id = #{parentId}")
    List<CategoryDTO> selectSubCategories(String parentId);

    @Select("SELECT * FROM pms_product_category WHERE parent_id = #{parentId} and show_status = 1")
    List<ProductCategory> findByParentId(@Param("parentId") Long parentId);

    @Select("SELECT * FROM pms_product_category WHERE id = #{id} and show_status =1 limit 5")
    ProductCategory selectByIdLimit(Long id);
}



/*

https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg
https://yanxuan-item.nosdn.127.net/c41003c6df90d7673195dcc2482e13f3.jpg
https://yanxuan-item.nosdn.127.net/a6939f41c48fa9e9c8f7a7ed855351f1.jpg
https://yanxuan-item.nosdn.127.net/0b120e1c37f312981f4f2242997cc862.png
https://yanxuan-item.nosdn.127.net/7d1bc78607a08c088b2a7cdbe88c05af.png
https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg
https://yanxuan-item.nosdn.127.net/8f0c15f981c5cbcb1aa17215a259fa62.png





 */