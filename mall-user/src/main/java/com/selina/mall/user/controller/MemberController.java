package com.selina.mall.user.controller;

import com.alibaba.csp.sentinel.util.StringUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.selina.mall.constant.Constants;
import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.UserTmp;
import com.selina.mall.user.service.IMemberService;
import com.selina.mall.util.JwtUtil;
import com.selina.mall.util.ResponseResult;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * <p>
 * 会员表 前端控制器
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@RestController
@RequestMapping("/ums/member")
public class MemberController {

    @Autowired
    private IMemberService memberService;

    //    @PostMapping("/login")
//    public ResponseResult login(@RequestBody Member member){
////                                @PathVariable String username, @PathVariable String password){
//
//        ResponseResult result = memberService.login(member.getUsername(), member.getPassword());
//        if(result!=null){
//            // 用户名密码正确 返回token
//            System.out.println(result);
//            return result;
//        }
//        return new ResponseResult(Constants.INVALID_CREDENTIALS,Constants.INVALID_CREDENTIALS_INFO);
//    }
    @ApiOperation("用户登录")
    @PostMapping("/login")
    public ResponseResult login(@RequestBody UserTmp userTmp) {
        UserTmp result = memberService.login(userTmp.getUsername(), userTmp.getPassword());
        if (result != null) {
            return new ResponseResult<>(Constants.SUCCESS, "登录成功", result);
        } else {
            return new ResponseResult<>(402, "用户名或密码错误", null);
        }
    }

    @ApiOperation("注册用户")
    @PostMapping("/register")
    public ResponseResult register(@RequestBody Member member) {

        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("username", member.getUsername());
        long countResult = memberService.count(queryWrapper);
        if (memberService.count(queryWrapper) > 0) {
            return new ResponseResult<>(402, "注册失败，用户名已存在");
        }


        String passText = member.getPassword();
        // 加密密码
        String secretPass = BCrypt.hashpw(passText, BCrypt.gensalt());
        // 更改密码为加密密码
        member.setPassword(secretPass);
        // 设置注册时间
        member.setCreateTime(LocalDateTime.now());
        // 在数据库保存这个对象
        memberService.save(member);
        return new ResponseResult<>(Constants.SUCCESS, "注册成功");
    }

    @GetMapping("/testSleuth")
    @ApiOperation("测试链路追踪")
    public String testSleuth() {

        return "管理员：测试链路追踪";
    }


    @ApiOperation("获取管理员信息")
    @GetMapping("/info")
    public ResponseResult<Member> info(@RequestHeader("Authorization") String token) {
        // 解析令牌返回一个封装了id和用户名的Member对象
        UserTmp userTmp = JwtUtil.parse(token.substring(7));
        Member member = new Member();
        // TODO: 属性赋值
        BeanUtils.copyProperties(userTmp, member);
//        Member = memberService.setPermissionInfo(Member);
        return new ResponseResult<>(Constants.SUCCESS, "查询成功", member);
    }

    @GetMapping("/validate-user/{memberId}")
    public Member validateUser(@PathVariable("memberId") Long memberId) {
        return memberService.getById(memberId);
    }

    @ApiOperation("管理员登出")
    @PostMapping("/logout")
    public ResponseResult logout() {
        // 待开发：去Redis中将保存的token清除（设置过期）
        return new ResponseResult<>(Constants.SUCCESS, "登出成功", null);
    }

    @ApiOperation("查询管理员列表")
    @GetMapping("/list")
    public ResponseResult list(@ApiParam(required = true, defaultValue = "10") @RequestParam int pageSize,
                               @ApiParam(required = true, defaultValue = "1") @RequestParam int pageNum,
                               @ApiParam @RequestParam(required = false) String keyword) {
        QueryWrapper<Member> queryWrapper = new QueryWrapper<>();
        if (!StringUtil.isEmpty(keyword)) {
            queryWrapper.eq("username", keyword).or().eq("nick_name", keyword);
        }
        IPage<Member> pageInfo = memberService.page(new Page<>(pageNum, pageSize), queryWrapper);
        return new ResponseResult<>(Constants.SUCCESS, "查询成功", pageInfo);
    }

    @ApiOperation("修改管理员信息")
    @PostMapping("/update/{id}")
    public ResponseResult update(@RequestBody Member Member, @PathVariable("id") long id) {
        UpdateWrapper updateWrapper = new UpdateWrapper();
        updateWrapper.eq("id", id);
        memberService.update(Member, updateWrapper);
        return new ResponseResult(Constants.SUCCESS, "修改成功");
    }

    @ApiOperation("删除一个管理员")
    @PostMapping("/delete/{id}")
    public ResponseResult delete(@PathVariable("id") long id) {
        memberService.removeById(id);
        return new ResponseResult<>(Constants.SUCCESS, "删除成功");
    }

    @ApiOperation("修改管理员状态")
    @PostMapping("/updateStatus/{id}")
    public ResponseResult updateStatus(@PathVariable("id") long id, @RequestParam int status) {
        UpdateWrapper updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id", id);
        updateWrapper.set("status", status);
        memberService.update(updateWrapper);
        return new ResponseResult<>(Constants.SUCCESS, "修改成功");
    }

//    @ApiOperation("查询管理员角色")
//    @GetMapping("/role/{id}")
//    public ResponseResult role(@PathVariable("id") long id) {
//        List<Role> roles = memberService.getRoleList(id);
//        return new ResponseResult<>(Constants.SUCCESS, "查询成功", roles);
//    }
//
//    @ApiOperation("分配管理员角色")
//    @PostMapping("/role/update")
//    public ResponseResult allocRole(@RequestParam long MemberId, @RequestParam String roleIds) {
//        memberService.allocRole(MemberId, roleIds);
//        return new ResponseResult(Constants.SUCCESS, "修改成功");
//    }


}
