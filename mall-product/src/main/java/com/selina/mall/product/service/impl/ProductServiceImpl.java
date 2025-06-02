package com.selina.mall.product.service.impl;

import com.alibaba.cloud.commons.lang.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.product.entity.*;
import com.selina.mall.product.mapper.*;
import com.selina.mall.product.service.IProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.math.RoundingMode;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>
 * 商品信息 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements IProductService {
    @Autowired
    private final ProductMapper productMapper;

    @Autowired
    private BrandMapper brandMapper;
    @Autowired
    private ProductAttributeCategoryMapper attributeCategoryMapper;

    @Autowired
    public ProductServiceImpl(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }

    public List<Product> getProductsByIds(List<Long> productIds) {
        // 数据清洗（去重）
        List<Long> uniqueIds = productIds.stream()
                .distinct()
                .collect(Collectors.toList());

        // 执行查询
        return productMapper.selectBatchIds(uniqueIds);
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Collections.emptyList();
        }
        return productMapper.searchByName("%" + keyword + "%");
    }

    //    private final ProductMapper productMapper;
//    private final BrandMapper brandMapper;
    @Autowired
    private ProductCategoryMapper categoryMapper;
    @Autowired
    private SkuStockMapper skuStockMapper;
    @Autowired
    private ProductAttributeValueMapper attributeValueMapper;
    @Autowired
    private ProductAttributeMapper attributeMapper;
