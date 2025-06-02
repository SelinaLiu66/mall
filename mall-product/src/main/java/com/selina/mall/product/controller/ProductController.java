package com.selina.mall.product.controller;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.selina.mall.product.entity.GoodsDetailVO;
import com.selina.mall.product.entity.Hot;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.service.impl.HotServiceImpl;
import com.selina.mall.product.service.impl.ProductServiceImpl;
import com.selina.mall.util.ResponseResult;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * <p>
 * 商品信息 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private HotServiceImpl hotService;
    // TODO： 新建一个Product实体
//    @GetMapping("/search")
//    public ResponseResult<List<ProductTmp>> searchProducts(
//            @RequestParam("query") String query){
//        int page=1;
//        int size =10;
//        String keyword = query.replaceAll("^\"|\"$", "");
//        if (StringUtils.isBlank(keyword)) {
//            return new ResponseResult<>(Constants.SUCCESS,"搜索关键词不能为空",null);
//        }
////        PageHelper.startPage(page, size);
//        List<Product> products = productService.searchProducts(keyword);
//        List<ProductTmp> result = products.stream().map(this::convertToTmp)
//        .collect(Collectors.toList());
//        System.out.println("响应结果："+new ResponseResult<>(Constants.SUCCESS, "查询成功", result));
//        return new ResponseResult<>(Constants.SUCCESS,"查询成功",result);
//    }

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @GetMapping("/home/new")
    public ResponseResult getNews() {
//        List<Long> productIds= Arrays.asList(57l,58l,59l,60l);
        List<Product> products = productService.getNewProducts();
        List<ProductTmp> productTmps = products.stream()
                .map(this::convertToTmp)
                .collect(Collectors.toList());
        return new ResponseResult(200, "查询成功", productTmps);
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String HOT_CACHE_KEY = "hot";

    @GetMapping("/home/hot")
    public ResponseResult getHotProducts() {
//        return new ResponseResult(200,"查询成功",productService.getHotProducts());

        try {
            // 1. 尝试从Redis获取缓存
            String cachedBanners = (String) redisTemplate.opsForValue().get(HOT_CACHE_KEY);
            if (cachedBanners != null) {
                // 2. 缓存命中，反序列化后返回
                List<Banner> banners = objectMapper.readValue(cachedBanners, new TypeReference<List<Banner>>() {
                });
                return new ResponseResult(200, "查询成功（缓存）", banners);
            }
            // 3. 缓存未命中，查询数据库
            List<Hot> hotProducts = productService.getHotProducts();
            // 4. 将结果序列化并存入Redis，设置1小时过期
            String jsonBanners = objectMapper.writeValueAsString(hotProducts);
            redisTemplate.opsForValue().set(HOT_CACHE_KEY, jsonBanners, 1, TimeUnit.HOURS);

            return new ResponseResult(200, "查询成功", hotProducts);
        } catch (Exception e) {
            // 异常处理：Redis故障时降级到数据库查询
            List<Hot> hotProducts = productService.getHotProducts();

            return new ResponseResult(200, "查询成功（降级）", hotProducts);
        }
    }

    @GetMapping("/home/goods")
    public ResponseResult getGoods() {
        return new ResponseResult(200, "查询成功", productService.list());
    }


    @GetMapping("/detail/{id}")
    public ResponseResult<GoodsDetailVO> getGoodsDetail(@PathVariable Long id) {
        // 1. 构建缓存键（冒号分隔是Redis最佳实践）
        String cacheKey = "product:" + id;

        try {
            // 2. 尝试从Redis获取缓存
            String cachedProduct = (String) redisTemplate.opsForValue().get(cacheKey);
            if (cachedProduct != null) {
                // 3. 缓存命中，反序列化返回
                GoodsDetailVO vo = objectMapper.readValue(cachedProduct, new TypeReference<GoodsDetailVO>() {
                });
                return new ResponseResult<>(200, "查询成功（缓存）", vo);
            }

            // 4. 缓存未命中，查询数据库
            GoodsDetailVO vo = productService.getGoodsDetail(id);

            // 5. 序列化并存入Redis（空值缓存防穿透）
            String jsonProduct = vo != null ?
                    objectMapper.writeValueAsString(vo) :
                    "NULL";  // 特殊空值标记
            redisTemplate.opsForValue().set(cacheKey, jsonProduct, 30, TimeUnit.MINUTES);

            return vo != null ?
                    new ResponseResult<>(200, "查询成功", vo) :
                    new ResponseResult<>(404, "商品不存在");  // 根据业务需求调整

        } catch (Exception e) {
            // 6. Redis异常降级处理
//            log.error("Redis操作异常", e);
            GoodsDetailVO vo = productService.getGoodsDetail(id);
            return vo != null ?
                    new ResponseResult<>(200, "查询成功（降级）", vo) :
                    new ResponseResult<>(404, "商品不存在");
        }
    }

    @GetMapping("/get-product-info/{id}")
    public Product getGoodsInfo(@PathVariable Long id) {
        return productService.getById(id);
    }

    @GetMapping("/search")
    public ResponseResult<List<ProductTmp>> searchProducts(
            @RequestParam("query") String query) {

//        Pageable pageable = PageRequest.of(page - 1, size);
        List<Product> products = productService.searchProducts(query);

        List<ProductTmp> productTmps = products.stream()
                .map(this::convertToTmp)
                .collect(Collectors.toList());

        return new ResponseResult(200, "查询成功", productTmps);
    }

    private ProductTmp convertToTmp(Product product) {
        ProductTmp productTmp = new ProductTmp();
        productTmp.setProductId(String.valueOf(product.getId()));
        productTmp.setProductName(product.getName());
        productTmp.setProductDescription(product.getDescription());
        productTmp.setProductPrice(product.getPrice());
        productTmp.setImageUrl(product.getPic());
        productTmp.setSalesCount(product.getStock());
        return productTmp;
    }

    @Data
//    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    static class ProductTmp implements Serializable {
        @JsonProperty("id")
        private String productId;

        @JsonProperty("name")
        private String productName;

        @JsonProperty("desc")
        private String productDescription;

        @JsonFormat(shape = JsonFormat.Shape.STRING)
        @JsonProperty("price")
        private BigDecimal productPrice;

        @JsonProperty("picture")
        private String imageUrl;

        @JsonProperty("orderNum")
        private Integer salesCount;
    }

    @Data
    class SearchQuery {
        private String query;
    }

    @GetMapping("/listByCategory/{id}")
    public ResponseResult<PageInfo<Product>> getProductByCategoryId(
            @PathVariable("id") Long categoryId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {

        List<Product> productList = productService.getProductsByCategoryId(categoryId);
        Page<Product> productPage = (Page<Product>) productList;

        PageInfo pageInfo = new PageInfo<>(productList);
        pageInfo.setPageNum(pageNum);
        pageInfo.setPageSize(pageSize);
        pageInfo.setTotal(productPage.getTotal());
        return ResponseResult.success(pageInfo);
    }

    // 猜你喜欢
    @GetMapping("/relevant")
    public ResponseResult relevant(@RequestParam("limit") int limit) {
        return ResponseResult.success(productService.getNewProducts());
    }

    //    @PostMapping("/getProductsInfoBySkuIds")
//    public List<Product> getProductsInfoBySkuIds(@RequestParam("skuIds")List<Long> skuIds){
//        return productService.getProductsBySkuIds(skuIds);
//    }
    @GetMapping("/getProductBySkuId/{skuId}")
    Product getProductsInfoBySkuId(@PathVariable Long skuId) {
        return productService.getProductsBySkuId(skuId);
    }
}

