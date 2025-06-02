package com.selina.mall.order.service.client.fallback;//package com.selina.mall.order.service.client.fallback;
//
//import com.selina.mall.entity.ProductTmp;
//import com.selina.mall.order.service.client.ProductServiceClient;
//import com.selina.mall.util.ResponseResult;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Map;
//
//@Service
//public class ProductServiceClientFallback implements ProductServiceClient {
//
//    @Override
//    public ProductTmp getProduct(int pid) {
//        ProductTmp productTmp = new ProductTmp();
//        productTmp.setPid(-1);
//        productTmp.setStock(0);
//        return productTmp;
//    }
//
//    @Override
//    public String testSleuth() {
//        return null;
//    }
//
//    @Override
//    public ResponseResult freeStock(List<Map<String, Long>> params) {
//        // TODO: 失败的逻辑
//        return null;
//    }
//
//    @Override
//    public ResponseResult detail(Integer id) {
//        // TODO: 失败的逻辑
//
//        return null;
//    }
//
//    @Override
//    public ResponseResult subStock(Integer pid, Integer num) {
//        // TODO: 失败的逻辑
//
//        return null;
//    }
//}