//    @Autowired
//    private final ProductImageMapper productImageMapper;

    @Override
    public GoodsDetailVO getGoodsDetail(Long id) {
        // 1. 查询商品基本信息
        Product product = productMapper.selectById(id);
        if (product == null) {
            return null;
        }

        // 2. 组装基础信息
        GoodsDetailVO vo = new GoodsDetailVO();
        BeanUtils.copyProperties(product, vo);
        vo.setId(product.getId().toString());
        vo.setPrice(product.getPrice().setScale(2, RoundingMode.HALF_UP).toString());
        vo.setOldPrice(product.getOriginalPrice() != null ?
                product.getOriginalPrice().toString() : vo.getPrice());
        vo.setSalesCount(product.getSale());
        vo.setDesc(product.getDescription());
        // 3. 查询并设置品牌信息
        Brand brand = brandMapper.selectById(product.getBrandId());
        if (!ObjectUtils.isEmpty(brand)) {
            vo.setBrand(convertBrand(brand));
        }
        // 4. 处理分类信息
        List<ProductCategory> categories = getProductCategories(product.getProductCategoryId());
        vo.setCategories(convertCategories(categories));

        // 5. 处理规格参数
        // TODO: 键值有为空的情况

//        List<ProductAttribute> specAttrs = attributeMapper.selectSpecAttributes(product.getProductAttributeCategoryId());
//        List<ProductAttributeValue> specValues = attributeValueMapper.selectByProductId(Long.valueOf(product.getId()));
//        System.out.println(buildSpecGroups(specAttrs, specValues));
//        vo.setSpecs(buildSpecGroups(specAttrs, specValues));
//        List<SkuStock> skuStocks = skuStockMapper.selectByProductId(Long.valueOf(product.getId()));

        // 6. 处理SKU
        List<SkuStock> skus = skuStockMapper.selectByProductId(Long.valueOf(product.getId()));
        vo.setSkus(convertSkus(skus));
//        List<String> collect = skus.stream().map(SkuStock::getSpData).collect(Collectors.toList());
//        vo.setSpecs(collect);
        // 7. 商品图片
        vo.setMainPictures(getMainPictures(product));

        // 8. 商品详情
        vo.setDetails(buildGoodsDetails(product));

        // 9. 相似商品（示例实现）
        vo.setSimilarProducts(getSimilarProducts(product));
        return vo;
    }

    private List<String> getMainPictures(Product product) {
        // 处理空值情况
        if (product == null || StringUtils.isBlank(product.getPic())) {
            return Collections.emptyList();
        }

        // 拆分并过滤无效值
        return Arrays.stream(product.getPic().split(","))
                .map(String::trim) // 去除前后空格
                .filter(StringUtils::isNotBlank) // 过滤空字符串
                .collect(Collectors.toList());
    }

    /**
     * 获取相似商品列表
     *
     * @param product 当前商品
     * @return 相似商品VO列表
     */
    private List<GoodsDetailVO.SimilarProduct> getSimilarProducts(Product product) {
        // 1. 基础参数校验
        if (product == null || product.getProductCategoryId() == null) {
            return Collections.emptyList();
        }

        // 2. 查询相似商品（示例策略：同分类+销量排序）
        List<Product> similarProducts = productMapper.selectSimilarProducts(
                product.getProductCategoryId(),
                Long.valueOf(product.getId()), // 排除当前商品
                4 // 获取4个相似商品
        );

        // 3. 转换为VO对象
        return similarProducts.stream()
                .map(this::convertToSimilarProductVO)
                .collect(Collectors.toList());
    }

    /**
     * 商品对象转相似商品VO
     */
    private GoodsDetailVO.SimilarProduct convertToSimilarProductVO(Product product) {
        GoodsDetailVO.SimilarProduct vo = new GoodsDetailVO.SimilarProduct();
        vo.setId(product.getId().toString());
        vo.setName(product.getName());
        vo.setDesc(StringUtils.isNotBlank(product.getSubTitle()) ?
                product.getSubTitle() : product.getKeywords());
        vo.setPrice(product.getPrice().setScale(2, RoundingMode.HALF_UP).toString());
        vo.setPicture(getMainPicture(product)); // 获取首张主图
        return vo;
    }

    /**
     * 获取商品主图（首张）
     */
    private String getMainPicture(Product product) {
        if (StringUtils.isBlank(product.getAlbumPics())) {
            return "";
        }
        String[] pics = product.getAlbumPics().split(",");
        return pics.length > 0 ? pics[0].trim() : "";
    }

    private GoodsDetailVO.BrandVO convertBrand(Brand brand) {
        GoodsDetailVO.BrandVO vo = new GoodsDetailVO.BrandVO();
        vo.setId(brand.getId().toString());
        vo.setName(brand.getName());
        vo.setLogo(brand.getLogo());
        return vo;
    }

    private List<GoodsDetailVO.CategoryVO> convertCategories(List<ProductCategory> categories) {
        return categories.stream().map(c -> {
            GoodsDetailVO.CategoryVO vo = new GoodsDetailVO.CategoryVO();
            vo.setId(c.getId().toString());
            vo.setName(c.getName());
            vo.setLayer(c.getLevel());
            // 处理父级关系
            if (c.getParentId() != null) {
                GoodsDetailVO.CategoryVO parent = new GoodsDetailVO.CategoryVO();
                parent.setId(c.getParentId().toString());
                vo.setParent(parent);
            }
            return vo;
        }).collect(Collectors.toList());
    }

    @Autowired
    private SpecConverter specConverter;

    private List<GoodsDetailVO.SkuVO> convertSkus(List<SkuStock> skus) {
        return skus.stream().map(sku -> {
            GoodsDetailVO.SkuVO vo = new GoodsDetailVO.SkuVO();
            vo.setId(sku.getId().toString());
            vo.setSkuCode(sku.getSkuCode());
            vo.setPrice(sku.getPrice().toString());
            vo.setInventory(sku.getStock());
            vo.setSpecs(sku.getSpData());
//            List<String> collect = skus.stream().map(SkuStock::getSpData).collect(Collectors.toList());
//            vo.setSpecs(collect);
//            // 解析规格JSON
//            if (StringUtils.isNotBlank(sku.getSpData())) {
//                List<SpecGroupVO> specs = specConverter.convertSpecs(Long.valueOf(sku.getProductId()));
//                vo.setSpecs(specs);
//            }
//            if (ObjectUtils.isEmpty(collect)){
//                vo.setSpecs(collect);
//            }
            return vo;
        }).collect(Collectors.toList());
    }

    // 获取分类信息（含父级）
    private List<ProductCategory> getProductCategories(Long categoryId) {
        List<ProductCategory> result = new ArrayList<>();
        ProductCategory current = categoryMapper.selectById(categoryId);
        while (current != null) {
            result.add(current);
            current = current.getParentId() != null ?
                    categoryMapper.selectById(current.getParentId()) : null;
        }
        Collections.reverse(result); // 调整为父级在前
        return result;
    }

    // 构建规格分组
    private List<GoodsDetailVO.SpecGroup> buildSpecGroups(List<ProductAttribute> attrs, List<ProductAttributeValue> values) {
        Map<Integer, ProductAttribute> attrMap = attrs.stream()
                .collect(Collectors.toMap(ProductAttribute::getId, Function.identity()));

        return values.stream()
                // 先过滤掉无效的属性值（对应属性不存在的值）
                .filter(value -> attrMap.containsKey(value.getProductAttributeId()))
                // 按有效属性分组
                .collect(Collectors.groupingBy(ProductAttributeValue::getProductAttributeId))
                .entrySet().stream()
                .map(entry -> {
                    GoodsDetailVO.SpecGroup group = new GoodsDetailVO.SpecGroup();
                    // 这里get()是安全的，因为前面已经过滤过
                    ProductAttribute attr = attrMap.get(entry.getKey());
                    group.setName(attr.getName());
                    group.setValues(entry.getValue().stream()
                            .map(ProductAttributeValue::getValue)
                            .flatMap(value -> Arrays.stream(value.split(",")))
                            .map(String::trim)
                            .filter(s -> !s.isEmpty())
                            .collect(Collectors.toList()));
                    return group;
                })
                .collect(Collectors.toList());
    }

    @Autowired
    private ProductAttributeMapper productAttributeMapper;
    private ProductAttributeValueMapper productAttributeValueMapper;

    // 商品详情处理
    private GoodsDetailVO.GoodsDetail buildGoodsDetails(Product product) {
        GoodsDetailVO.GoodsDetail detail = new GoodsDetailVO.GoodsDetail();

        // 详情图片
//        List<ProductImage> detailImages = product.getAlbumPics();
//        detail.setPictures(detailImages.stream()
//                .map(ProductImage::getUrl)
//                .collect(Collectors.toList()));


        detail.setPictures(Arrays.asList(product.getAlbumPics()));
        // 商品属性
        List<ProductAttributeValue> baseAttrs = attributeValueMapper.selectBaseAttributes(Long.valueOf(product.getId()));
        detail.setProperties(baseAttrs.stream()
                .map(av -> {
                    ProductAttribute attr = attributeMapper.selectById(av.getProductAttributeId());
                    return new GoodsDetailVO.Property(attr.getName(), av.getValue());
                }).collect(Collectors.toList()));

        return detail;
    }
    // 参数属性处理（type=1表示参数属性）
