package com.selina.mall.user.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.selina.mall.product.entity.Product;
import com.selina.mall.user.dto.AddressDTO;
import com.selina.mall.user.dto.AddressVO;
import com.selina.mall.user.entity.MemberReceiveAddress;
import com.selina.mall.user.mapper.MemberReceiveAddressMapper;
import com.selina.mall.user.service.impl.MemberReceiveAddressServiceImpl;
import com.selina.mall.util.ResponseResult;
import io.swagger.annotations.ApiOperation;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 会员收货地址表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@RestController
@RequestMapping("/member/address")
public class MemberReceiveAddressController {
    @Autowired
    private MemberReceiveAddressMapper addressMapper;

    @GetMapping("/{memberId}")
    public ResponseResult getAddress(@PathVariable String memberId) {
        QueryWrapper<MemberReceiveAddress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("member_id", Long.valueOf(memberId));
        List<MemberReceiveAddress> memberReceiveAddresses = addressMapper.selectList(queryWrapper);
        CartVo cartVo = new CartVo();
        cartVo.setUserAddresses(memberReceiveAddresses);

        return ResponseResult.success(cartVo);
    }

    @GetMapping("/get-default-address/{memberId}")
    public MemberReceiveAddress getDefaultAddress(@PathVariable Long memberId) {
        QueryWrapper<MemberReceiveAddress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("member_id", memberId);
        queryWrapper.eq("default_status", 0);
        MemberReceiveAddress memberReceiveAddresses = addressMapper.selectList(queryWrapper).get(0);
//        CartVo cartVo = new CartVo();
//        cartVo.setUserAddresses(memberReceiveAddresses);
        return memberReceiveAddresses;
    }

    @GetMapping("/valid")
    public MemberReceiveAddress validateAddress(@RequestParam("addressId") Long addressId,
                                                @RequestParam("memberId") Long memberId) {
        // 参数基础校验
        if (addressId == null || addressId <= 0) {
            throw new IllegalArgumentException("地址ID不合法: " + addressId);
        }
        if (memberId == null || memberId <= 0) {
            throw new IllegalArgumentException("用户ID不合法: " + memberId);
        }

        // 查询地址
        MemberReceiveAddress address = addressMapper.selectById(addressId);
        if (address == null) {
//            log.warn("地址不存在, addressId: {}", addressId);
            return null;
//            throw new Exception(ErrorCode.ADDRESS_NOT_EXIST);
        }

        // 校验所属用户
//        if (!memberId.equals(address.getMemberId())) {
//            log.warn("地址不属于当前用户, addressId: {}, memberId: {}", addressId, memberId);
//            throw new Exception("");
//        }

        // 校验地址状态（假设有删除标记字段）
//        if (address.g() == 1) {
//            log.warn("地址已被删除, addressId: {}", addressId);
//            throw new BusinessException(ErrorCode.ADDRESS_DELETED);
//        }

        // 附加校验：地址完整性（按业务需求添加）
//        validateAddressIntegrity(address);

        return address;
    }

    @GetMapping("/get-all-address/{memberId}")
    public List<MemberReceiveAddress> getAllAddress(@PathVariable Long memberId) {
        QueryWrapper<MemberReceiveAddress> queryWrapper = new QueryWrapper();
        queryWrapper.eq("member_id", memberId);
        System.out.println(addressMapper.selectList(queryWrapper));
        return addressMapper.selectList(queryWrapper);
    }

    @Data
    private class CartVo {
        List<Product> goods;
        List<MemberReceiveAddress> userAddresses;
    }

    @Autowired
    private MemberReceiveAddressServiceImpl addressService;

    @PostMapping("/add")
    public ResponseResult<AddressVO> addAddress(
            @RequestBody AddressDTO dto
//            @RequestHeader("memberId") Long memberId
    ) {
        System.out.println("dto的结果：" + dto);
        return ResponseResult.success(addressService.addAddress(dto));
    }


    @ApiOperation("获取会员地址列表")
    @GetMapping("/list/{memberId}")
    public ResponseResult<List<MemberReceiveAddress>> getAddressList(@PathVariable Long memberId) {
        return ResponseResult.success(addressService.getByMemberId(memberId));
    }

    @ApiOperation("添加地址")
    @PostMapping("/create")
    public ResponseResult<Boolean> addAddress(@Validated @RequestBody MemberReceiveAddress address) {
        return ResponseResult.success(addressService.save(address));
    }

    @ApiOperation("修改地址")
    @PostMapping("/update")
    public ResponseResult<Boolean> updateAddress(@Validated @RequestBody MemberReceiveAddress address) {
        return ResponseResult.success(addressService.updateById(address));
    }

    @ApiOperation("删除地址")
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Boolean> deleteAddress(@PathVariable Long id) {
        return ResponseResult.success(addressService.removeById(id));
    }

    @ApiOperation("设置默认地址")
    @PostMapping("/setDefault")
    public ResponseResult<Boolean> setDefaultAddress(
            @RequestParam Long addressId,
            @RequestParam Long memberId) {
        return ResponseResult.success(addressService.setDefaultAddress(addressId, memberId));
    }
}
