package com.selina.mall.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.product.entity.SkuInfoVO;
import com.selina.mall.product.entity.SkuStock;
import com.selina.mall.product.mapper.SkuStockMapper;
import com.selina.mall.product.service.ISkuStockService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * sku的库存 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class SkuStockServiceImpl extends ServiceImpl<SkuStockMapper, SkuStock> implements ISkuStockService {

    @Autowired
    private SkuStockMapper skuStockMapper;

    @Override
    @Transactional(readOnly = true)
    public SkuStock getSkuInfo(Long skuId) {
        // 参数校验
        if (skuId == null || skuId <= 0) {
            throw new IllegalArgumentException("SKU ID 不合法");
        }

        // 查询数据库
        SkuStock sku = skuStockMapper.selectById(skuId);
        // 当前sku不存在
        if (sku == null) {
            return null;
        }
        return sku;
    }

    @Override
    public Map<Long, SkuInfoVO> getSkuInfoMap(List<Long> skuIds) {
        if (skuIds == null || skuIds.isEmpty()) {
            return Map.of();
        }

        // 查询商品信息
        List<SkuStock> skuEntities = skuStockMapper.selectBatchIds(skuIds);

        // 转换为VO并构建映射
        return skuEntities.stream()
                .map(this::convertToVO)
                .collect(Collectors.toMap(SkuInfoVO::getSkuId, item -> item));
    }

    private SkuInfoVO convertToVO(SkuStock entity) {
        SkuInfoVO vo = new SkuInfoVO();
        BeanUtils.copyProperties(entity, vo);
        return vo;
    }
}