//        List<ProductAttribute> paramAttrs = productAttributeMapper.selectSpecAttributes(product.getProductCategoryId());
//        List<ProductAttributeValue> paramValues = productAttributeValueMapper.selectByProductId(Long.valueOf(product.getId()));
//        List<GoodsDetailVO.Property> properties = buildProperties(paramAttrs, paramValues);
//        detail.setProperties(properties);
//
//        return detail;
//    }

    private List<GoodsDetailVO.Property> buildProperties(List<ProductAttribute> attrs, List<ProductAttributeValue> values) {
        Map<Integer, ProductAttribute> attrMap = attrs.stream()
                .collect(Collectors.toMap(ProductAttribute::getId, Function.identity()));

        return values.stream()
                .filter(value -> attrMap.containsKey(value.getProductAttributeId()))
                .map(value -> {
                    ProductAttribute attr = attrMap.get(value.getProductAttributeId());
                    return new GoodsDetailVO.Property(attr.getName(), value.getValue());
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> getProductsByCategoryId(Long categoryId) {
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("product_category_id", categoryId)
                .eq("publish_status", 1)  // 只查询已上架商品
                .eq("delete_status", 0); // 未删除的商品
        List<Product> list = this.list(queryWrapper);
//        Page<Product> productPage=(Page<Product>)list;
//
//        PageInfo pageInfo = new PageInfo<>(list);
//        pageInfo.setPageNum(page);
//        pageInfo.setPageSize(pageSize);
//        pageInfo.setTotal(productPage.getTotal());
//        System.out.println("list的结果："+list);
        return list;
    }

    @Override
    public List<Product> getFourProductsByCategoryId(Long categoryId) {
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("product_category_id", categoryId)
                .eq("publish_status", 1)  // 只查询已上架商品
                .eq("delete_status", 0); // 未删除的商品
        List<Product> list = this.list(queryWrapper);
        return list;
    }

    @Override
    public List<Hot> getHotProducts() {
//        return productMapper.selectHotProducts();
        List<Product> products = productMapper.selectHotProducts();
        List<Hot> hots = new ArrayList<>();
        for (Product product : products) {
            Hot hot = new Hot();
            hot.setId(product.getId());
            hot.setPicture(product.getPic());
            hot.setAlt("它们最实惠");
            hot.setTitle(product.getSubTitle());
            hots.add(hot);
        }
        return hots;
    }

    public List<Product> getNewProducts() {
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("new_status", 1);
        return productMapper.selectList(queryWrapper);
    }

    public List<Product> getProductsBySkuIds(List<Long> skuIds) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("sku_id", skuIds);
        return productMapper.selectList(queryWrapper);
    }

    public Product getProductsBySkuId(Long skuId) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("sku_id", skuId);
        SkuStock skuStock = skuStockMapper.selectById(skuId);
        return productMapper.selectById(skuStock.getProductId());
    }

    @Override
    public List<Product> getProductsBySubCategoryId(Long categoryId) {
        return productMapper.selectProductsByCategoryId(categoryId);
    }
}

