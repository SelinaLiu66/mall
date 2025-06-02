package com.selina.mall.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.order.controller.CartController;
import com.selina.mall.order.entity.Cart;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 购物车表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-05-03
 */
@Mapper
public interface CartMapper extends BaseMapper<Cart> {
    // 批量删除（根据会员ID和SKU列表）

//        @Delete(" <script>" +
//                " DELETE FROM cart WHERE member_id = #{memberId} and sku_id = #{skuIds} " +
//                " </script>");
//        int deleteByMemberAndSkus(@Param("memberId") Long memberId,
//                                  @Param("skuIds") Long skuIds);

    @Delete("DELETE FROM cart WHERE member_id = #{memberId} AND sku_id = #{skuId}")
    int deleteByMemberAndSku(@Param("memberId") Long memberId,
                             @Param("skuId") Long skuId);

    @Select("SELECT \n" +
            "    c.id,\n" +
            "    -- 获取SKU的首张图片，没有则使用商品封面\n" +
            "    COALESCE(NULLIF(SUBSTRING_INDEX(ss.pic, ',', 1), ''), p.pic) AS picture,\n" +
            "    p.name,\n" +
            "    -- 优先使用SKU促销价，其次SKU原价，最后商品定价\n" +
            "    COALESCE(\n" +
            "        NULLIF(ss.promotion_price, 0),\n" +
            "        ss.price,\n" +
            "        p.price\n" +
            "    ) AS price,\n" +
            "    c.count,\n" +
            "    c.sku_id AS skuId,\n" +
            "    c.selected\n" +
            "FROM cart c\n" +
            "INNER JOIN pms_sku_stock ss ON c.sku_id = ss.id\n" +
            "INNER JOIN pms_product p ON ss.product_id = p.id\n" +
            "WHERE \n" +
            "    c.member_id = #{memberId}\n" +
            "    AND p.delete_status = 0  -- 商品未删除\n" +
            "    AND p.publish_status = 1 -- 商品已上架")
    List<CartController.CartVo> getCartVoByMemberId(@Param("memberId") Long memberId);


    @Delete({
            "<script>",
            "DELETE FROM cart",
            "WHERE member_id = #{memberId}",
            "AND sku_id IN",
            "<foreach collection='skuIds' item='skuId' open='(' separator=',' close=')'>",
            "   #{skuId}",
            "</foreach>",
            "</script>"
    })
    int deleteByMemberAndSkus(@Param("memberId") Long memberId, @Param("skuIds") List<String> skuIds);
}
