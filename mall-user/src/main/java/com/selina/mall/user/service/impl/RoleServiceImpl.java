package com.selina.mall.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.user.service.IRoleService;
import com.selina.mall.user.entity.Role;
import com.selina.mall.user.mapper.RoleMapper;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 后台用户角色表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

}
