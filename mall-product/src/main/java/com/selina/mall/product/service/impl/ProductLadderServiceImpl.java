package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.ProductLadder;
import com.selina.mall.product.mapper.ProductLadderMapper;
import com.selina.mall.product.service.IProductLadderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 产品阶梯价格表(只针对同商品) 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductLadderServiceImpl extends ServiceImpl<ProductLadderMapper, ProductLadder> implements IProductLadderService {

}
