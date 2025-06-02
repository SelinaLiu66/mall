package com.selina.mall.order.service.impl;

import com.selina.mall.order.pojo.*;
import com.selina.mall.order.service.client.MemberServiceClient;
import com.selina.mall.order.service.client.ProductServiceClient;
import com.selina.mall.order.utils.AddressConverter;
import com.selina.mall.product.entity.Product;
import com.selina.mall.product.entity.SkuStock;
import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.MemberReceiveAddress;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CheckoutService {

//    private final MemberService memberService;
//    private final ProductService productService;
//    private final AddressService addressService;

    @Autowired
    private ProductServiceClient productServiceClient;
    @Autowired
    private MemberServiceClient memberServiceClient;

    public CheckoutInfoVO getCheckoutInfo(CheckoutDTO checkoutDTO) throws Exception {
        // 1. 验证用户
        Member member = memberServiceClient.validateUser(checkoutDTO.getMemberId());

        // 2. 获取地址信息
        List<MemberReceiveAddress> addresses = memberServiceClient.getAllAddress(Long.valueOf(member.getId()));
        List<AddressVO> addressVOS = new ArrayList<>();
        if (addresses != null) {
//            return null;
//        }
            addressVOS = AddressConverter.convertToAddressVOList(addresses);
        }
        //
//        AddressVO defaultAddress = addresses.stream()
//                .filter(AddressVO::getIsDefault)
//                .findFirst()
//                .orElseThrow(() -> new BusinessException("请先设置默认地址"));
        String warningStr = "";
        List<CheckoutGoodsVO> goodsList = new ArrayList<>();

        // 3. 处理商品信息
        for (CartItemDTO item : checkoutDTO.getItems()) {
            SkuStock sku = productServiceClient.getSkuStock(item.getSkuId());
            Product goodsInfo = productServiceClient.getGoodsInfo(Long.valueOf(sku.getProductId()));

            // TODO: 验证价格一致性
//            if (sku.getPrice().compareTo(item.getPrice()) != 0) {
//                throw new BusinessException("商品价格发生变化，请重新确认");
//            }

            // 验证库存
            if (sku.getStock() < item.getCount()) {
                warningStr += (goodsInfo.getName() + "库存不足\n");
                continue;
            }
            goodsList.add(CheckoutGoodsVO.builder()
                    .skuId(item.getSkuId())
                    .name(goodsInfo.getName())
                    .picture(goodsInfo.getPic())
                    .price(sku.getPrice())
                    .count(item.getCount())
                    .totalPrice(sku.getPrice().multiply(BigDecimal.valueOf(item.getCount())))
                    .build());
        }
        if (!ObjectUtils.isEmpty(warningStr)) {
            throw new Exception(warningStr);
        }
//        List<CheckoutGoodsVO> goodsList = checkoutDTO.getItems()
//                .stream().map(item -> {


        // 4. 计算汇总信息
        BigDecimal totalPrice = goodsList.stream()
                .map(CheckoutGoodsVO::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal postFee = calculatePostFee(totalPrice); // 运费计算逻辑
        BigDecimal totalPay = totalPrice.add(postFee);

        return CheckoutInfoVO.builder()
                .memberId(Long.valueOf(member.getId()))
                .userAddresses(addressVOS)
                .goods(goodsList)
                .summary(CheckoutSummaryVO.builder()
                        .goodsCount(goodsList.size())
                        .totalPrice(totalPrice)
                        .postFee(postFee)
                        .totalPayPrice(totalPay)
                        .build())
                .build();
    }

    private BigDecimal calculatePostFee(BigDecimal totalPrice) {
        return totalPrice.compareTo(new BigDecimal("100")) > 0
                ? BigDecimal.ZERO
                : new BigDecimal("12");
    }
}