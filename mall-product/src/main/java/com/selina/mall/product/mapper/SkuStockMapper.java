package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.SkuStock;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * sku的库存 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface SkuStockMapper extends BaseMapper<SkuStock> {
    @Select("SELECT * FROM pms_sku_stock WHERE product_id = #{productId}")
    List<SkuStock> selectByProductId(@Param("productId") Long productId);

    @Select("select sp_data from pms_sku_stock wher product_id = #{productId")
    List<String> selectPropertiesByProductId(@Param("prductId") Long productId);
}
