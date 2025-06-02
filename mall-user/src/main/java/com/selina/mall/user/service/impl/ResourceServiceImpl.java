package com.selina.mall.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.user.service.IResourceService;
import com.selina.mall.user.entity.Resource;
import com.selina.mall.user.mapper.ResourceMapper;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 后台资源表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements IResourceService {

}
