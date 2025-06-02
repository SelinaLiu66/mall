package com.selina.mall.product.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.selina.mall.product.entity.PmsBanner;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.service.IPmsBannerService;
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

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 商品轮播图表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-05-04
 */
@RestController
@RequestMapping("/banner")
public class PmsBannerController {
    @Autowired
    private IPmsBannerService bannerService;

//    @ApiOperation("新增轮播图")
//    @PostMapping
//    public Boolean addBanner(@RequestBody PmsBanner banner) {
//        return bannerService.save(banner);
//    }
//
//    @ApiOperation("修改轮播图")
//    @PutMapping
//    public Boolean updateBanner(@RequestBody PmsBanner banner) {
//        return bannerService.updateById(banner);
//    }
//
//    @ApiOperation("删除轮播图")
//    @DeleteMapping("/{id}")
//    public Boolean deleteBanner(@PathVariable Long id) {
//        return bannerService.removeById(id);
//    }

    @ApiOperation("根据ID查询轮播图")
    @GetMapping("/{id}")
    public PmsBanner getBannerById(@PathVariable Long id) {
        return bannerService.getById(id);
    }

//    @ApiOperation("分页查询轮播图")
//    @GetMapping("/page")
//    public Page<PmsBanner> getBannerPage(
//            @RequestParam(defaultValue = "1") Integer current,
//            @RequestParam(defaultValue = "10") Integer size) {
//        return bannerService.page(new Page<>(current, size));
//    }

    @ApiOperation("根据商品ID查询轮播图")
    @GetMapping("/product/{productId}")
    public List<PmsBanner> getByProductId(@PathVariable Long productId) {
        return bannerService.list(new QueryWrapper<PmsBanner>()
                .eq("product_id", productId));
    }


//    public ResponseResult getBanners() {
//        return new ResponseResult(200,"查询成功",bannerService.list());
//    }


    @Autowired
    private StringRedisTemplate redisTemplate;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String BANNER_CACHE_KEY = "banners";

    @ApiOperation("根据ID查询轮播图")
    @GetMapping("/get-banners")
//    @GetMapping("/banners")
    public ResponseResult getBanners() {
        try {
            // 1. 尝试从Redis获取缓存
            String cachedBanners = redisTemplate.opsForValue().get(BANNER_CACHE_KEY);
            if (cachedBanners != null) {
                // 2. 缓存命中，反序列化后返回
                List<Banner> banners = objectMapper.readValue(cachedBanners, new TypeReference<List<Banner>>() {
                });
                return new ResponseResult(200, "查询成功（缓存）", banners);
            }
            // 3. 缓存未命中，查询数据库
            List<PmsBanner> banners = bannerService.list();
            // 4. 将结果序列化并存入Redis，设置1小时过期
            String jsonBanners = objectMapper.writeValueAsString(banners);
            redisTemplate.opsForValue().set(BANNER_CACHE_KEY, jsonBanners, 1, TimeUnit.HOURS);

            return new ResponseResult(200, "查询成功", banners);
        } catch (Exception e) {
            // 异常处理：Redis故障时降级到数据库查询
            List<PmsBanner> banners = bannerService.list();
            return new ResponseResult(200, "查询成功（降级）", banners);
        }
    }

    @Autowired
    private ProductServiceImpl productService;

    // 根据分类id获取商品 根据商品再提取轮播图
    @GetMapping("/getBannersByCategoryId/{id}")
    public ResponseResult getBannersByCategoryId(@PathVariable("id") Long id) {
        List<Product> productsByCategoryId = productService.getFourProductsByCategoryId(id);
        List<PmsBanner> banners = new ArrayList<>();
        for (Product product : productsByCategoryId) {
            PmsBanner pmsBanner = new PmsBanner();
            pmsBanner.setImgUrl(product.getPic());
            pmsBanner.setType((byte) 1);
            pmsBanner.setProductId(Long.valueOf(product.getId()));
            banners.add(pmsBanner);
        }
        return ResponseResult.success(banners);
    }
}
