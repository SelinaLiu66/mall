package com.selina.mall.product.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Data
public class GoodsDetailVO {
    private String id;
    private String name;
    private String spuCode;
    private String desc;
    private String price;
    private String oldPrice;
    private BigDecimal discount;
    private Integer inventory;
    private BrandVO brand;
    private Integer salesCount;
    private List<CategoryVO> categories;
    private List<String> mainPictures;
    private List<String> specs;
    private List<SkuVO> skus;
    private GoodsDetail details;
    private List<SimilarProduct> similarProducts;

    @Data
    public static class GoodsDetail {
        private List<String> pictures;
        private List<Property> properties;
    }

    @Data
    @AllArgsConstructor
    public static class Property {
        private String name;
        private String value;
    }

    @Data
    public static class SimilarProduct {
        private String id;
        private String name;
        private String desc;
        private String price;
        private String picture;
    }

    @Data
    public static class BrandVO {
        private String id;
        private String name;
        private String logo;
    }

    @Data
    public static class CategoryVO {
        private String id;
        private String name;
        private Integer layer;
        private CategoryVO parent;
    }

    @Data
    public static class SkuVO {
        private String id;
        private String skuCode;
        private String price;
        private String oldPrice;
        private Integer inventory;
        private String specs;
//        private List<SpecGroupVO> specs;
    }

    @Data
    public static class SpecGroup {
        private String name;
        private List<String> values;

        @Data
        @AllArgsConstructor
        @Getter
        @Setter
        public static class SpecValue {
            private String name;
//            private String picture; // 根据实际情况添加
        }
    }
}