package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.entity.ProductCategory;
import com.selina.mall.product.entity.ProductDTO;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * <p>
 * 商品信息 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface ProductMapper extends BaseMapper<Product> {
    @Select("SELECT * FROM pms_product WHERE name LIKE #{keyword} and delete_status = 0")
    List<Product> searchByName(String keyword);

    @Select("SELECT * FROM pms_product where delete_status = 0  limit 50 order by create_time DESC")
    List<Product> selectBatchIds(@Param("ids") List<Long> ids);


    /**
     * 根据分类ID集合查询商品列表
     *
     * @param categoryIds 分类ID集合
     * @return 商品列表
     */
    @Select({
            "<script>",
            "SELECT id, name, price, old_price AS oldPrice, main_pictures AS mainPictures, ",
            "sales_count AS salesCount, comment_count AS commentCount, collect_count AS collectCount ",
            "FROM product ",
            "WHERE category_id IN ",
            "<foreach collection='categoryIds' item='cid' open='(' separator=',' close=')'>",
            "   #{cid}",
            "</foreach>",
            "AND status = 1  AND delete_status = 0  ",
            "</script>"
    })
    @Results({
            @Result(property = "id", column = "id", id = true),
            @Result(property = "name", column = "name"),
            @Result(property = "price", column = "price"),
            @Result(property = "oldPrice", column = "old_price"),
            @Result(property = "mainPictures", column = "main_pictures"),
            @Result(property = "salesCount", column = "sales_count"),
            @Result(property = "commentCount", column = "comment_count"),
            @Result(property = "collectCount", column = "collect_count")
    })
    List<Product> selectByCategoryIds(@Param("categoryIds") List<Long> categoryIds);

    @Select("SELECT c.*, p.id as parent_id, p.name as parent_name " +
            "FROM pms_product_category c  where delete_status = 0   " +
            "LEFT JOIN pms_product_category p ON c.parent_id = p.id " +
            "WHERE c.id = #{categoryId}")
    List<ProductCategory> selectCategoriesWithParent(@Param("categoryId") Long categoryId);

    @Select({
            "SELECT id, name, sub_title, keywords, price, album_pics, sale",
            "FROM pms_product",
            "WHERE product_category_id = #{categoryId}",
            "  AND id != #{excludeId}",
            "  AND delete_status = 0",
            "  AND publish_status = 1",
            "  AND stock > 0",
            "ORDER BY sale DESC, id DESC",
            "LIMIT #{limit}"
    })
    List<Product> selectSimilarProducts(
            @Param("categoryId") Long categoryId,
            @Param("excludeId") Long excludeId,
            @Param("limit") Integer limit
    );

    @Select("SELECT CAST(id AS CHAR) AS id, name, description AS `desc`, " +
            "FORMAT(price, 2) AS price, pic AS picture " +
            "FROM pms_product " +
            "WHERE product_category_id = #{categoryId} AND publish_status = 1 AND delete_status = 0 ")
    List<ProductDTO> selectProductVOsByCategoryId(@Param("categoryId") Long categoryId);

    @Select("SELECT * " +
            "FROM pms_product " +
            "WHERE product_category_id = #{categoryId} AND publish_status = 1 AND delete_status = 0 ")
    List<Product> selectProductsByCategoryId(@Param("categoryId") Long categoryId);

    @Select("SELECT * " +
            " FROM pms_product " +
            " WHERE product_category_id = #{categoryId} AND  publish_status = 1 " +
            "  AND delete_status = 0 " +
            " ORDER BY sale DESC " +
            " LIMIT 5;")
    List<Product> selectFiveProductsByCategoryId(@Param("categoryId") Long categoryId);

    @Select("SELECT * " +
            " FROM pms_product " +
            " WHERE publish_status = 1 " +
            "  AND delete_status = 0 " +
            " ORDER BY sale DESC " +
            " LIMIT 4;")
    List<Product> selectHotProducts();
}
