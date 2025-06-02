package com.selina.mall.product.service;

import com.selina.mall.product.entity.SkuInfoVO;
import com.selina.mall.product.entity.SkuStock;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * sku的库存 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
public interface ISkuStockService extends IService<SkuStock> {
    public SkuStock getSkuInfo(Long skuId);

    Map<Long, SkuInfoVO> getSkuInfoMap(List<Long> skuIds);
}
