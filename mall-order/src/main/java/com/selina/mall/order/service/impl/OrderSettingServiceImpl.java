package com.selina.mall.order.service.impl;

import com.selina.mall.order.entity.OrderSetting;
import com.selina.mall.order.mapper.OrderSettingMapper;
import com.selina.mall.order.service.IOrderSettingService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 订单设置表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class OrderSettingServiceImpl extends ServiceImpl<OrderSettingMapper, OrderSetting> implements IOrderSettingService {

}
