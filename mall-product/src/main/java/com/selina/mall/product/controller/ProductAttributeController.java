package com.selina.mall.product.controller;

import com.selina.mall.product.entity.ProductAttribute;
import com.selina.mall.product.entity.ProductAttributeDTO;
import com.selina.mall.product.service.impl.ProductAttributeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 商品属性参数表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/productAttribute")
public class ProductAttributeController {
    @Autowired
    private ProductAttributeServiceImpl attributeService;

    @PostMapping("/{productId}")
    public ResponseEntity<Void> createAttributes(
            @PathVariable Long productId,
            @RequestBody ProductAttributeDTO dto) {
        attributeService.createProductAttributes(productId, dto);
        return ResponseEntity.ok().build();
    }

    // 获取商品完整属性信息
    @GetMapping("/{productId}/attributes")
    public ResponseEntity<Map<String, Object>> getAttributes(
            @PathVariable Long productId) {
        return ResponseEntity.ok(attributeService.getProductAttributes(productId));
    }

    // 获取简化属性列表
    @GetMapping("/{productId}/attributes/simple")
    public ResponseEntity<List<ProductAttribute>> getSimpleAttributes(
            @PathVariable Long productId) {
        return ResponseEntity.ok(attributeService.getSimpleAttributes(productId));
    }

}
