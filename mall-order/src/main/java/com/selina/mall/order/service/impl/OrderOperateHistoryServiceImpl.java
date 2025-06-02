package com.selina.mall.order.service.impl;

import com.selina.mall.order.entity.OrderOperateHistory;
import com.selina.mall.order.mapper.OrderOperateHistoryMapper;
import com.selina.mall.order.service.IOrderOperateHistoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 订单操作历史记录 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class OrderOperateHistoryServiceImpl extends ServiceImpl<OrderOperateHistoryMapper, OrderOperateHistory> implements IOrderOperateHistoryService {

}
