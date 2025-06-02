package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.ProductFullReduction;
import com.selina.mall.product.mapper.ProductFullReductionMapper;
import com.selina.mall.product.service.IProductFullReductionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 产品满减表(只针对同商品) 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductFullReductionServiceImpl extends ServiceImpl<ProductFullReductionMapper, ProductFullReduction> implements IProductFullReductionService {

}
