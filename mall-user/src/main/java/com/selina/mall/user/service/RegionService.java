package com.selina.mall.user.service;

import com.selina.mall.user.entity.Region;
import com.selina.mall.user.mapper.RegionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RegionService {
    private final RegionMapper regionMapper;

    public List<Region> getChildren(Integer parentId) {
        return regionMapper.selectByParentId(parentId);
    }

    // 获取完整地区链（用于回显）
    public List<Region> getRegionChain(Integer regionId) {
        List<Region> chain = new ArrayList<>();
        Region current = regionMapper.selectById(regionId);

        while (current != null) {
            chain.add(current);
            current = regionMapper.selectById(current.getParentId());
        }

        Collections.reverse(chain);
        return chain;
    }
}