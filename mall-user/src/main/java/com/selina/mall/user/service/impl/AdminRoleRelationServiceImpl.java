package com.selina.mall.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.user.service.IAdminRoleRelationService;
import com.selina.mall.user.entity.AdminRoleRelation;
import com.selina.mall.user.mapper.AdminRoleRelationMapper;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 后台用户和角色关系表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Service
public class AdminRoleRelationServiceImpl extends ServiceImpl<AdminRoleRelationMapper, AdminRoleRelation> implements IAdminRoleRelationService {

}
