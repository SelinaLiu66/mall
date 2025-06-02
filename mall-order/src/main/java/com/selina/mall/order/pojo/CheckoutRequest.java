package com.selina.mall.order.pojo;

import com.selina.mall.order.entity.CartItem;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
public class CheckoutRequest {
    private Long memberId;
    private List<CartItem> cartData;

    // getters and setters
    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public List<CartItem> getCartData() {
        return cartData;
    }

    public void setCartData(List<CartItem> cartData) {
        this.cartData = cartData;
    }
}  