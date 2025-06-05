# 购物商城项目-mall

基于Spring Cloud Alibaba构建的Java微服务商城系统，包含**5个核心服务**：

### 1. 服务架构
- **业务服务**  
  - 订单服务 | 商品服务 | 用户服务  
- **支撑服务**  
  - 网关服务：Spring Cloud Gateway动态路由  
  - 公共服务：封装DDD实体/工具类/通用DTO  

### 2. 技术栈
```diff
+ 注册中心：Nacos 服务发现与配置管理  
+ 容错防护：Sentinel 熔断限流（QPS控制/降级规则）  
+ 服务通信：OpenFeign + Ribbon 负载均衡  
+ 安全认证：JWT + OAuth2 鉴权方案（扩展点）  
```

### 3. 软件架构图

![ArchitectureDiagram.png](picture%2FArchitectureDiagram.png)

### 4. 安装环境教程

1. 创建好数据库名称为mall,运行项目中的SQL文件
2. 配置中间件环境
   https://blog.csdn.net/qq_46564922/article/details/148338500?spm=1001.2014.3001.5502
