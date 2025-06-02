package com.selina.mall.product.controller;

import com.selina.mall.product.entity.SkuInfoVO;
import com.selina.mall.product.entity.SkuStock;
import com.selina.mall.product.service.impl.SkuStockServiceImpl;
import com.selina.mall.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Min;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * sku的库存 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@RestController
@RequestMapping("/skuStock")
public class SkuStockController {

    @Autowired
    private SkuStockServiceImpl skuStockService;

    //    @Operation(summary = "获取SKU详情")
    @GetMapping("/getSkuStock/{skuId}")
    public SkuStock getSkuStock(
            @PathVariable @Min(1) Long skuId
    ) {
        SkuStock sku = skuStockService.getSkuInfo(skuId);
        return sku;
    }

    @GetMapping("/getSkuStockInfo/{skuId}")
//    @Operation(summary = "获取SKU详情")
    public ResponseResult<SkuStock> getSkuDetail(
            @PathVariable @Min(1) Long skuId
    ) {
        SkuStock sku = skuStockService.getSkuInfo(skuId);
        return new ResponseResult(200, "查询成功", sku);
    }

    @PostMapping("/infos")
    public Map<Long, SkuInfoVO> getSkuInfoMap(@RequestBody List<Long> skuIds) {
        return skuStockService.getSkuInfoMap(skuIds);
    }

    @GetMapping("/sub-stock")
    public Boolean subStock(@RequestParam("skuId") Long skuId, @RequestParam("num") Integer num) {
        SkuStock skuInfo = skuStockService.getSkuInfo(skuId);
        return skuInfo.getStock() - num >= 0;
    }

}
