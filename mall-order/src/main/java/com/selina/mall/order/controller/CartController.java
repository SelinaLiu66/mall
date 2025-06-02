package com.selina.mall.order.controller;

import com.selina.mall.constant.Constants;
import com.selina.mall.order.entity.Cart;
import com.selina.mall.order.pojo.CartAddForm;
import com.selina.mall.order.pojo.CartRemoveRequest;
import com.selina.mall.order.service.impl.CartServiceImpl;
import com.selina.mall.util.ResponseResult;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

/**
 * <p>
 * 购物车表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-05-03
 */


/**
 * <p>
 * 购物车表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */

@RestController
@RequestMapping("/order/cart")
@RequiredArgsConstructor
public class CartController {
    @Autowired
    private CartServiceImpl cartService;


    // 获取购物车列表
    @GetMapping("/{memberId}")
    public ResponseResult<List<CartVo>> getCart(@PathVariable Long memberId) {
        List<CartVo> result = cartService.getCartVoByMemberId(memberId);
        return new ResponseResult<>(Constants.SUCCESS, "查询成功", result);
    }

    @Data
    public static class CartVo {  // 添加 static 修饰符
        private Long id;         // 数据库是 BIGINT → Java 用 Long
        private String picture;
        private String name;
        private BigDecimal price;
        private Integer count;  // 建议用包装类型（避免 null 转换问题）
        private Long skuId;      // 数据库是 BIGINT → Java 用 Long
        private Boolean selected; // 使用包装类型更安全
    }

    // 添加商品到购物车
    @PostMapping("/add")
    public ResponseResult addCart(@RequestBody CartAddForm form) {
        if (cartService.addOrUpdateCart(form)) {
            return new ResponseResult<>(Constants.SUCCESS, "添加成功");
        } else {
            return new ResponseResult<>(Constants.FAILURE, "添加失败");
        }
    }

    // 批量删除
    @DeleteMapping("/delete")
    public ResponseResult deleteCart0s(@RequestBody CartDeleteForm form) {
        System.out.println("form的内容：" + form);
        if (cartService.batchDelete(form.getMemberId(), form.getIds())) {
            return ResponseResult.success("删除成功");
        }
        return ResponseResult.failure("删除失败");
    }

    // 合并购物车
    @PostMapping("/merge")
    public ResponseResult<Void> mergeCart(@RequestBody CartMergeForm form) {
        cartService.mergeCart(form.getMemberId(), form.getItems());
        return new ResponseResult();
    }

    @PostMapping("/remove")
    public ResponseResult<?> removeCartItems(
            @RequestBody CartRemoveRequest request
    ) {
        // 参数校验
        if (request.getMemberId() == null || request.getSkuIds() == null || request.getSkuIds().isEmpty()) {
            return ResponseResult.failure("参数错误");
        }

        // 鉴权（建议从token解析memberId）
//        Long actualMemberId = JwtUtils.parseMemberId(token);
//        if (!actualMemberId.equals(request.getMemberId())) {
//            return ResponseResult.status(HttpStatus.FORBIDDEN).body(new ErrorResponse("无权操作"));
//        }

        // 业务处理
        int removedCount = cartService.removeCartItems(request.getMemberId(), request.getSkuIds());

        return ResponseResult.success((removedCount));
    }
}

@Data
class CartDeleteForm {
    private Long memberId;
    private Long ids;
}

@Data
class CartMergeForm {
    private Long memberId;
    private List<Cart> items;
}

