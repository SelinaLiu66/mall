package com.selina.mall.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.product.entity.*;
import com.selina.mall.product.mapper.BrandMapper;
import com.selina.mall.product.mapper.ProductCategoryAttributeRelationMapper;
import com.selina.mall.product.mapper.ProductCategoryMapper;
import com.selina.mall.product.mapper.ProductMapper;
import com.selina.mall.product.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 产品分类 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class ProductCategoryServiceImpl extends ServiceImpl<ProductCategoryMapper, ProductCategory> implements IProductCategoryService {
    @Autowired
    private ProductCategoryMapper categoryMapper;
    @Autowired
    private BrandMapper brandMapper;
    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductCategoryAttributeRelationMapper relationMapper;

    public ProductCategory getTopCategory(Long id) {
        return categoryMapper.selectById(id);
    }
    // CategoryServiceImpl.java

    // CategoryServiceImpl.java
//    @Override
//    public PageInfo<Product> getSubGoodsList(ProductServiceImpl.CategoryGoodsQuery query) {
//        // 1. 参数校验
//        if (query.getCategoryId() == null) {
//           return null;
//        }
//
//        // 2. 获取所有子分类ID（包含自身）
//        List<Long> categoryIds = categoryMapper.selectAllSubCategoryIds(query.getCategoryId());
//        if (CollectionUtils.isEmpty(categoryIds)) {
////            return new PageResult<>(0L, Collections.emptyList());
//            return null;
//        }
//
//        // 3. 构建分页和排序条件
//        PageHelper.startPage(query.getPage(), query.getPageSize());
//        String orderBy = convertSortField(query.getSortField(), query.getSortOrder());
//        if (StringUtils.isNotBlank(orderBy)) {
//            PageHelper.orderBy(orderBy);
//        }
//
//        // 4. 执行查询
//        List<Product> goodsList = productMapper.selectByCategoryIds(categoryIds);
//
//        // 5. 转换分页结果
//        PageInfo<Product> pageInfo = new PageInfo<>(goodsList);
//        return pageInfo;
//    }
//
//    // 排序字段安全转换
//    private String convertSortField(String originField, String order) {
//        if (StringUtils.isBlank(originField)) return null;
//
//        Map<String, String> fieldMapping = new HashMap<>();
//        fieldMapping.put("salesCount", "sales_count");
//        fieldMapping.put("price", "price");
//        fieldMapping.put("publishTime", "create_time");
//
//        String dbField = fieldMapping.get(originField);
//        if (dbField == null) return null;
//
//        return dbField + " " + ("asc".equalsIgnoreCase(order) ? "ASC" : "DESC");
//    }

    // SubCategoryFilterVO.java
    @Autowired
    private ProductCategoryMapper productCategoryMapper;

    public List<CategoryDTO> getCategoryStructure() {
        List<CategoryDTO> topCategories = productCategoryMapper.selectTopLevelCategories();

        for (CategoryDTO category : topCategories) {
            // 获取子分类
            List<CategoryDTO> children = productCategoryMapper.selectSubCategories(category.getId());
            category.setChildren(children != null && !children.isEmpty() ? children : null);
            List<ProductDTO> products = new ArrayList<>();
            for (CategoryDTO categoryDTO : children) {
                products.addAll(productMapper.selectProductVOsByCategoryId(Long.valueOf(categoryDTO.getId())));
            }
            products = new ArrayList<>(products.subList(0, Math.min(9, products.size())));

            // 获取商品列表
//            List<ProductDTO> products = productMapper.selectProductsByCategoryId(category.getId());
            category.setGoods(products != null && !products.isEmpty() ? products : null);
        }
        return topCategories;
    }

    public ProductCategoryVO getCategoryTree(Long parentId) {
        ProductCategory productCategory = productCategoryMapper.selectByIdLimit(parentId);
        ProductCategoryVO productCategoryVO = categoryConvertToVO(productCategory);
        productCategoryVO.setChildren(buildCategoryTree(parentId));
        return productCategoryVO;
    }

    private List<ProductCategoryVO> buildCategoryTree(Long parentId) {
        // 获取子分类的内容
        List<ProductCategory> categories = categoryMapper.findByParentId(parentId);
        if (CollectionUtils.isEmpty(categories)) return Collections.emptyList();
        List<ProductCategoryVO> productCategoryVOS = categoriesConvertToVO(categories);
        // 根据多个子分类的信息 获取商品信息
        productCategoryVOS.forEach(category -> {
            // 递归构建子分类
            category.setChildren(buildCategoryTree(Long.valueOf(category.getId())));
            // 查询商品
//            LambdaQueryWrapper<Product> query = new LambdaQueryWrapper<>();
//            query.eq(Product::getProductCategoryId, category.getId());
            List<Product> products = productMapper.selectFiveProductsByCategoryId(category.getId());
            category.setGoods(productsConvertToVO(products));
//            QueryWrapper<Product> queryWrapper=new QueryWrapper();
//            queryWrapper.eq("product_category_id",category.getId());
//            List<Product> products = productMapper.selectList(queryWrapper);
//            vo.setGoods(productConvertToVO(products));
        });
        return productCategoryVOS;
    }

    private List<ProductCategoryVO> categoriesConvertToVO(List<ProductCategory> categories) {
        return categories.stream().map(category -> {
            ProductCategoryVO vo = new ProductCategoryVO();
            // 基础字段转换
            vo.setId(Long.valueOf(category.getId()));
            vo.setName(category.getName());
            vo.setPicture(category.getIcon());

            // 递归转换子分类
//            if (CollectionUtils.isNotEmpty(category.getChildren())) {
//                vo.setChildren(convertToVO(category.getChildren()));
//            }

            // 转换商品列表
//            if (CollectionUtils.isNotEmpty(category.getGoods())) {
//                vo.setGoods(category.getGoods().stream().map(product -> {
//                    ProductVO productVO = new ProductVO();
//                    productVO.setId(product.getId());
//                    productVO.setName(product.getName());
//                    productVO.setDesc(product.getDescription()); // 注意字段对应
//                    productVO.setPrice(product.getPrice());
//                    productVO.setPicture(product.getPicture());
//                    productVO.setOrderNum(product.getSort());
//                    return productVO;
//                }).collect(Collectors.toList()));
//            }
            return vo;
        }).collect(Collectors.toList());
    }

    private ProductCategoryVO categoryConvertToVO(ProductCategory category) {
        ProductCategoryVO vo = new ProductCategoryVO();
        // 基础字段转换
        vo.setId(Long.valueOf(category.getId()));
        vo.setName(category.getName());
        vo.setPicture(category.getIcon());

        // 递归转换子分类
//            if (CollectionUtils.isNotEmpty(category.getChildren())) {
//                vo.setChildren(convertToVO(category.getChildren()));
//            }

        // 转换商品列表
//            if (CollectionUtils.isNotEmpty(category.getGoods())) {
//                vo.setGoods(category.getGoods().stream().map(product -> {
//                    ProductVO productVO = new ProductVO();
//                    productVO.setId(product.getId());
//                    productVO.setName(product.getName());
//                    productVO.setDesc(product.getDescription()); // 注意字段对应
//                    productVO.setPrice(product.getPrice());
//                    productVO.setPicture(product.getPicture());
//                    productVO.setOrderNum(product.getSort());
//                    return productVO;
//                }).collect(Collectors.toList()));
//            }
        return vo;
    }

    private List<ProductVO> productsConvertToVO(List<Product> products) {
        List<ProductVO> productVOS = new ArrayList<>();
        for (Product product : products) {
            ProductVO productVO = new ProductVO();
            productVO.setId(Long.valueOf(product.getId()));
            productVO.setName(product.getName());
            productVO.setDesc(product.getDescription());
            productVO.setPrice(product.getPrice());
            productVO.setPicture(product.getPic());
//            productVO.setOrderNum(product.);
            productVOS.add(productVO);
        }
        return productVOS;
    }

    private List<ProductVO> productConvertToVO(List<Product> products) {
        List<ProductVO> productVOS = new ArrayList<>();
        for (Product product : products) {
            ProductVO productVO = new ProductVO();
            productVO.setId(Long.valueOf(product.getId()));
            productVO.setName(product.getName());
            productVO.setDesc(product.getDescription());
            productVO.setPrice(product.getPrice());
            productVO.setPicture(product.getPic());
//            productVO.setOrderNum(product.);
            productVOS.add(productVO);
        }
        return productVOS;
    }
}
