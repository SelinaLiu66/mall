package com.selina.mall.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.product.entity.ProductAttribute;
import com.selina.mall.product.entity.ProductAttributeCategory;
import com.selina.mall.product.entity.ProductAttributeDTO;
import com.selina.mall.product.entity.ProductAttributeValue;
import com.selina.mall.product.mapper.ProductAttributeMapper;
import com.selina.mall.product.service.IProductAttributeService;
import org.elasticsearch.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 商品属性参数表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductAttributeServiceImpl extends ServiceImpl<ProductAttributeMapper, ProductAttribute> implements IProductAttributeService {

    @Autowired
    private ProductAttributeMapper attributeMapper;

    @Transactional
    public void createProductAttributes(Long productId, ProductAttributeDTO attributeDTO) {
        // 1. 创建属性分类
        ProductAttributeCategory category = new ProductAttributeCategory();
        category.setName(attributeDTO.getCategoryName());
        category.setAttributeCount(1);  // 初始数量
        category.setParamCount(0);
        attributeMapper.insertAttributeCategory(category);

        // 2. 创建属性
        ProductAttribute attribute = new ProductAttribute();
        attribute.setProductAttributeCategoryId(category.getId());
        attribute.setName(attributeDTO.getAttributeName());
        attribute.setSelectType(1);  // 单选
        attribute.setInputType(0);   // 手工录入
        attribute.setSort(1);
        attribute.setFilterType(1);  // 普通筛选
        attribute.setSearchType(1);  // 关键字检索
        attribute.setType(0);       // 规格类型
        attributeMapper.insertAttribute(attribute);

        // 3. 创建属性值
        ProductAttributeValue value = new ProductAttributeValue();
        value.setProductId(Math.toIntExact(productId));
        value.setProductAttributeId(attribute.getId());
        value.setValue(attributeDTO.getAttributeValue());
        attributeMapper.insertAttributeValue(value);

        // 4. 更新商品表
        attributeMapper.updateProductAttributeCategory(productId, Long.valueOf(category.getId()));
    }

    // 获取商品完整属性信息
    public Map<String, Object> getProductAttributes(Long productId) {
        // 获取属性分类信息
        ProductAttributeCategory category = attributeMapper.selectCategoryByProductId(productId);
        if (category == null) {
            throw new ResourceNotFoundException("商品属性分类不存在");
        }

        // 获取属性列表
        List<ProductAttribute> attributes = attributeMapper.selectProductAttributes(productId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("categoryId", category.getId());
        result.put("categoryName", category.getName());
        result.put("attributes", attributes);
        return result;
    }

    // 获取简单属性列表
    public List<ProductAttribute> getSimpleAttributes(Long productId) {
        return attributeMapper.selectSpecAttributes(productId);
    }
}
