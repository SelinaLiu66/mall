package com.selina.mall.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.selina.mall.order.pojo.CartAddForm;
import com.selina.mall.order.controller.CartController;
import com.selina.mall.order.entity.Cart;
import com.selina.mall.order.pojo.OrderRequest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 购物车表 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-05-03
 */
public interface ICartService extends IService<Cart> {
    // 获取会员购物车
    List<Cart> getCartByMemberId(Long memberId);

    List<CartController.CartVo> getCartVoByMemberId(Long member);

    // 添加/更新购物车

    @Transactional
    boolean addOrUpdateCart(CartAddForm form);

    // 批量删除

    boolean batchDelete(Long memberId, Long skuIds);

    // 合并购物车（登录后合并）
    void mergeCart(Long memberId, List<Cart> carts);

    boolean clearCart(OrderRequest orderRequest);

    //    @Override
//    public List<OrderController.CartItemVO> validateItems(Long memberId, List<OrderController.CheckoutItemDTO> items) {
//        if (items == null || items.isEmpty()) {
//            throw new IllegalArgumentException("结算商品不能为空");
//        }
//
//        // 1. 提取商品ID列表
//        List<Long> skuIds = items.stream()
//                .map(OrderController.CheckoutItemDTO::getSkuId)
//                .collect(Collectors.toList());
//
//        // 2. 远程调用商品服务获取商品信息
//        Map<Long, SkuInfoVO> skuMap = productServiceClient.getSkuInfoMap(skuIds);
//
//        // 3. 验证商品有效性并转换为CartItemVO
//        List<OrderController.CartItemVO> validItems = new ArrayList<>();
//        for (OrderController.CheckoutItemDTO item : items) {
//            Long skuId = item.getSkuId();
//            SkuInfoVO skuInfo = skuMap.get(skuId);
//
//            // 验证商品是否存在
////            if (skuInfo == null) {
////                log.warn("商品不存在, skuId: {}", skuId+"");
////                continue;
////            }
//
////            // 验证商品状态
////            if (!"上架".equals(skuInfo.getStatus())) {
////                log.warn("商品已下架, skuId: {}", skuId);
////                continue;
////            }
//
//            // 验证库存是否充足
//            if (!productServiceClient.subStock(skuId, item.getCount())) {
//                return null;
//            }
//
//            // 构建有效商品项
//            OrderController.CartItemVO cartItem = new OrderController.CartItemVO();
//            cartItem.setSkuId(skuId);
//            cartItem.setTitle(skuInfo.getTitle());
//            cartItem.setImage(skuInfo.getDefaultImage());
//            cartItem.setPrice(skuInfo.getPrice());
//            cartItem.setCount(item.getCount());
//            cartItem.setCheck(true);
//            cartItem.setTotalPrice(skuInfo.getPrice().multiply(BigDecimal.valueOf(item.getCount())));
//
//            // 获取商品销售属性
////            List<String> skuAttr = skuSaleAttrValueFeignService.getSkuSaleAttrValues(skuId);
//
//            cartItem.setSkuAttr(Collections.singletonList(productServiceClient.getSkuStock(item.getSkuId()).getSpData()));
//
//            validItems.add(cartItem);
//        }
//
//        if (validItems.isEmpty()) {
//            return null;
//        }
//
//        return validItems;
//    }
    int removeCartItems(Long memberId, List<String> skuIds);

//    List<OrderController.CartItemVO> validateItems(Long memberId, List<OrderController.CheckoutItemDTO> items);
}