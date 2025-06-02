package com.selina.mall.user.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.selina.mall.user.entity.Region;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RegionMapper extends BaseMapper<Region> {
    @Select("SELECT * FROM sys_region WHERE parent_id = #{parentId} ORDER BY code ASC")
    List<Region> selectByParentId(Integer parentId);
}