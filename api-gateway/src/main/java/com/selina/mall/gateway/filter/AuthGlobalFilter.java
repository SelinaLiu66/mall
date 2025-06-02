package com.selina.mall.gateway.filter;

import com.selina.mall.gateway.client.AuthServiceClient;
import com.selina.mall.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * @author SelinaLiu
 * 在网关中实现统一的权限认证
 * 针对每个请求头或请求参数中的token令牌进行有效性验证，
 * 如果有效就完成后续的路由操作，
 * 否则直接返回401错误（无访问权限）
 */
@SuppressWarnings("all")
@Service // 第三步将这个类注入Spring的容器
@ConfigurationProperties("auth-filter")
// 第一步：声明一个Filter类，实现GlobalFilter接口
public class AuthGlobalFilter implements GlobalFilter, Ordered {
    @Autowired
    private RedisTemplate redisTemplate;

    // 保证我们自定义的过滤器位于整个过滤器链路的最前端
    @Override
    public int getOrder() {
        return 1;
    }

    // 不需要鉴权的的请求路径集合（excludes包括的路径直接放行）
    private List<String> excludes;

    public List<String> getExcludes() {
        return excludes;
    }

    public void setExcludes(List<String> excludes) {
        this.excludes = excludes;
    }

    @Autowired
    private AuthServiceClient authService;

    private boolean enabled; // 设置一个基于配置文件的开关，true过滤器开启，false关闭

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    // 第二步：重写filter方法
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        if (!enabled) return chain.filter(exchange);
        // 请求路径
        String uri = exchange.getRequest().getURI().getPath();
        if (excludes.contains(uri)) {
            // 如果是包含在放行路径集合里面的uri直接通过鉴权环节
            return chain.filter(exchange);
        }
        // Authorization这个请求头中要包含jwt token
        String token = exchange.getRequest().getHeaders().getFirst("Authorization");
        // 1.没有token
        // 2.token过期
        // 3.token无效（被伪造的token）
        // 4.token令牌在redis中未找到
        String key = "LOGIN_TOKEN_" + token.substring(token.lastIndexOf(".") + 1);
        if (token == null
                || JwtUtil.parseAdminToken(token.substring(7)) == null
                || !redisTemplate.hasKey(key)) {
            exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);// 401
            return exchange.getResponse().setComplete();// 响应结束，方法将终止
        } else {
            return chain.filter(exchange);
        }
    }
}
