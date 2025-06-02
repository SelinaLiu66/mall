package com.selina.mall.product.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.selina.mall.product.entity.*;
import com.selina.mall.product.service.impl.ProductCategoryServiceImpl;
import com.selina.mall.product.service.impl.ProductServiceImpl;
import com.selina.mall.util.ResponseResult;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 产品分类 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/category")
public class ProductCategoryController {
    @Autowired
    private ProductCategoryServiceImpl categoryService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping("/{id}")
    public ResponseResult<ProductCategory> getTopCategory(@PathVariable Long id) {
        return new ResponseResult<>(200, "查询成功", categoryService.getTopCategory(id));
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String HEAD_CACHE_KEY = "head";

    @GetMapping("/head")
    public ResponseResult<List<CategoryDTO>> getCategoryList() {

        try {
            // 1. 尝试从Redis获取缓存
            String cachedBanners = redisTemplate.opsForValue().get(HEAD_CACHE_KEY);
            if (cachedBanners != null) {
                System.out.println("命中缓存~~~~~~~~~");
                // 2. 缓存命中，反序列化后返回
                List<Banner> banners = objectMapper.readValue(cachedBanners, new TypeReference<List<Banner>>() {
                });
                return new ResponseResult(200, "查询成功（缓存）", banners);
            }
            // 3. 缓存未命中，查询数据库
            List<CategoryDTO> categories = categoryService.getCategoryStructure();
            // 4. 将结果序列化并存入Redis，设置1小时过期
            String jsonBanners = objectMapper.writeValueAsString(categories);
            redisTemplate.opsForValue().set(HEAD_CACHE_KEY, jsonBanners, 1, TimeUnit.HOURS);

            return new ResponseResult(200, "查询成功", categories);
        } catch (Exception e) {
            // 异常处理：Redis故障时降级到数据库查询
            List<CategoryDTO> categories = categoryService.getCategoryStructure();
            return new ResponseResult(200, "查询成功（数据库）", categories);
        }
    }

    @GetMapping("/get-product-by-category-id/{categoryId}")
    @ApiOperation("根据分类ID查询商品列表")
    public ResponseResult<List<Product>> listByCategory(@PathVariable Long categoryId) {
        List<Product> productList = productService.getProductsByCategoryId(categoryId);
        return ResponseResult.success(productList);
    }

    @GetMapping("/tree/{parentId}")
    public ResponseResult<ProductCategoryVO> getCategoryTree(@PathVariable("parentId") Long parentId) {
        ProductCategoryVO tree = categoryService.getCategoryTree(parentId);
        System.out.println("输出tree的结果：" + tree);
        return ResponseResult.success(tree);
    }

    @GetMapping("/sub/{id}")
    public ResponseResult getCategoryById(@PathVariable("id") Long id) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("show_status", 1);
        queryWrapper.eq("id", id);
        return ResponseResult.success(categoryService.getOne(queryWrapper));
    }

    @GetMapping("/subGoods/{id}")
    public ResponseResult<List<Product>> getProductBySubCategoryId(@PathVariable("id") Long subCategoryId) {
        List<Product> productList = productService.getProductsBySubCategoryId(subCategoryId);
        return ResponseResult.success(productList);
    }
}
