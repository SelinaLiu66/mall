package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.ProductCategoryAttributeRelation;
import com.selina.mall.product.mapper.ProductCategoryAttributeRelationMapper;
import com.selina.mall.product.service.IProductCategoryAttributeRelationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类） 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductCategoryAttributeRelationServiceImpl extends ServiceImpl<ProductCategoryAttributeRelationMapper, ProductCategoryAttributeRelation> implements IProductCategoryAttributeRelationService {

}
