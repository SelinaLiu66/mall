package com.selina.mall.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.user.entity.RolePermissionRelation;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 后台用户角色和权限关系表 Mapper 接口
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Mapper
public interface RolePermissionRelationMapper extends BaseMapper<RolePermissionRelation> {

}
