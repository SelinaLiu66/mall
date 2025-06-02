package com.selina.mall.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.product.entity.Brand;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 品牌表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface BrandMapper extends BaseMapper<Brand> {

    @Select("SELECT DISTINCT b.* \n" +
            "    FROM goods g\n" +
            "    JOIN category_brand cb ON g.brand_id = cb.brand_id\n" +
            "    JOIN brand b ON g.brand_id = b.id\n" +
            "    WHERE cb.category_id = #{categoryId}\n" +
            "    LIMIT 100")
    List<Brand> selectBrandsByCategoryId(long categoryId);
}
