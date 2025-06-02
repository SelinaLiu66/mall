package com.selina.mall.user.controller;

import com.selina.mall.user.entity.Region;
import com.selina.mall.user.service.RegionService;
import com.selina.mall.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/region")
//@Tag(name = "地区接口")
public class RegionController {

    @Autowired
    private RegionService regionService;

    @GetMapping("/children")
//    @Operation(summary = "获取子地区")
    public ResponseResult<List<Region>> getChildren(
            @RequestParam(required = false) Integer parentId
    ) {
        parentId = parentId == null ? 0 : parentId;
        return ResponseResult.success(regionService.getChildren(parentId));
    }

    @GetMapping("/chain/{regionId}")
//    @Operation(summary = "获取地区链")
    public ResponseResult<List<Region>> getRegionChain(
            @PathVariable Integer regionId
    ) {
        return ResponseResult.success(regionService.getRegionChain(regionId));
    }
}