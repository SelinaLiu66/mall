package com.selina.mall.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.order.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * <p>
 * 订单表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Mapper
public interface OrderMapper extends BaseMapper<Order> {

    @Update("update oms_order set status = 2 where order_sn=${orderSn}")
    void updateOrderPaidByOrderSn(@Param("orderSn") String orderSn);

    // 查询订单列表
    @Select("select * from oms_order where member_id=#{userId} order by create_time DESC")
    List<Order> selectOrdersByUserId(
            @Param("userId") Long userId);
}
