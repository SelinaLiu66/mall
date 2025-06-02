package com.selina.mall.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.user.entity.MemberReceiveAddress;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

/**
 * <p>
 * 会员收货地址表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Mapper
public interface MemberReceiveAddressMapper extends BaseMapper<MemberReceiveAddress> {
    @Update("UPDATE ums_member_receive_address SET default_status = 0 WHERE member_id = #{memberId}")
    void clearDefaultStatus(Long memberId);
}
