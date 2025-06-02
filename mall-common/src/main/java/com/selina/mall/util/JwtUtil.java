package com.selina.mall.util;

import com.selina.mall.user.entity.Admin;
import com.selina.mall.user.entity.UserTmp;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.UUID;

/**
 * @author JiangYingbo
 * 声明一个JWT工具类
 * 1. 能够生成Token令牌
 * 2. 能够解析Token令牌（解析成功Token有效，解析失败Token无效）
 */
@SuppressWarnings("all")
public class JwtUtil {

    private static String salt = "0103";

    /**
     * 生成Token令牌的方法，需要设置：令牌id，签发人，主题，有效时间
     * Claim需要包括：用户id，用户名...
     * 加密算法：Signature.HS256
     *
     * @param exp      令牌的有效时间，单位是毫秒
     * @param userInfo 用户信息
     * @return JWT令牌
     */
    public static String create(long exp, UserTmp userInfo) {
        JwtBuilder builder = Jwts.builder();
        builder.setId(UUID.randomUUID().toString());// 设置id
        builder.setIssuer("SELINA");// 签发人
        builder.setIssuedAt(new Date());// 签发时间
        builder.setExpiration(new Date(System.currentTimeMillis() + exp));// 过期时间
        builder.setSubject("yunch_mall");// 设置主题
        builder.claim("userId", userInfo.getUid());
        builder.claim("username", userInfo.getUsername());
        builder.signWith(SignatureAlgorithm.HS256, salt);// 设置加密算法和盐（密钥）
        return "Bearer " + builder.compact();// 生成Token并返回
    }

    public static String create(long exp, Admin admin) {
        JwtBuilder builder = Jwts.builder();
        builder.setId(UUID.randomUUID().toString());// 设置id
        builder.setIssuer("SELINA");// 签发人
        builder.setIssuedAt(new Date());// 签发时间
        builder.setExpiration(new Date(System.currentTimeMillis() + exp));// 过期时间
        builder.setSubject("yunch_mall");// 设置主题
        builder.claim("userId", admin.getId());
        builder.claim("username", admin.getUsername());
        builder.signWith(SignatureAlgorithm.HS256, salt);// 设置加密算法和盐（密钥）
        return "Bearer " + builder.compact();// 生成Token并返回
    }

    /**
     * 对给定的Token进行解析，如果成功则从token中取出用户信息封装返回，解析出错返回null
     *
     * @param token
     * @return
     */
    public static UserTmp parse(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(salt)// 设置盐（密钥）
                    .parseClaimsJws(token).getBody();
            UserTmp userTmp = new UserTmp();
            userTmp.setUid(claims.get("userId", Integer.class));
            userTmp.setUsername(claims.get("username", String.class));
            return userTmp;
        } catch (Exception ex) {
            return null;
        }
    }

    public static Admin parseAdminToken(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(salt)// 设置盐（密钥）
                    .parseClaimsJws(token).getBody();
            Admin admin = new Admin();
            admin.setId(claims.get("userId", Integer.class));
            admin.setUsername(claims.get("username", String.class));
            return admin;
        } catch (Exception ex) {
            return null;
        }
    }
}
