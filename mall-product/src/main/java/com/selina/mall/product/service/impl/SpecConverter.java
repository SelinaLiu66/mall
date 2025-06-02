package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.ProductAttribute;
import com.selina.mall.product.entity.ProductAttributeValue;
import com.selina.mall.product.entity.SpecGroupVO;
import com.selina.mall.product.mapper.ProductAttributeMapper;
import com.selina.mall.product.mapper.ProductAttributeValueMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SpecConverter {
    @Autowired
    private final ProductAttributeMapper attributeMapper;
    private final ProductAttributeValueMapper attributeValueMapper;

    public List<SpecGroupVO> convertSpecs(Long productId) {
        // 1. 查询商品关联的规格属性
        List<ProductAttribute> specAttrs = attributeMapper.selectSpecAttributesByProduct(productId);

        // 2. 查询规格属性值
        List<ProductAttributeValue> attrValues = attributeValueMapper.selectByProductId(productId);

        // 3. 构建分组结构
        return specAttrs.stream().map(attr -> {
            SpecGroupVO group = new SpecGroupVO();
            group.setId(attr.getId().toString());
            group.setName(attr.getName());

            group.setValues(attrValues.stream()
                    .filter(v -> v.getProductAttributeId().equals(attr.getId()))
                    .map(this::convertValue)
                    .collect(Collectors.toList()));

            return group;
        }).collect(Collectors.toList());
    }

    private SpecGroupVO.SpecValueVO convertValue(ProductAttributeValue value) {
        SpecGroupVO.SpecValueVO vo = new SpecGroupVO.SpecValueVO();
        vo.setName(value.getValue());
        vo.setPicture(getSpecImage(value));
        vo.setDesc(buildDescription(value));
        return vo;
    }

    // 示例描述生成逻辑（需根据业务需求调整）
    private String buildDescription(ProductAttributeValue value) {
//        return String.format("%s-%s-%s-规格属性图片",
//            value.getProductCategoryName(),
//            value.getAttributeName(),
//            value.getValue());
        return "规格属性图片";
    }

    // 图片获取逻辑（示例）
    private String getSpecImage(ProductAttributeValue value) {
        // 需要根据业务实现具体图片获取逻辑
        return null;
    }
}