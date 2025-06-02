package com.selina.mall.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.selina.mall.product.entity.GoodsDetailVO;
import com.selina.mall.product.entity.Hot;
import com.selina.mall.product.entity.Product;

import java.util.List;

/**
 * <p>
 * 商品信息 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
public interface IProductService extends IService<Product> {
    public List<Product> getProductsByIds(List<Long> productIds);

    List<Product> searchProducts(String keyword);

    GoodsDetailVO getGoodsDetail(Long id);

    List<Product> getProductsByCategoryId(Long categoryId);

    List<Product> getFourProductsByCategoryId(Long categoryId);

    List<Hot> getHotProducts();

    List<Product> getProductsBySubCategoryId(Long categoryId);
}
