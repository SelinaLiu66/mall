package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.PmsBanner;
import com.selina.mall.product.mapper.PmsBannerMapper;
import com.selina.mall.product.service.IPmsBannerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 商品轮播图表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-05-04
 */
@Service
public class PmsBannerServiceImpl extends ServiceImpl<PmsBannerMapper, PmsBanner> implements IPmsBannerService {

//    @Autowired
//    private PmsBannerMapper bannerMapper;
//    @Override
//    public List<PmsBanner> getAll() {
//        return bannerMapper.selectList();
//    }
}
