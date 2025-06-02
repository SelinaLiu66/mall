package com.selina.mall.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.selina.mall.user.entity.Member;
import com.selina.mall.user.entity.UserTmp;
import com.selina.mall.user.mapper.MemberMapper;
import com.selina.mall.user.mapper.MenuMapper;
import com.selina.mall.user.mapper.RoleMapper;
import com.selina.mall.user.service.IMemberService;
import com.selina.mall.util.JwtUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 会员表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-26
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberMapper, Member> implements IMemberService {

    @Autowired
    private MenuMapper menuMapper;
    @Autowired
    private RoleMapper roleMapper;
    //    @Autowired
//    private MemberRoleRelationMapper memberRoleRelationMapper;
    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public UserTmp login(String username, String password) {
        QueryWrapper queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        // 状态为0表示无法登录
        queryWrapper.eq("status", 1);
        Member member = getOne(queryWrapper);
        // userTmp == null 说明用户名不存在
        if (member != null) {
            if (BCrypt.checkpw(password, member.getPassword())) {
//                UpdateWrapper updateWrapper = new UpdateWrapper<>();
//                updateWrapper.eq("id", member.getId());
//                super.update(updateWrapper);
                UserTmp userTmp = new UserTmp();
                BeanUtils.copyProperties(member, userTmp);
                userTmp.setMemberId(member.getId());
                String token = JwtUtil.create(24 * 30 * 60 * 1000, userTmp);
//                redisTemplate.opsForSet().add("LOGIN_TOKEN", token);
                String key = "LOGIN_TOKEN_" + token.substring(token.lastIndexOf(".") + 1);
                String value = token;
                redisTemplate.opsForValue().set(key, value);
                redisTemplate.expire(key, 12, TimeUnit.HOURS);
                userTmp.setToken(token);
                return userTmp;
            }
        }
        // 用户名或密码错误则返回空
        return null;
    }
//    @Override
//    public ResponseResult login(String username, String password) {
//        QueryWrapper queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("username", username);
//        // 状态为0表示禁用
//        queryWrapper.eq("status", 1);
//
//        Member member = this.getOne(queryWrapper);
//        System.out.println("实体类信息"+member);
//        // userTmp == null 说明用户名不存在
//        if (member != null) {
//            if (BCrypt.checkpw(password, member.getPassword())) {
//                UserTmp userTmp = new UserTmp();
//                BeanUtils.copyProperties(member,userTmp);
//                // uid
//                String token = JwtUtil.create(24 * 30 * 60 * 1000, userTmp);
//                String key = "LOGIN_TOKEN_" + token.substring(token.lastIndexOf(".") + 1);
//                String value = token;
//                redisTemplate.opsForValue().set(key, value);
//                redisTemplate.expire(key, 12, TimeUnit.HOURS);
//                ResponseResult responseResult = new ResponseResult(Constants.SUCCESS,token);
//                responseResult.setData(userTmp);
//                return responseResult;
//            }
//        }
//        return null;
//
//    }


//
//    @Override
//    public Member setPermissionInfo(Member member) {
//        member = getById(member.getId());
//        // 注入角色列表
////        member.setRoles(roleMapper.selectRolesByMemberId(member.getId()));
//        // 注入菜单列表
////        member.setMenus(menuMapper.selectMenusByMemberId(member.getId(), 1));
//        member.setMenus(menuMapper.selectMenusByMemberId(member.getId(), 1));
//
//        return member;
//    }

//    @Override
//    public List<Role> getRoleList(long id) {
//        return roleMapper.selectRolesByMemberId(id);
//    }
//
//    @Override
//    // 保证这个业务方法里的所有操作都在同一个事务中
//    @Transactional
//    public void allocRole(long memberId, String roleIds) {
//        // 1.先移除原来的角色
//        QueryWrapper queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("member_id", memberId);
//        memberRoleRelationMapper.delete(queryWrapper);
//        // 2.分配当前全部角色
//        if (!StringUtil.isEmpty(roleIds)) {
//            for (String roleId : roleIds.split(",")) {
//                MemberRoleRelation relation = new MemberRoleRelation();
//                relation.setMemberId(memberId);
//                relation.setRoleId(Long.valueOf(roleId));
//                memberRoleRelationMapper.insert(relation);
//            }
//        }
//    }
}
