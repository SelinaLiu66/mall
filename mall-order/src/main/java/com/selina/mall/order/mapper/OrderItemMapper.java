package com.selina.mall.order.mapper;

import com.selina.mall.order.entity.OrderItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 订单中所包含的商品 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface OrderItemMapper extends BaseMapper<OrderItem> {
    // 查询订单项
    @Select("SELECT *  FROM oms_order_item" +
            "    WHERE order_id = #{orderId}")
    List<OrderItem> selectItemsByOrderId(Long orderId);
}
