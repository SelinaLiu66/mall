package com.selina.mall.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.UserTmp;

/**
 * <p>
 * 会员表 服务类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
public interface IMemberService extends IService<Member> {

    public UserTmp login(String username, String password);
}
