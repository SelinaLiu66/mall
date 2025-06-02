package com.selina.mall.order.service.client;

import com.selina.mall.order.pojo.ProductTmp;
import com.selina.mall.order.service.impl.CartServiceImpl;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.entity.SkuStock;
import com.selina.mall.util.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Primary;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Primary
//@FeignClient(value = "shop-product",fallback = ProductServiceClientFallback.class)
@FeignClient(value = "mall-product")
public interface ProductServiceClient {
    @GetMapping("/product/getProduct/{pid}")
    public ProductTmp getProduct(@PathVariable("pid") int pid);

    @GetMapping("/product/testSleuth")
    public String testSleuth();

    @PostMapping("/stock/free")
    public ResponseResult freeStock(@RequestBody List<Map<String, Long>> params);

    @GetMapping("/{id}")
    public ResponseResult detail(@PathVariable Integer id);

//    @PostMapping("/subStock")
//    public ResponseResult subStock(@RequestParam("skuId")Long skuId,@RequestParam("num") Integer num);

    @GetMapping("/skuStock/getSkuStock/{id}")
//    @GetMapping("/api/product/sku/{skuId}")
    public SkuStock getSkuStock(@PathVariable("id") Long id);

    @PostMapping("/infos")
    public Map<Long, CartServiceImpl.SkuInfoVO> getSkuInfoMap(@RequestBody List<Long> skuIds);

    @GetMapping("/sub-stock")
    public Boolean subStock(@RequestParam("skuId") Long skuId, @RequestParam("num") Integer num);

    @GetMapping("/product/get-product-info/{id}")
    public Product getGoodsInfo(@PathVariable Long id);

    @PostMapping("/getProductsInfoBySkuIds")
    public List<Product> getProductsInfoBySkuIds(@RequestParam("skuIds") List<Long> skuIds);

    @GetMapping("/product/getProductBySkuId/{skuId}")
    Product getProductsInfoBySkuId(@PathVariable Long skuId);
}
