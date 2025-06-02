-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: mall
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart`
(
    `id`          bigint         NOT NULL AUTO_INCREMENT,
    `member_id`   bigint         NOT NULL COMMENT '会员ID',
    `sku_id`      bigint         NOT NULL COMMENT 'SKU ID',
    `count`       int            NOT NULL COMMENT '购买数量',
    `selected`    tinyint(1)     NOT NULL DEFAULT '1' COMMENT '选中状态',
    `price`       decimal(10, 2) NOT NULL COMMENT '加入时价格',
    `create_time` datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_member` (`member_id`),
    KEY `idx_sku` (`sku_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 151
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart`
    DISABLE KEYS */;
INSERT INTO `cart`
VALUES (94, 25, 191, 1, 1, 1599.00, '2025-05-22 20:54:13', '2025-05-22 20:54:13'),
       (140, 28, 299, 1, 1, 109.00, '2025-06-01 17:10:41', '2025-06-01 17:10:41'),
       (141, 28, 481, 2, 1, 79.00, '2025-06-01 17:15:49', '2025-06-01 17:15:49'),
       (142, 28, 339, 1, 1, 109.00, '2025-06-01 18:00:21', '2025-06-01 18:00:21');
/*!40000 ALTER TABLE `cart`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hot`
--

DROP TABLE IF EXISTS `hot`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hot`
(
    `id`      varchar(10)  NOT NULL COMMENT '推荐ID',
    `picture` varchar(500) NOT NULL COMMENT '图片地址',
    `title`   varchar(100) NOT NULL COMMENT '推荐标题',
    `alt`     varchar(100) NOT NULL COMMENT '推荐描述',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='热门推荐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hot`
--

LOCK TABLES `hot` WRITE;
/*!40000 ALTER TABLE `hot`
    DISABLE KEYS */;
INSERT INTO `hot`
VALUES ('1001', 'https://yjy-oss-files.oss-cn-zhangjiakou.aliyuncs.com/tuxian/popular_1.jpg', '特惠推荐', '它们最实惠'),
       ('1002', 'https://yjy-oss-files.oss-cn-zhangjiakou.aliyuncs.com/tuxian/popular_2.jpg', '爆款推荐',
        '它们最受欢迎'),
       ('1003', 'https://yjy-oss-files.oss-cn-zhangjiakou.aliyuncs.com/tuxian/popular_3.jpg', '一站买全',
        '使用场景下精心优选'),
       ('1004', 'https://yjy-oss-files.oss-cn-zhangjiakou.aliyuncs.com/tuxian/popular_4.jpg', '领券中心',
        '更多超值优惠券');
/*!40000 ALTER TABLE `hot`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oms_order`
--

DROP TABLE IF EXISTS `oms_order`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oms_order`
(
    `id`                      int                                                          NOT NULL AUTO_INCREMENT COMMENT '订单id',
    `member_id`               int                                                          NOT NULL COMMENT '会员ID',
    `coupon_id`               int                                                                   DEFAULT NULL COMMENT '优惠券ID',
    `order_sn`                varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '订单编号',
    `create_time`             datetime                                                              DEFAULT NULL COMMENT '提交时间',
    `member_username`         varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '用户帐号',
    `total_amount`            decimal(10, 2)                                                        DEFAULT NULL COMMENT '订单总金额',
    `pay_amount`              decimal(10, 2)                                                        DEFAULT NULL COMMENT '应付金额（实际支付金额）',
    `freight_amount`          decimal(10, 2)                                                        DEFAULT NULL COMMENT '运费金额',
    `pay_type`                int                                                                   DEFAULT '0' COMMENT '支付方式：0->未支付；1->支付宝；2->微信',
    `status`                  int                                                                   DEFAULT '1' COMMENT '订单状态：1->待付款；2->待发货；3->已发货；4->待评价；5->已完成；0->已取消；',
    `order_type`              int                                                                   DEFAULT '0' COMMENT '订单类型：0->正常订单；1->秒杀订单',
    `delivery_company`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '物流公司(配送方式)',
    `delivery_sn`             varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '物流单号',
    `auto_confirm_day`        int                                                                   DEFAULT NULL COMMENT '自动确认时间（天）',
    `receiver_name`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci        NOT NULL COMMENT '收货人姓名',
    `receiver_phone`          varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货人电话',
    `receiver_post_code`      varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '收货人邮编',
    `receiver_province`       varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '省份/直辖市',
    `receiver_city`           varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '城市',
    `receiver_region`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          DEFAULT NULL COMMENT '区',
    `receiver_detail_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '详细地址',
    `note`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '订单备注',
    `confirm_status`          int                                                                   DEFAULT '0' COMMENT '确认收货状态：0->未确认；1->已确认',
    `delete_status`           int                                                          NOT NULL DEFAULT '0' COMMENT '删除状态：0->未删除；1->已删除',
    `payment_time`            datetime                                                              DEFAULT NULL COMMENT '支付时间',
    `delivery_time`           datetime                                                              DEFAULT NULL COMMENT '发货时间',
    `receive_time`            datetime                                                              DEFAULT NULL COMMENT '确认收货时间',
    `comment_time`            datetime                                                              DEFAULT NULL COMMENT '评价时间',
    `modify_time`             datetime                                                              DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 189
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oms_order`
--

LOCK TABLES `oms_order` WRITE;
/*!40000 ALTER TABLE `oms_order`
    DISABLE KEYS */;
INSERT INTO `oms_order`
VALUES (13, 1, 2, '201809150102000002', '2018-09-15 14:24:29', 'test', 18732.00, 16365.75, 8.00, 1, 1, 0, '圆通公司',
        '781219990001212999', 15, '庄严', '13609887722', '150080', '黑龙江省', '绥化市', '望奎县', 'xxx',
        '贵重物品，轻拿轻放！', 0, 0, '2024-04-03 12:04:07', '2024-04-03 12:26:45', NULL, NULL, '2024-04-03 12:26:45'),
       (14, 1, 2, '201809130101000001', '2018-09-13 16:57:40', 'test', 18732.00, 16377.75, 0.00, 2, 3, 0, '顺丰快递',
        '201707196398345', 15, '大梨3', '18033441847', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 0,
        '2018-10-13 13:44:04', '2018-10-16 13:43:41', NULL, NULL, '2024-04-03 11:25:23'),
       (15, 1, 2, '201809130102000002', '2018-09-13 17:03:00', 'test', 18732.00, 16377.75, 0.00, 1, 3, 0, '顺丰快递',
        '201707196398346', 15, '大梨4', '18033441846', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 1, 0,
        '2018-10-13 13:44:54', '2018-10-16 13:45:01', '2018-10-18 14:05:31', NULL, NULL),
       (16, 1, 2, '201809140101000001', '2018-09-14 16:16:16', 'test', 18732.00, 16377.75, 0.00, 2, 4, 0, NULL, NULL,
        15, '大梨5', '18033441845', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 1, NULL, NULL, NULL,
        NULL, '2023-02-15 16:58:23'),
       (17, 1, 2, '201809150101000003', '2018-09-15 12:24:27', 'test', 18732.00, 16377.75, 0.00, 0, 4, 0, '顺丰快递',
        '201707196398345', 15, '大梨6', '18033441844', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 1,
        NULL, '2018-10-12 14:01:28', NULL, NULL, '2023-02-15 16:58:23'),
       (18, 1, 2, '201809150102000004', '2018-09-15 14:24:29', 'test', 18732.00, 16377.75, 0.00, 1, 2, 0, '圆通快递',
        '11223333', 15, '大梨7', '18033441843', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 0, NULL,
        '2024-01-25 16:56:59', NULL, NULL, NULL),
       (19, 1, 2, '201809130101000003', '2018-09-13 16:57:40', 'test', 18732.00, 16377.75, 0.00, 2, 2, 0, NULL, NULL,
        15, '大梨8', '18033441842', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 0, NULL, NULL, NULL,
        NULL, NULL),
       (20, 1, 2, '201809130102000004', '2018-09-13 17:03:00', 'test', 18732.00, 16377.75, 0.00, 1, 3, 0, NULL, NULL,
        15, '大梨1', '18033441841', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 0, NULL, NULL, NULL,
        NULL, NULL),
       (21, 1, 2, '201809140101000002', '2018-09-14 16:16:16', 'test', 18732.00, 16377.75, 0.00, 2, 4, 0, NULL, NULL,
        15, '大梨1', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 1, NULL, NULL, NULL,
        NULL, '2023-02-15 16:58:23'),
       (22, 1, 2, '201809150101000005', '2018-09-15 12:24:27', 'test', 18732.00, 16377.75, 0.00, 0, 4, 0, '顺丰快递',
        '201707196398345', 15, '大梨1', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 1,
        NULL, '2018-10-12 14:01:28', NULL, NULL, '2023-02-15 16:58:23'),
       (23, 1, 2, '201809150102000006', '2018-09-15 14:24:29', 'test', 18732.00, 16377.75, 0.00, 1, 2, 0, '顺丰快递',
        '12345677654321', 15, '大梨1', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道',
        '易碎物品，轻拿轻放！', 0, 0, NULL, '2018-10-16 14:41:28', NULL, NULL, '2023-02-15 16:21:46'),
       (24, 1, 2, '201809130101000005', '2018-09-13 16:57:40', 'test', 18732.00, 16377.75, 0.00, 2, 2, 0, NULL, NULL,
        15, '大梨1', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', NULL, 0, 0, NULL, NULL, NULL,
        NULL, NULL),
       (28, 1, NULL, '202002250100000002', '2020-02-25 16:05:47', 'test', 540.00, 540.00, 0.00, 0, 4, 0, NULL, NULL,
        NULL, '大梨4', '18033441849', '518000', '广东省', '深圳市', '南山区', '科兴科学园', NULL, 0, 0, NULL, NULL,
        NULL, NULL, '2023-02-15 16:57:36'),
       (29, 1, NULL, '202002250100000003', '2020-02-25 16:07:58', 'test', 540.00, 540.00, 0.00, 0, 4, 0, NULL, NULL,
        NULL, '诸葛孔明', '13800112233', '150080', '黑龙江省', '哈尔滨市', '松北区', '黑龙江科技大学门卫',
        '贵重商品，妥善投递！', 0, 0, NULL, NULL, NULL, NULL, '2023-02-15 15:50:35'),
       (30, 1, NULL, '202002250100000004', '2020-02-25 16:50:13', 'test', 240.00, 240.00, 20.00, 1, 2, 0, '顺丰快递',
        '12333333', NULL, '大梨8', '18033441849', '518000', '广东省', '深圳市', '南山区', '科兴科学园', NULL, 0, 0,
        '2020-02-25 16:53:29', '2020-02-25 16:54:03', NULL, NULL, '2020-02-25 16:52:51'),
       (119, 25, NULL, '578466416852865024', '2025-05-20 18:05:11', 'user008', 49.00, 61.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (120, 25, NULL, '578467979847667712', '2025-05-21 16:05:18', 'user008', 49.00, 61.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (121, 25, NULL, '579296396289642496', '2025-05-21 17:05:24', 'user008', 49.00, 61.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (122, 25, NULL, '580324249592532992', '2025-05-21 18:05:27', 'user008', 79.00, 91.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (123, 25, NULL, '580325813816266752', '2025-05-21 18:05:40', 'user008', 79.00, 91.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (124, 25, NULL, '580337387494838272', '2025-05-21 18:13:35', 'user008', 109.00, 109.00, 0.00, 1, 3, 0,
        '顺丰快递', '11111', NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL,
        0, 0, NULL, '2025-05-22 16:57:42', NULL, NULL, NULL),
       (125, 25, NULL, '580409233980395520', '2025-05-21 22:59:05', 'user008', 109.00, 109.00, 0.00, 1, 3, 0,
        '顺丰快递', '11000000', NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号',
        NULL, 0, 0, NULL, '2025-05-22 16:52:36', NULL, NULL, NULL),
       (126, 25, NULL, '580411190283472896', '2025-05-21 23:06:51', 'user008', 79.00, 91.00, 12.00, 1, 3, 0, '顺丰快递',
        '1122200', NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL,
        '2025-05-22 16:48:03', NULL, NULL, NULL),
       (127, 25, NULL, '580414582326169600', '2025-05-21 23:20:20', 'user008', 159.00, 159.00, 0.00, 1, 2, 0,
        '顺丰快递', '11111', NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL,
        0, 0, NULL, '2025-05-22 16:23:27', NULL, NULL, NULL),
       (128, 25, NULL, '580416992683626496', '2025-05-21 23:29:55', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (129, 25, NULL, '580417720504422400', '2025-05-21 23:32:48', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (130, 25, NULL, '580628646990057472', '2025-05-22 13:30:57', 'user008', 118.00, 118.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, '六六', '15122255522', NULL, '黑龙江', '哈尔滨市', '南岗', '1', NULL, 0, 0, NULL, NULL, NULL, NULL,
        NULL),
       (131, 25, NULL, '580653287930466304', '2025-05-22 15:08:52', 'user008', 398.00, 398.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (132, 25, NULL, '580656493595070464', '2025-05-22 15:21:36', 'user008', 14.00, 26.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (133, 25, NULL, '580657086933897216', '2025-05-22 15:23:58', 'user008', 19.00, 31.00, 12.00, 1, 3, 0, '顺丰快递',
        '01010', NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL,
        '2025-05-22 16:34:42', NULL, NULL, NULL),
       (134, 25, NULL, '580657268048138240', '2025-05-22 15:24:41', 'user008', 7.00, 19.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (135, 25, NULL, '580657709091786752', '2025-05-22 15:26:26', 'user008', 15.00, 27.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (136, 25, NULL, '580953485697224704', '2025-05-23 11:01:45', 'user008', 19.00, 31.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (137, 25, NULL, '580954558688268288', '2025-05-23 11:06:00', 'user008', 9.00, 21.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (138, 25, NULL, '581273923556085760', '2025-05-24 08:15:03', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (139, 25, NULL, '581274559488069632', '2025-05-24 08:17:35', 'user008', 49.00, 61.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (140, 25, NULL, '581275665127575552', '2025-05-24 08:21:58', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (141, 25, NULL, '581275781712449536', '2025-05-24 08:22:26', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (142, 25, NULL, '581280929058787328', '2025-05-24 08:42:53', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (143, 25, NULL, '581281560725164032', '2025-05-24 08:45:24', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (144, 25, NULL, '581281991891226624', '2025-05-24 08:47:07', 'user008', 29.00, 41.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (145, 25, NULL, '581303152201043968', '2025-05-24 10:11:12', 'user008', 35.00, 47.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (146, 25, NULL, '583564132343746560', '2025-05-30 15:55:31', 'user008', 1258.00, 1258.00, 0.00, 1, 1, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (147, 25, NULL, '583601775660109824', '2025-05-30 18:25:06', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (148, 25, NULL, '583602734691913728', '2025-05-30 18:28:55', 'user008', 659.00, 659.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (149, 25, NULL, '583670338576060416', '2025-05-30 22:57:33', 'user008', 52.00, 64.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (150, 25, NULL, '583671167236313088', '2025-05-30 23:00:50', 'user008', 26.00, 38.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (151, 25, NULL, '583675004378550272', '2025-05-30 23:16:05', 'user008', 14.00, 26.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (152, 25, NULL, '583675376421703680', '2025-05-30 23:17:34', 'user008', 44.00, 56.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (153, 25, NULL, '583681059028340736', '2025-05-30 23:40:09', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (154, 25, NULL, '583681739428335616', '2025-05-30 23:42:51', 'user008', 659.00, 659.00, 0.00, 1, 1, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (155, 25, NULL, '583681835662446592', '2025-05-30 23:43:14', 'user008', 44.00, 56.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (156, 25, NULL, '583688532841861120', '2025-05-31 00:09:51', 'user008', 9.00, 21.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (157, 25, NULL, '583688646754963456', '2025-05-31 00:10:18', 'user008', 9.00, 21.00, 12.00, 1, 1, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (158, 25, NULL, '584039971644641280', '2025-05-31 23:26:20', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (159, 25, NULL, '584041051665338368', '2025-05-31 23:30:38', 'user008', 659.00, 659.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (160, 25, NULL, '584041312924340224', '2025-05-31 23:31:40', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (161, 25, NULL, '584041621520257024', '2025-05-31 23:32:54', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (162, 25, NULL, '584042267325632512', '2025-05-31 23:35:28', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (163, 25, NULL, '584188670366584832', '2025-06-01 09:17:13', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (164, 25, NULL, '584191981266276352', '2025-06-01 09:30:22', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (165, 25, NULL, '584192881045147648', '2025-06-01 09:33:57', 'user008', 159.00, 159.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (166, 25, NULL, '584193647512260608', '2025-06-01 09:36:59', 'user008', 149.00, 149.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (167, 25, NULL, '584194239827677184', '2025-06-01 09:39:21', 'user008', 79.00, 91.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (168, 25, NULL, '584195455513137152', '2025-06-01 09:44:10', 'user008', 659.00, 659.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (169, 25, NULL, '584195936171986944', '2025-06-01 09:46:05', 'user008', 14.00, 26.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (170, 25, NULL, '584197378760904704', '2025-06-01 09:51:49', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (171, 25, NULL, '584199663880638464', '2025-06-01 10:00:54', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (172, 25, NULL, '584200348844036096', '2025-06-01 10:03:37', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (173, 25, NULL, '584207228081410048', '2025-06-01 10:30:57', 'user008', 9.00, 21.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (174, 25, NULL, '584209486105939968', '2025-06-01 10:39:56', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (175, 25, NULL, '584218102657585152', '2025-06-01 11:14:10', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (176, 25, NULL, '584228584357498880', '2025-06-01 11:55:49', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (177, 25, NULL, '584229876882608128', '2025-06-01 12:00:57', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (178, 25, NULL, '584230694356652032', '2025-06-01 12:04:12', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (179, 25, NULL, '584232456652197888', '2025-06-01 12:11:12', 'user008', 19.00, 31.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0,
        '2025-06-01 12:11:54', NULL, NULL, NULL, NULL),
       (180, 25, NULL, '584232793534500864', '2025-06-01 12:12:32', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (181, 25, NULL, '584351793383870464', '2025-06-01 20:05:24', 'user008', 79.00, 91.00, 12.00, 1, 2, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0,
        '2025-06-01 20:05:56', NULL, NULL, NULL, NULL),
       (182, 25, NULL, '584742299834126336', '2025-06-02 21:57:08', 'user008', 118.00, 118.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (183, 25, NULL, '584743052543922176', '2025-06-02 22:00:08', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (184, 25, NULL, '584743493293969408', '2025-06-02 22:01:53', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (185, 25, NULL, '584745430793981952', '2025-06-02 22:09:35', 'user008', 39.00, 51.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL),
       (186, 25, NULL, '584746969449238528', '2025-06-02 22:15:42', 'user008', 109.00, 109.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (187, 25, NULL, '584747230817292288', '2025-06-02 22:16:44', 'user008', 599.00, 599.00, 0.00, 1, 0, 0, NULL,
        NULL, NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL,
        NULL, NULL, NULL, NULL),
       (188, 25, NULL, '584748564790513664', '2025-06-02 22:22:02', 'user008', 9.00, 21.00, 12.00, 1, 0, 0, NULL, NULL,
        NULL, 'user008', '13200001234', NULL, '上海', '上海市', '浦东新区', '秀沿路1254号1', NULL, 0, 0, NULL, NULL,
        NULL, NULL, NULL);
/*!40000 ALTER TABLE `oms_order`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oms_order_item`
--

DROP TABLE IF EXISTS `oms_order_item`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oms_order_item`
(
    `id`                  int NOT NULL AUTO_INCREMENT COMMENT '订单项id，自增',
    `order_id`            int                                                          DEFAULT NULL COMMENT '订单id',
    `order_sn`            varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单编号',
    `product_id`          int                                                          DEFAULT NULL COMMENT '商品id',
    `product_pic`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品封面图',
    `product_name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品名称',
    `product_brand`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '品牌',
    `product_sn`          varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
    `product_price`       decimal(10, 2)                                               DEFAULT NULL COMMENT '销售价格',
    `product_quantity`    int                                                          DEFAULT NULL COMMENT '购买数量',
    `product_sku_id`      int                                                          DEFAULT NULL COMMENT '商品sku编号',
    `product_sku_code`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品sku条码',
    `product_category_id` int                                                          DEFAULT NULL COMMENT '商品分类id',
    `promotion_name`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品促销名称',
    `promotion_amount`    decimal(10, 2)                                               DEFAULT NULL COMMENT '商品促销分解金额',
    `coupon_amount`       decimal(10, 2)                                               DEFAULT NULL COMMENT '优惠券优惠分解金额',
    `integration_amount`  decimal(10, 2)                                               DEFAULT NULL COMMENT '积分优惠分解金额',
    `real_amount`         decimal(10, 2)                                               DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
    `gift_integration`    int                                                          DEFAULT '0' COMMENT '赠送计分',
    `gift_growth`         int                                                          DEFAULT '0' COMMENT '赠送成长值',
    `product_attr`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 343
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='订单中所包含的商品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oms_order_item`
--

LOCK TABLES `oms_order_item` WRITE;
/*!40000 ALTER TABLE `oms_order_item`
    DISABLE KEYS */;
INSERT INTO `oms_order_item`
VALUES (21, 12, '201809150101000001', 26,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '6946605', 3788.00, 1, 90, '201806070026001', 19, '单品促销', 200.00, 2.02, 0.00, 3585.98, 3788, 3788,
        '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (22, 12, '201809150101000001', 27,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788',
        2699.00, 3, 98, '201808270027001', 19, '打折优惠：满3件，打7.50折', 674.75, 1.44, 0.00, 2022.81, 2699, 2699,
        '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (23, 12, '201809150101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 649.00, 1, 102, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 57.60, 0.35, 0.00, 591.05,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (24, 12, '201809150101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 699.00, 1, 103, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 62.40, 0.37, 0.00, 636.23,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (25, 12, '201809150101000001', 29,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg',
        'Apple iPhone 8 Plus', '苹果', '7437799', 5499.00, 1, 106, '201808270029001', 19, '无优惠', 0.00, 2.94, 0.00,
        5496.06, 5499, 5499, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (26, 13, '201809150102000002', 26,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '6946605', 3788.00, 1, 90, '201806070026001', 19, '单品促销', 200.00, 2.02, 0.00, 3585.98, 3788, 3788,
        '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (27, 13, '201809150102000002', 27,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788',
        2699.00, 3, 98, '201808270027001', 19, '打折优惠：满3件，打7.50折', 674.75, 1.44, 0.00, 2022.81, 2699, 2699,
        '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (28, 13, '201809150102000002', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 649.00, 1, 102, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 57.60, 0.35, 0.00, 591.05,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (29, 13, '201809150102000002', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 699.00, 1, 103, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 62.40, 0.37, 0.00, 636.23,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (30, 13, '201809150102000002', 29,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg',
        'Apple iPhone 8 Plus', '苹果', '7437799', 5499.00, 1, 106, '201808270029001', 19, '无优惠', 0.00, 2.94, 0.00,
        5496.06, 5499, 5499, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (31, 14, '201809130101000001', 26,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '6946605', 3788.00, 1, 90, '201806070026001', 19, '单品促销', 200.00, 2.02, 0.00, 3585.98, 3788, 3788,
        '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (32, 14, '201809130101000001', 27,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788',
        2699.00, 3, 98, '201808270027001', 19, '打折优惠：满3件，打7.50折', 674.75, 1.44, 0.00, 2022.81, 2699, 2699,
        '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (33, 14, '201809130101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 649.00, 1, 102, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 57.60, 0.35, 0.00, 591.05,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (34, 14, '201809130101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 699.00, 1, 103, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 62.40, 0.37, 0.00, 636.23,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (35, 14, '201809130101000001', 29,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg',
        'Apple iPhone 8 Plus', '苹果', '7437799', 5499.00, 1, 106, '201808270029001', 19, '无优惠', 0.00, 2.94, 0.00,
        5496.06, 5499, 5499, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (36, 15, '201809130101000001', 26,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '6946605', 3788.00, 1, 90, '201806070026001', 19, '单品促销', 200.00, 2.02, 0.00, 3585.98, 3788, 3788,
        '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (37, 15, '201809130101000001', 27,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788',
        2699.00, 3, 98, '201808270027001', 19, '打折优惠：满3件，打7.50折', 674.75, 1.44, 0.00, 2022.81, 2699, 2699,
        '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (38, 15, '201809130101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 649.00, 1, 102, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 57.60, 0.35, 0.00, 591.05,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (39, 15, '201809130101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 699.00, 1, 103, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 62.40, 0.37, 0.00, 636.23,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (40, 15, '201809130101000001', 29,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg',
        'Apple iPhone 8 Plus', '苹果', '7437799', 5499.00, 1, 106, '201808270029001', 19, '无优惠', 0.00, 2.94, 0.00,
        5496.06, 5499, 5499, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (41, 16, '201809140101000001', 26,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '6946605', 3788.00, 1, 90, '201806070026001', 19, '单品促销', 200.00, 2.02, 0.00, 3585.98, 3788, 3788,
        '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (42, 16, '201809140101000001', 27,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788',
        2699.00, 3, 98, '201808270027001', 19, '打折优惠：满3件，打7.50折', 674.75, 1.44, 0.00, 2022.81, 2699, 2699,
        '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (43, 16, '201809140101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 649.00, 1, 102, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 57.60, 0.35, 0.00, 591.05,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]'),
       (44, 16, '201809140101000001', 28,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '7437789', 699.00, 1, 103, '201808270028001', 19, '满减优惠：满1000.00元，减120.00元', 62.40, 0.37, 0.00, 636.23,
        649, 649, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (45, 16, '201809140101000001', 29,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg',
        'Apple iPhone 8 Plus', '苹果', '7437799', 5499.00, 1, 106, '201808270029001', 19, '无优惠', 0.00, 2.94, 0.00,
        5496.06, 5499, 5499, '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]'),
       (46, 27, '202002250100000001', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 100.00, 3, 163,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 100.00, 0, 0, NULL),
       (47, 27, '202002250100000001', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 120.00, 2, 164,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 120.00, 0, 0, NULL),
       (48, 28, '202002250100000002', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 100.00, 3, 163,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 100.00, 0, 0, NULL),
       (49, 28, '202002250100000002', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 120.00, 2, 164,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 120.00, 0, 0, NULL),
       (50, 29, '202002250100000003', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 100.00, 3, 163,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 100.00, 0, 0,
        '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]'),
       (51, 29, '202002250100000003', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 120.00, 2, 164,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 120.00, 0, 0,
        '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),
       (52, 30, '202002250100000004', 36,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 'NIKE', '6799345', 120.00, 2, 164,
        '202002210036001', 29, '无优惠', 0.00, 0.00, 0.00, 120.00, 0, 0,
        '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]'),
       (269, 119, '578466416852865024', 55,
        'http://localhost:9000/images/category/home/9892cc73945da1591fa5259ad076b23c.jpg', '暖腰暖腹暖胃，蕲艾暖宫腰带',
        '', 'SN_1005000_8', 49.00, 1, 200, '300274056', 1005000, NULL, NULL, NULL, NULL, 49.00, 0, 0,
        '{\"name\":\"规格\",\"valueName\":\"暖宫腰带3片/盒\"}'),
       (270, 120, '578467979847667712', 55,
        'http://localhost:9000/images/category/home/9892cc73945da1591fa5259ad076b23c.jpg', '暖腰暖腹暖胃，蕲艾暖宫腰带',
        '', 'SN_1005000_8', 49.00, 1, 200, '300274056', 1005000, NULL, NULL, NULL, NULL, 49.00, 0, 0,
        '{\"name\":\"规格\",\"valueName\":\"暖宫腰带3片/盒\"}'),
       (271, 121, '579296396289642496', 55,
        'http://localhost:9000/images/category/home/9892cc73945da1591fa5259ad076b23c.jpg', '暖腰暖腹暖胃，蕲艾暖宫腰带',
        '', 'SN_1005000_8', 49.00, 1, 200, '300274056', 109308000, NULL, NULL, NULL, NULL, 49.00, 0, 0,
        '{\"name\":\"规格\",\"valueName\":\"暖宫腰带3片/盒\"}'),
       (272, 122, '580324249592532992', 4028017,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', '消炎镇痛一贴灵医用冷敷贴60贴/盒',
        '', 'SN3991840', 79.00, 1, 481, 'SN3991840-60mini', 109293000, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"规格\": \"60贴\", \"类型\": \"mini型\"}'),
       (273, 123, '580325813816266752', 4028017,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', '消炎镇痛一贴灵医用冷敷贴60贴/盒',
        '', 'SN3991840', 79.00, 1, 483, 'SN3991840-60std', 109293000, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"规格\": \"60贴\", \"类型\": \"标准型\"}'),
       (274, 124, '580337387494838272', 4023638,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png',
        '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1, 339, 'SN4023638-26-RED', 1037006, NULL, NULL,
        NULL, NULL, 109.00, 0, 0, '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (275, 125, '580409233980395520', 4028030,
        'https://yanxuan-item.nosdn.127.net/8f0c15f981c5cbcb1aa17215a259fa62.png', '入门首选，语音播报电子血压计', '',
        '3997974', 109.00, 1, 498, '4028030-01', 109293000, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"显示方式\":\"LED背光\",\"记忆组数\":\"99组\"}'),
       (276, 126, '580411190283472896', 4028039,
        'https://yanxuan-item.nosdn.127.net/7a5ffe313fe5671709d5a9826f5a83a2.jpg', '冻干藤椒豚骨面74克*12盒', '',
        '3464033', 79.00, 1, 438, '3464033-SPICY-12', 109201001, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (277, 127, '580414582326169600', 4028041,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', '恍若没穿鞋，女式轻软舒弹健步鞋2.0',
        '', '4000914', 159.00, 1, 403, '4000914-WHITE-36', 109311007, NULL, NULL, NULL, NULL, 159.00, 0, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"36\"}'),
       (278, 128, '580416992683626496', 1111002,
        'http://localhost:9000/images/category/electronics/4c6a9c8a579b00e5e9c7b002d15a33a2.jpg',
        '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319, 'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL,
        9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (279, 129, '580417720504422400', 4023638,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png',
        '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1, 339, 'SN4023638-26-RED', 1037006, NULL, NULL,
        NULL, NULL, 109.00, 0, 0, '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (280, 130, '580628646990057472', 4023638,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png',
        '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1, 340, 'SN4023638-26-BLUE', 1037006, NULL, NULL,
        NULL, NULL, 109.00, 0, 0, '{\"尺寸\": \"26\", \"颜色\": \"蓝色\"}'),
       (281, 130, '580628646990057472', 3465081,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg',
        '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265, 'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL,
        NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (282, 131, '580653287930466304', 3468024,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png',
        '意外设计便携钢笔花信礼盒', '', 'SN3468024', 398.00, 1, 269, 'SKU3468024-红XXL', 109243046, NULL, NULL, NULL,
        NULL, 398.00, 0, 0, '{\"颜色\": \"红色\", \"尺码\": \"XXL\"}'),
       (283, 132, '580656493595070464', 1589017,
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png',
        '分场景使用不污染，超细纤维抹布分类5件套', '', 'SN1589017', 14.90, 1, 197, 'OTHER_1589017', 109243016, NULL,
        NULL, NULL, NULL, 14.90, 0, 0, '{\"规格\":\"5件套\"}'),
       (284, 133, '580657086933897216', 4028036,
        'https://yanxuan-item.nosdn.127.net/564eb51c22d898179b468f5dec52d502.png',
        '加量45%不加价，内蒙古赤峰黄小米700克', '', '1135077', 19.00, 1, 452, '1135077-YELLOW', 109206007, NULL, NULL,
        NULL, NULL, 19.00, 0, 0, '{\"品种\":\"赤峰黄小米\",\"加量比例\":\"45%\"}'),
       (285, 134, '580657268048138240', 1525018,
        'https://yanxuan-item.nosdn.127.net/cf7584e037706a8df54fecfc6dfdd2af.jpg',
        '灰尘毛发静电吸附地板除尘干巾40片/包', '', 'SN1525018', 7.90, 1, 351, 'SKU1525018-01', 1005999006, NULL, NULL,
        NULL, NULL, 7.90, 0, 0, '{\"规格\":\"40片/包\"}'),
       (286, 135, '580657709091786752', 1006029,
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png',
        '【新疆棉】宝宝也能用，全棉华夫格毛巾', '', 'SN1006029', 15.90, 1, 293, 'SN1006029-WHITE', 109261055, NULL, NULL,
        NULL, NULL, 15.90, 0, 0, '{\"颜色\": \"白色\", \"规格\": \"标准装\"}'),
       (287, 136, '580953485697224704', 4028036, NULL, '加量45%不加价，内蒙古赤峰黄小米700克', '', '1135077', 19.00, 1,
        452, '1135077-YELLOW', 109206007, NULL, NULL, NULL, NULL, 19.00, 0, 0,
        '{\"品种\":\"赤峰黄小米\",\"加量比例\":\"45%\"}'),
       (288, 137, '580954558688268288', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (289, 138, '581273923556085760', 4028017, NULL, '消炎镇痛一贴灵医用冷敷贴60贴/盒', '', 'SN3991840', 79.00, 1,
        481, 'SN3991840-60mini', 109293000, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"规格\": \"60贴\", \"类型\": \"mini型\"}'),
       (290, 139, '581274559488069632', 4028016, NULL, '真空拔罐器', '', 'SN3987204', 49.00, 1, 479, 'SN3987204-B5',
        109308000, NULL, NULL, NULL, NULL, 49.00, 0, 0, '{\"颜色\": \"蓝色\", \"数量\": \"5只\"}'),
       (291, 140, '581275665127575552', 4023638, NULL, '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1,
        339, 'SN4023638-26-RED', 1037006, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (292, 141, '581275781712449536', 4028039, NULL, '冻干藤椒豚骨面74克*12盒', '', '3464033', 79.00, 1, 438,
        '3464033-SPICY-12', 109201001, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (293, 142, '581280929058787328', 4028039, NULL, '冻干藤椒豚骨面74克*12盒', '', '3464033', 79.00, 1, 438,
        '3464033-SPICY-12', 109201001, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (294, 143, '581281560725164032', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (295, 144, '581281991891226624', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 3, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (296, 145, '581303152201043968', 4028027, NULL, '带提手可站立炫彩硅胶热水袋', '', '3993481', 35.00, 1, 494,
        '4028027-01', 109293000, NULL, NULL, NULL, NULL, 35.00, 0, 0, '{\"颜色\":\"珊瑚粉\",\"容量\":\"1500ml\"}'),
       (297, 146, '583564132343746560', 4028043, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套', '', '4000620', 659.00, 1,
        410, '4000620-NAVY-L', 109303000, NULL, NULL, NULL, NULL, 659.00, 0, 0, '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (298, 146, '583564132343746560', 4028025, NULL, '新年佳礼，家用SPA多功能按摩床垫', '', '3995284', 599.00, 1, 463,
        '3995284-BASIC', 109293000, NULL, NULL, NULL, NULL, 599.00, 0, 0,
        '{\"模式\":\"3种基础模式\",\"承重\":\"150kg\"}'),
       (299, 147, '583601775660109824', 4028017, NULL, '消炎镇痛一贴灵医用冷敷贴60贴/盒', '', 'SN3991840', 79.00, 1,
        481, 'SN3991840-60mini', 109293000, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"规格\": \"60贴\", \"类型\": \"mini型\"}'),
       (300, 148, '583602734691913728', 4028043, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套', '', '4000620', 659.00, 1,
        410, '4000620-NAVY-L', 109303000, NULL, NULL, NULL, NULL, 659.00, 0, 0, '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (301, 149, '583670338576060416', 1548001, NULL, '添加茂金属更强韧，金属色垃圾袋', '', 'SN1548001', 8.90, 1, 198,
        'OTHER_1548001', 1005999006, NULL, NULL, NULL, NULL, 8.90, 0, 0, '{\"规格\":\"3卷装\"}'),
       (302, 149, '583670338576060416', 4028005, NULL, '可折叠户外防紫外线鸭舌帽', '', '3987478', 44.00, 1, 391,
        'SKU4028005-BLACK', 109313003, NULL, NULL, NULL, NULL, 44.00, 0, 0, '{\"颜色\":\"黑色\"}'),
       (303, 150, '583671167236313088', 4017718, NULL, '油污克星Mootaa重油污清洁剂', '', 'SN4017718', 26.90, 1, 358,
        'SKU4017718-01', 109275000, NULL, NULL, NULL, NULL, 26.90, 0, 0, '{\"规格\":\"标准装\"}'),
       (304, 151, '583675004378550272', 1589017, NULL, '分场景使用不污染，超细纤维抹布分类5件套', '', 'SN1589017', 14.90,
        1, 197, 'OTHER_1589017', 109243016, NULL, NULL, NULL, NULL, 14.90, 0, 0, '{\"规格\":\"5件套\"}'),
       (305, 152, '583675376421703680', 4028004, NULL, '户外快干轻巧遮阳帽', '', '3988016', 44.00, 1, 389,
        'SKU4028004-BLUE', 109313003, NULL, NULL, NULL, NULL, 44.00, 0, 0, '{\"颜色\":\"深蓝\"}'),
       (306, 153, '583681059028340736', 4028030, NULL, '入门首选，语音播报电子血压计', '', '3997974', 109.00, 1, 498,
        '4028030-01', 109293000, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"显示方式\":\"LED背光\",\"记忆组数\":\"99组\"}'),
       (307, 154, '583681739428335616', 4028043, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套', '', '4000620', 659.00, 1,
        410, '4000620-NAVY-L', 109303000, NULL, NULL, NULL, NULL, 659.00, 0, 0, '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (308, 155, '583681835662446592', 4028005, NULL, '可折叠户外防紫外线鸭舌帽', '', '3987478', 44.00, 1, 391,
        'SKU4028005-BLACK', 109313003, NULL, NULL, NULL, NULL, 44.00, 0, 0, '{\"颜色\":\"黑色\"}'),
       (309, 156, '583688532841861120', 1085007, NULL, '一抽即提，免脏手，加厚抽绳垃圾袋3卷60只', '', 'SN1085007', 9.50,
        1, 251, 'LJD1085-60', 1005999006, NULL, NULL, NULL, NULL, 9.50, 0, 0, '{\"规格\":\"18μm\",\"数量\":\"60只\"}'),
       (310, 157, '583688646754963456', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (311, 158, '584039971644641280', 4028039, NULL, '冻干藤椒豚骨面74克*12盒', '', '3464033', 79.00, 1, 438,
        '3464033-SPICY-12', 109201001, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (312, 159, '584041051665338368', 4028043, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套', '', '4000620', 659.00, 1,
        410, '4000620-NAVY-L', 109303000, NULL, NULL, NULL, NULL, 659.00, 0, 0, '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (313, 160, '584041312924340224', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (314, 161, '584041621520257024', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (315, 162, '584042267325632512', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (316, 163, '584188670366584832', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (317, 164, '584191981266276352', 1555000, NULL, '舒眠真丝眼罩', '', '1555000', 79.00, 1, 249, 'YZ1555-01',
        109318003, NULL, NULL, NULL, NULL, 79.00, 0, 0, '{\"颜色\":\"黑色\"}'),
       (318, 165, '584192881045147648', 4028041, NULL, '恍若没穿鞋，女式轻软舒弹健步鞋2.0', '', '4000914', 159.00, 1,
        403, '4000914-WHITE-36', 109311007, NULL, NULL, NULL, NULL, 159.00, 0, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"36\"}'),
       (319, 166, '584193647512260608', 4028028, NULL, '七夕礼物·挺拔身姿，隐形内穿矫姿带', '', '3992367', 149.00, 1,
        467, '3992367-INVIS', 109293000, NULL, NULL, NULL, NULL, 149.00, 0, 0,
        '{\"佩戴方式\":\"隐形款\",\"支撑强度\":\"中级\"}'),
       (320, 167, '584194239827677184', 4028039, NULL, '冻干藤椒豚骨面74克*12盒', '', '3464033', 79.00, 1, 438,
        '3464033-SPICY-12', 109201001, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (321, 168, '584195455513137152', 4028043, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套', '', '4000620', 659.00, 1,
        410, '4000620-NAVY-L', 109303000, NULL, NULL, NULL, NULL, 659.00, 0, 0, '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (322, 169, '584195936171986944', 1589017, NULL, '分场景使用不污染，超细纤维抹布分类5件套', '', 'SN1589017', 14.90,
        1, 197, 'OTHER_1589017', 109243016, NULL, NULL, NULL, NULL, 14.90, 0, 0, '{\"规格\":\"5件套\"}'),
       (323, 170, '584197378760904704', 4023638, NULL, '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1,
        339, 'SN4023638-26-RED', 1037006, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (324, 171, '584199663880638464', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (325, 172, '584200348844036096', 4023638, NULL, '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1,
        339, 'SN4023638-26-RED', 1037006, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (326, 173, '584207228081410048', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (327, 174, '584209486105939968', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (328, 175, '584218102657585152', 1085007, NULL, '一抽即提，免脏手，加厚抽绳垃圾袋3卷60只', '', 'SN1085007', 9.50,
        1, 251, 'LJD1085-60', 1005999006, NULL, NULL, NULL, NULL, 9.50, 0, 0, '{\"规格\":\"18μm\",\"数量\":\"60只\"}'),
       (329, 176, '584228584357498880', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (330, 177, '584229876882608128', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (331, 178, '584230694356652032', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (332, 179, '584232456652197888', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 2, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (333, 180, '584232793534500864', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (334, 181, '584351793383870464', 4028017, NULL, '消炎镇痛一贴灵医用冷敷贴60贴/盒', '', 'SN3991840', 79.00, 1,
        481, 'SN3991840-60mini', 109293000, NULL, NULL, NULL, NULL, 79.00, 0, 0,
        '{\"规格\": \"60贴\", \"类型\": \"mini型\"}'),
       (335, 182, '584742299834126336', 1111002, NULL, '剪出精致感，金致圆柄复古剪刀', '', 'SN1111002', 9.90, 1, 319,
        'SN1111002-GD', 109243046, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"金色\"}'),
       (336, 182, '584742299834126336', 3998535, NULL, '学步更自如，婴幼童机能学步鞋4-6码', '', 'SN3998535', 109.00, 1,
        299, 'SN3998535-4', 109243022, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺码\": \"4码\", \"适用阶段\": \"学步期\"}'),
       (337, 183, '584743052543922176', 3998535, NULL, '学步更自如，婴幼童机能学步鞋4-6码', '', 'SN3998535', 109.00, 1,
        299, 'SN3998535-4', 109243022, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺码\": \"4码\", \"适用阶段\": \"学步期\"}'),
       (338, 184, '584743493293969408', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (339, 185, '584745430793981952', 3999485, NULL, '意大利大公鸡管家重油污克星清洁剂625ml', '', 'SN3999485', 39.00,
        1, 356, 'SKU3999485-01', 109275000, NULL, NULL, NULL, NULL, 39.00, 0, 0, '{\"容量\":\"625ml\"}'),
       (340, 186, '584746969449238528', 4023638, NULL, '抓绒保暖，毛毛虫儿童运动鞋26-30', '', 'SN4023638', 109.00, 1,
        339, 'SN4023638-26-RED', 1037006, NULL, NULL, NULL, NULL, 109.00, 0, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (341, 187, '584747230817292288', 4028025, NULL, '新年佳礼，家用SPA多功能按摩床垫', '', '3995284', 599.00, 1, 463,
        '3995284-BASIC', 109293000, NULL, NULL, NULL, NULL, 599.00, 0, 0,
        '{\"模式\":\"3种基础模式\",\"承重\":\"150kg\"}'),
       (342, 188, '584748564790513664', 3465081, NULL, '清洁养护一片搞定皮革护理湿巾', '', 'SN3465081', 9.90, 1, 265,
        'SKU3465081-黑XXL', 109256013, NULL, NULL, NULL, NULL, 9.90, 0, 0, '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}');
/*!40000 ALTER TABLE `oms_order_item`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oms_order_operate_history`
--

DROP TABLE IF EXISTS `oms_order_operate_history`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oms_order_operate_history`
(
    `id`           int NOT NULL AUTO_INCREMENT,
    `order_id`     int      DEFAULT NULL COMMENT '订单id',
    `operate_man`  text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '操作人：用户；系统；后台管理员',
    `create_time`  datetime DEFAULT NULL COMMENT '操作时间',
    `order_status` int      DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
    `note`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 66
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='订单操作历史记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oms_order_operate_history`
--

LOCK TABLES `oms_order_operate_history` WRITE;
/*!40000 ALTER TABLE `oms_order_operate_history`
    DISABLE KEYS */;
INSERT INTO `oms_order_operate_history`
VALUES (5, 12, '后台管理员', '2018-10-12 14:01:29', 2, '完成发货'),
       (6, 13, '后台管理员', '2018-10-12 14:01:29', 2, '完成发货'),
       (7, 12, '后台管理员', '2018-10-12 14:13:10', 4, '订单关闭:买家退货'),
       (8, 13, '后台管理员', '2018-10-12 14:13:10', 4, '订单关闭:买家退货'),
       (9, 22, '后台管理员', '2018-10-15 16:31:48', 4, '订单关闭:xxx'),
       (10, 22, '后台管理员', '2018-10-15 16:35:08', 4, '订单关闭:xxx'),
       (11, 22, '后台管理员', '2018-10-15 16:35:59', 4, '订单关闭:xxx'),
       (12, 17, '后台管理员', '2018-10-15 16:43:40', 4, '订单关闭:xxx'),
       (13, 25, '后台管理员', '2018-10-15 16:52:14', 4, '订单关闭:xxx'),
       (14, 26, '后台管理员', '2018-10-15 16:52:14', 4, '订单关闭:xxx'),
       (15, 23, '后台管理员', '2018-10-16 14:41:28', 2, '完成发货'),
       (16, 13, '后台管理员', '2018-10-16 14:42:17', 2, '完成发货'),
       (17, 18, '后台管理员', '2018-10-16 14:42:17', 2, '完成发货'),
       (18, 26, '后台管理员', '2018-10-30 14:37:44', 4, '订单关闭:关闭订单'),
       (19, 25, '后台管理员', '2018-10-30 15:07:01', 0, '修改收货人信息'),
       (20, 25, '后台管理员', '2018-10-30 15:08:13', 0, '修改费用信息'),
       (21, 25, '后台管理员', '2018-10-30 15:08:31', 0, '修改备注信息：xxx'),
       (22, 25, '后台管理员', '2018-10-30 15:08:39', 4, '订单关闭:2222'),
       (23, 12, '后台管理员', '2019-11-09 16:50:28', 4, '修改备注信息：111'),
       (24, 30, '后台管理员', '2020-02-25 16:52:37', 0, '修改费用信息'),
       (25, 30, '后台管理员', '2020-02-25 16:52:51', 0, '修改费用信息'),
       (26, 30, '后台管理员', '2020-02-25 16:54:03', 2, '完成发货'),
       (27, 27, '管理员', '2022-12-06 11:25:38', 4, '顾客不想买了'),
       (28, 13, '管理员', '2022-12-06 11:31:13', 1, '修改订单备注：轻拿轻放\n'),
       (29, 13, '系统管理员', '2022-12-07 09:26:36', 2, '订单发货'),
       (30, 28, '系统管理员', '2022-12-07 10:15:03', 0, '修改费用信息'),
       (31, 28, '暂时不写', '2023-02-15 10:56:31', 4, '关闭订单：超时未支付'),
       (32, 29, 'orderAdmin/订单管理员', '2023-02-15 11:32:22', 4, '关闭订单：顾客不想要了！'),
       (33, 28, 'orderAdmin/订单管理员', '2023-02-15 14:04:06', 4, '关闭订单：测试'),
       (34, 29, 'orderAdmin/订单管理员', '2023-02-15 14:26:12', 0, '修改收件人地址！'),
       (35, 29, 'orderAdmin/订单管理员', '2023-02-15 14:54:19', 0, '修改订单费用信息！'),
       (36, 29, 'orderAdmin/订单管理员', '2023-02-15 14:56:29', 0, '修改订单费用信息！'),
       (37, 23, 'orderAdmin/订单管理员', '2023-02-15 15:45:49', 1, '修改备注：易碎物品，轻拿轻放！'),
       (38, 29, 'orderAdmin/订单管理员', '2023-02-15 15:50:35', 0, '修改备注：贵重商品，妥善投递！'),
       (39, 23, 'admin/系统管理员', '2023-02-15 16:21:46', 2, '订单发货！'),
       (40, 16, '系统管理员', '2023-02-15 16:55:40', 4, '删除订单！'),
       (41, 17, '系统管理员', '2023-02-15 16:57:19', 4, '删除订单！'),
       (42, 22, '系统管理员', '2023-02-15 16:57:19', 4, '删除订单！'),
       (43, 21, '系统管理员', '2023-02-15 16:57:36', 4, '删除订单！'),
       (44, 28, '系统管理员', '2023-02-15 16:57:36', 4, '删除订单！'),
       (45, 16, '系统管理员', '2023-02-15 16:58:23', 4, '删除订单！'),
       (46, 17, '系统管理员', '2023-02-15 16:58:23', 4, '删除订单！'),
       (47, 21, '系统管理员', '2023-02-15 16:58:23', 4, '删除订单！'),
       (48, 22, '系统管理员', '2023-02-15 16:58:23', 4, '删除订单！'),
       (50, 29, '当前登录管理员', '2024-01-25 15:12:53', 4, '顾客不想要了！！！'),
       (54, 29, '当前登录管理员', '2024-01-25 15:30:14', 4, 'hello'),
       (55, 13, '当前登录管理员', '2024-01-25 16:56:59', 2, '订单发货'),
       (56, 18, '当前登录管理员', '2024-01-25 16:56:59', 2, '订单发货'),
       (57, 21, '7,orderAdmin', '2024-01-26 09:55:16', 6, '删除订单'),
       (58, 22, '7,orderAdmin', '2024-01-26 09:55:16', 6, '删除订单'),
       (59, 13, '登录人信息', '2024-01-26 10:41:26', 0, '修改收件人信息'),
       (60, 13, '7,orderAdmin', '2024-01-26 11:48:26', 0, '修改费用信息'),
       (61, 127, '13,admin666', '2025-05-22 16:23:27', 2, '订单发货'),
       (62, 133, '13,admin666', '2025-05-22 16:34:42', 2, '订单发货'),
       (63, 126, '13,admin666', '2025-05-22 16:48:03', 2, '订单发货'),
       (64, 125, '13,admin666', '2025-05-22 16:52:36', 2, '订单发货'),
       (65, 124, '13,admin666', '2025-05-22 16:57:42', 2, '订单发货');
/*!40000 ALTER TABLE `oms_order_operate_history`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oms_order_return_apply`
--

DROP TABLE IF EXISTS `oms_order_return_apply`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oms_order_return_apply`
(
    `id`                 int NOT NULL AUTO_INCREMENT,
    `order_id`           int                                                          DEFAULT NULL COMMENT '订单id',
    `company_address_id` int                                                          DEFAULT NULL COMMENT '收货地址表id',
    `product_id`         int                                                          DEFAULT NULL COMMENT '退货商品id',
    `order_sn`           varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单编号',
    `create_time`        datetime                                                     DEFAULT NULL COMMENT '申请时间',
    `member_username`    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '会员用户名',
    `return_amount`      decimal(10, 2)                                               DEFAULT NULL COMMENT '退款金额',
    `return_name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '退货人姓名',
    `return_phone`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '退货人电话',
    `status`             int                                                          DEFAULT NULL COMMENT '申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝',
    `handle_time`        datetime                                                     DEFAULT NULL COMMENT '处理时间',
    `product_pic`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品图片',
    `product_name`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品名称',
    `product_brand`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品品牌',
    `product_attr`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品销售属性：颜色：红色；尺码：xl;',
    `product_count`      int                                                          DEFAULT NULL COMMENT '退货数量',
    `product_price`      decimal(10, 2)                                               DEFAULT NULL COMMENT '商品单价',
    `product_real_price` decimal(10, 2)                                               DEFAULT NULL COMMENT '商品实际支付单价',
    `reason`             text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '原因',
    `description`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `proof_pics`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '凭证图片，以逗号隔开',
    `handle_note`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '处理备注',
    `handle_man`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '处理人员',
    `receive_man`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '收货人',
    `receive_time`       datetime                                                     DEFAULT NULL COMMENT '收货时间',
    `receive_note`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '收货备注',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 27
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = DYNAMIC COMMENT ='订单退货申请';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oms_order_return_apply`
--

LOCK TABLES `oms_order_return_apply` WRITE;
/*!40000 ALTER TABLE `oms_order_return_apply`
    DISABLE KEYS */;
INSERT INTO `oms_order_return_apply`
VALUES (3, 12, 4, 26, '201809150101000001', '2018-10-17 14:34:57', 'test', 3585.98, '大梨', '18000000000', 1, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg',
        '可以退款', 'admin', 'admin', NULL, NULL),
       (4, 12, 2, 27, '201809150101000001', '2018-10-17 14:40:21', 'test', 3585.98, '大梨', '18000000000', 2,
        '2022-12-08 11:20:52', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8',
        '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '已经处理了', 'admin', 'admin',
        '2022-12-08 11:20:52', '已收到退货，货品完整无损失'),
       (5, 12, 3, 28, '201809150101000001', '2018-10-17 14:44:18', 'test', 3585.98, '大梨', '18000000000', 2,
        '2018-10-18 13:55:28',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '已经处理了', 'admin', 'admin',
        '2018-10-18 13:55:58', '已经处理了'),
       (8, 13, NULL, 28, '201809150102000002', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 3,
        '2018-10-18 13:57:12',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '理由不够充分', 'admin', NULL, NULL, NULL),
       (9, 14, 2, 26, '201809130101000001', '2018-10-17 14:34:57', 'test', 3500.00, '大梨', '18000000000', 2,
        '2018-10-24 15:44:56',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', '呵呵', 'admin', 'admin',
        '2018-10-24 15:46:35', '收货了'),
       (10, 14, NULL, 27, '201809130101000001', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 3,
        '2018-10-24 15:46:57', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8',
        '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '就是不退', 'admin', NULL, NULL,
        NULL),
       (11, 14, 2, 28, '201809130101000001', '2018-10-17 14:44:18', 'test', 591.05, '大梨', '18000000000', 1,
        '2018-10-24 17:09:04',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '可以退款', 'admin', NULL, NULL, NULL),
       (12, 15, 3, 26, '201809130102000002', '2018-10-17 14:34:57', 'test', 3500.00, '大梨', '18000000000', 2,
        '2018-10-24 17:22:54',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', '退货了', 'admin', 'admin',
        '2018-10-24 17:23:06', '收货了'),
       (13, 15, NULL, 27, '201809130102000002', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 3,
        '2018-10-24 17:23:30', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8',
        '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '无法退货', 'admin', NULL, NULL,
        NULL),
       (15, 16, 2, 26, '201809140101000001', '2018-10-17 14:34:57', 'test', 3585.98, '大梨', '18000000000', 2,
        '2022-12-08 11:16:52',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', '确认退货：可以退货', 'admin', NULL,
        NULL, NULL),
       (16, 16, NULL, 27, '201809140101000001', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 3,
        '2022-12-08 11:06:02', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8',
        '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '拒绝退货：退货理由不充分！',
        'admin', NULL, NULL, NULL),
       (17, 16, 4, 28, '201809140101000001', '2018-10-17 14:44:18', 'test', 591.05, '大梨', '18000000000', 1,
        '2023-02-14 16:52:59',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '11', 'admin', 'admin', NULL, NULL),
       (18, 17, 4, 26, '201809150101000003', '2018-10-17 14:34:57', 'test', 0.00, '大梨', '18000000000', 3,
        '2023-02-14 16:57:18',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, 'admin', 'admin', NULL,
        NULL),
       (19, 17, 4, 27, '201809150101000003', '2018-10-17 14:40:21', 'test', 2022.81, '大梨', '18000000000', 2,
        '2023-02-14 16:57:33', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8',
        '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '11', 'admin', 'admin',
        '2023-02-14 16:58:08', '已收到退货，检查无问题！'),
       (20, 17, 4, 28, '201809150101000003', '2018-10-17 14:44:18', 'test', 0.00, '大梨', '18000000000', 1,
        '2023-02-15 11:13:08',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, 'admin', 'admin', NULL, NULL),
       (21, 18, 4, 26, '201809150102000004', '2018-10-17 14:34:57', 'test', 3585.98, '大梨', '18000000000', 2,
        '2024-01-26 15:14:15',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, 'admin', '当前登录用户',
        '2024-01-26 15:14:15', '退货商品无损坏！'),
       (22, 18, NULL, 27, '201809150102000004', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米',
        '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL),
       (23, 18, NULL, 28, '201809150102000004', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL),
       (24, 19, NULL, 26, '201809130101000003', '2018-10-17 14:34:57', 'test', NULL, '大梨', '18000000000', 0, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20',
        '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, NULL, NULL, NULL, NULL),
       (25, 19, NULL, 27, '201809130101000003', '2023-02-13 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米',
        '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL),
       (26, 19, NULL, 28, '201809130101000003', '2023-02-14 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米',
        '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `oms_order_return_apply`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oms_order_return_reason`
--

DROP TABLE IF EXISTS `oms_order_return_reason`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oms_order_return_reason`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '退货类型',
    `sort`        int      DEFAULT NULL COMMENT '排序',
    `status`      int      DEFAULT NULL COMMENT '状态：0->不启用；1->启用',
    `create_time` datetime DEFAULT NULL COMMENT '添加时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 22
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='退货原因表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oms_order_return_reason`
--

LOCK TABLES `oms_order_return_reason` WRITE;
/*!40000 ALTER TABLE `oms_order_return_reason`
    DISABLE KEYS */;
INSERT INTO `oms_order_return_reason`
VALUES (1, '质量问题', 1, 1, '2018-10-17 10:00:45'),
       (2, '尺码太大', 1, 1, '2018-10-17 10:01:03'),
       (3, '颜色不喜欢', 1, 1, '2018-10-17 10:01:13'),
       (4, '7天无理由退货', 1, 1, '2018-10-17 10:01:47'),
       (5, '价格问题', 1, 0, '2018-10-17 10:01:57'),
       (12, '发票问题', 0, 1, '2018-10-19 16:28:36'),
       (13, '其他问题', 0, 1, '2018-10-19 16:28:51'),
       (14, '物流问题', 0, 1, '2018-10-19 16:29:01'),
       (15, '售后问题', 0, 1, '2018-10-19 16:29:11'),
       (16, '测试原因', 1, 1, '2022-12-08 08:40:09'),
       (19, '不想要了', 0, 1, '2023-02-14 15:14:22'),
       (20, '发货时间问题', 0, 1, '2023-02-14 15:14:39'),
       (21, '测试2', 0, 1, '2023-02-14 15:14:54');
/*!40000 ALTER TABLE `oms_order_return_reason`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_banner`
--

DROP TABLE IF EXISTS `pms_banner`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_banner`
(
    `id`         bigint       NOT NULL COMMENT '轮播图ID',
    `img_url`    varchar(500) NOT NULL COMMENT '图片地址',
    `type`       tinyint      NOT NULL COMMENT '类型（1-商品轮播）',
    `product_id` bigint       NOT NULL COMMENT '关联商品ID',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='商品轮播图表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_banner`
--

LOCK TABLES `pms_banner` WRITE;
/*!40000 ALTER TABLE `pms_banner`
    DISABLE KEYS */;
INSERT INTO `pms_banner`
VALUES (16, 'http://localhost:9000/images/banners/dfc11bb0-4af5-4e9b-9458-99f615cc685a.jpg', 1, 1369155859933827074),
       (17, 'http://localhost:9000/images/banners/4a79180a-1a5a-4042-8a77-4db0b9c800a8.jpg', 1, 1183010),
       (18, 'http://localhost:9000/images/banners/1ba86bcc-ae71-42a3-bc3e-37b662f7f07e.jpg', 1, 1108008),
       (19, 'http://localhost:9000/images/banners/6d202d8e-bb47-4f92-9523-f32ab65754f4.jpg', 1, 4001920),
       (20, 'http://localhost:9000/images/banners/e83efb1b-309c-46f7-98a3-f1fefa694338.jpg', 1, 4001880);
/*!40000 ALTER TABLE `pms_banner`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_brand`
--

DROP TABLE IF EXISTS `pms_brand`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_brand`
(
    `id`                    int NOT NULL AUTO_INCREMENT,
    `name`                  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品牌名称',
    `first_letter`          varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  DEFAULT NULL COMMENT '首字母',
    `sort`                  int                                                          DEFAULT NULL COMMENT '排序',
    `factory_status`        int                                                          DEFAULT NULL COMMENT '是否为品牌制造商：0->不是；1->是',
    `show_status`           int                                                          DEFAULT NULL COMMENT '是否显示',
    `product_count`         int                                                          DEFAULT NULL COMMENT '产品数量',
    `product_comment_count` int                                                          DEFAULT NULL COMMENT '产品评论数量',
    `logo`                  text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '品牌logo',
    `big_pic`               text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '专区大图',
    `brand_story`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '品牌故事',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 72
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='品牌表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_brand`
--

LOCK TABLES `pms_brand` WRITE;
/*!40000 ALTER TABLE `pms_brand`
    DISABLE KEYS */;
INSERT INTO `pms_brand`
VALUES (1, '万和', 'W', 1, 1, 1, 100, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(5).jpg', '',
        'Victoria\'s Secret的故事'),
       (2, '三星', 'S', 100, 1, 1, 101, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (1).jpg', NULL, '三星的故事'),
       (3, '华为', 'H', 100, 1, 1, 100, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (2).jpg', NULL,
        'Victoria\'s Secret的故事'),
       (4, '格力', 'G', 30, 1, 1, 100, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (3).jpg', NULL,
        'Victoria\'s Secret的故事'),
       (5, '方太', 'F', 20, 1, 1, 100, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg', NULL,
        'Victoria\'s Secret的故事'),
       (6, '小米', 'M', 500, 1, 1, 100, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/5a912944N474afb7a.png',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/5afd7778Nf7800b75.jpg', '小米手机的故事'),
       (21, 'OPPO', 'O', 0, 1, 1, 88, 500,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg', '', 'string'),
       (49, '七匹狼', 'S', 200, 1, 1, 77, 400,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/1522738681.jpg', NULL, 'BOOB的故事'),
       (50, '海澜之家', 'H', 200, 1, 1, 66, 300,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/LOGO1024.png', '', '海澜之家的故事'),
       (51, '苹果', 'A', 200, 1, 1, 55, 200,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, '苹果的故事'),
       (58, 'NIKE', 'N', 0, 1, 1, 33, 100,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/timg (51).jpg', '', 'NIKE的故事'),
       (59, '伊利', 'Y', 0, 1, 1, NULL, NULL, 'http://localhost:8080/minio/image/8486945838d24a009b3f018dd5543378.png',
        '', '中国第一大乳制品生产商'),
       (61, '雪中飞', 'N', 0, 1, 1, NULL, NULL,
        'http://localhost:8000/minio/image/b821bdde6680482fa09a394f89ac8d46.jpg',
        'http://localhost:8000/minio/image/9f6a17d0b0c840f88a488d9dbf188e67.jpg',
        '雪中飞品牌是以羽绒服为基础 [3]  ，并打造为具有影响力的活力时尚运动服装品牌。“雪中飞”品牌创立于功能服装行业蓬勃发展的20世纪末。'),
       (62, '居家', 'J', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/201516e3-25d0-48f5-bcee-7f0cafb14176.png',
        NULL, NULL),
       (63, '美食', 'M', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/cf82e5b4-bf1b-4c68-aa86-96f66e8e5282.png',
        NULL, NULL),
       (64, '服饰', 'F', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/33e1f5de-0fdb-4cfa-9ba9-781233024b53.png',
        NULL, NULL),
       (65, '母婴', 'M', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/b514a526-4010-4ce8-8cb9-757ed382f84a.png',
        NULL, NULL),
       (66, '个护', 'G', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/d38a73b8-cd03-48aa-a60b-e7c4e16667ed.png',
        NULL, NULL),
       (67, '严选', 'Y', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/4b02f01f-a365-4b6c-9f7a-8b0f591dda02.png',
        NULL, NULL),
       (68, '数码', 'S', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/9660870d-6a59-4624-8064-b3a8cbf50d5c.png',
        NULL, NULL),
       (69, '运动', 'Y', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/7d19752c-baff-49b6-bd02-5ece1d729214.png',
        NULL, NULL),
       (70, '杂项', 'Z', 0, 1, 1, 0, 0,
        'http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-05-06/4ff20b9e-8150-4bd3-87a3-0cd6766938dd.png',
        NULL, NULL),
       (71, '传智自有品牌', 'C', 1, 1, 1, NULL, NULL,
        'https://yanxuan-item.nosdn.127.net/f6ddd429632de6170900dc2fbc541fd8.png',
        'https://yanxuan-item.nosdn.127.net/f6ddd429632de6170900dc2fbc541fd8.png', NULL);
/*!40000 ALTER TABLE `pms_brand`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_comment_replay`
--

DROP TABLE IF EXISTS `pms_comment_replay`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_comment_replay`
(
    `id`               int NOT NULL AUTO_INCREMENT,
    `comment_id`       int      DEFAULT NULL COMMENT '评论id',
    `member_nick_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回复评论的会员昵称',
    `member_icon`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回复评论的会员头像',
    `content`          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回复的内容',
    `create_time`      datetime DEFAULT NULL COMMENT '时间',
    `type`             int      DEFAULT NULL COMMENT '评论人员类型；0->会员；1->管理员',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品评价回复表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_comment_replay`
--

LOCK TABLES `pms_comment_replay` WRITE;
/*!40000 ALTER TABLE `pms_comment_replay`
    DISABLE KEYS */;
INSERT INTO `pms_comment_replay`
VALUES (1, 1, 'windy', NULL, '你好', '2024-04-11 12:22:17', 0);
/*!40000 ALTER TABLE `pms_comment_replay`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_member_price`
--

DROP TABLE IF EXISTS `pms_member_price`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_member_price`
(
    `id`                int NOT NULL AUTO_INCREMENT,
    `product_id`        int            DEFAULT NULL COMMENT '商品id',
    `member_level_id`   int            DEFAULT NULL COMMENT '会员等级',
    `member_price`      decimal(10, 2) DEFAULT NULL COMMENT '会员价格',
    `member_level_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '会员等级名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 255
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='商品会员价格表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_member_price`
--

LOCK TABLES `pms_member_price` WRITE;
/*!40000 ALTER TABLE `pms_member_price`
    DISABLE KEYS */;
INSERT INTO `pms_member_price`
VALUES (26, 7, 1, 500.00, NULL),
       (27, 8, 1, 500.00, NULL),
       (28, 9, 1, 500.00, NULL),
       (29, 10, 1, 500.00, NULL),
       (30, 11, 1, 500.00, NULL),
       (31, 12, 1, 500.00, NULL),
       (32, 13, 1, 500.00, NULL),
       (33, 14, 1, 500.00, NULL),
       (37, 18, 1, 500.00, NULL),
       (44, 7, 2, 480.00, NULL),
       (45, 7, 3, 450.00, NULL),
       (52, 22, 1, NULL, NULL),
       (53, 22, 2, NULL, NULL),
       (54, 22, 3, NULL, NULL),
       (58, 24, 1, NULL, NULL),
       (59, 24, 2, NULL, NULL),
       (60, 24, 3, NULL, NULL),
       (112, 23, 1, 88.00, '黄金会员'),
       (113, 23, 2, 88.00, '白金会员'),
       (114, 23, 3, 66.00, '钻石会员'),
       (142, 31, 1, NULL, '黄金会员'),
       (143, 31, 2, NULL, '白金会员'),
       (144, 31, 3, NULL, '钻石会员'),
       (148, 32, 1, NULL, '黄金会员'),
       (149, 32, 2, NULL, '白金会员'),
       (150, 32, 3, NULL, '钻石会员'),
       (154, 33, 1, NULL, '黄金会员'),
       (155, 33, 2, NULL, '白金会员'),
       (156, 33, 3, NULL, '钻石会员'),
       (175, 34, 1, NULL, '黄金会员'),
       (176, 34, 2, NULL, '白金会员'),
       (177, 34, 3, NULL, '钻石会员'),
       (178, 30, 1, NULL, '黄金会员'),
       (179, 30, 2, NULL, '白金会员'),
       (180, 30, 3, NULL, '钻石会员'),
       (192, 27, 1, NULL, '黄金会员'),
       (193, 27, 2, NULL, '白金会员'),
       (194, 27, 3, NULL, '钻石会员'),
       (195, 28, 1, NULL, '黄金会员'),
       (196, 28, 2, NULL, '白金会员'),
       (197, 28, 3, NULL, '钻石会员'),
       (198, 29, 1, NULL, '黄金会员'),
       (199, 29, 2, NULL, '白金会员'),
       (200, 29, 3, NULL, '钻石会员'),
       (201, 26, 1, NULL, '黄金会员'),
       (202, 26, 2, NULL, '白金会员'),
       (203, 26, 3, NULL, '钻石会员'),
       (246, 36, 1, NULL, '黄金会员'),
       (247, 36, 2, NULL, '白金会员'),
       (248, 36, 3, NULL, '钻石会员'),
       (249, 35, 1, NULL, '黄金会员'),
       (250, 35, 2, NULL, '白金会员'),
       (251, 35, 3, NULL, '钻石会员'),
       (252, 39, 1, 4559.00, '黄金会员'),
       (253, 39, 2, 4499.00, '白金会员'),
       (254, 39, 3, 4399.00, '钻石会员');
/*!40000 ALTER TABLE `pms_member_price`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product`
--

DROP TABLE IF EXISTS `pms_product`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product`
(
    `id`                            int                                                          NOT NULL AUTO_INCREMENT,
    `brand_id`                      int                                                          DEFAULT NULL COMMENT '品牌id',
    `product_category_id`           int                                                          DEFAULT NULL COMMENT '商品类别',
    `feight_template_id`            int                                                          DEFAULT NULL COMMENT '运费标准id',
    `product_attribute_category_id` int                                                          DEFAULT NULL COMMENT '商品属性分类id',
    `name`                          varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
    `pic`                           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '封面',
    `product_sn`                    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货号',
    `delete_status`                 int                                                          DEFAULT NULL COMMENT '删除状态：0->未删除；1->已删除',
    `publish_status`                int                                                          DEFAULT NULL COMMENT '上架状态：0->下架；1->上架',
    `new_status`                    int                                                          DEFAULT NULL COMMENT '新品状态:0->不是新品；1->新品',
    `recommand_status`              int                                                          DEFAULT NULL COMMENT '主页推荐状态；0->不推荐；1->推荐',
    `verify_status`                 int                                                          DEFAULT NULL COMMENT '审核状态：0->未审核；1->审核通过',
    `sort`                          int                                                          DEFAULT NULL COMMENT '排序',
    `sale`                          int                                                          DEFAULT NULL COMMENT '销量',
    `price`                         decimal(10, 2)                                               DEFAULT NULL COMMENT '定价',
    `promotion_price`               decimal(10, 2)                                               DEFAULT NULL COMMENT '促销价格',
    `gift_growth`                   int                                                          DEFAULT '0' COMMENT '赠送的成长值',
    `gift_point`                    int                                                          DEFAULT '0' COMMENT '赠送的积分',
    `use_point_limit`               int                                                          DEFAULT NULL COMMENT '限制使用的积分数',
    `sub_title`                     text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '副标题',
    `description`                   text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品描述',
    `original_price`                decimal(10, 2)                                               DEFAULT NULL COMMENT '市场价',
    `stock`                         int                                                          DEFAULT NULL COMMENT '库存',
    `low_stock`                     int                                                          DEFAULT NULL COMMENT '库存预警值',
    `unit`                          varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '单位',
    `weight`                        decimal(10, 2)                                               DEFAULT NULL COMMENT '商品重量，默认为克',
    `preview_status`                int                                                          DEFAULT NULL COMMENT '是否为预告商品：0->不是；1->是',
    `service_ids`                   varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
    `keywords`                      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品关键词',
    `note`                          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注',
    `album_pics`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '画册图片，连产品图片限制为5张，以逗号分割',
    `detail_title`                  text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '详细标题',
    `detail_desc`                   text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '详细描述',
    `detail_mobile_html`            text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '移动端网页详情',
    `promotion_start_time`          datetime                                                     DEFAULT NULL COMMENT '促销开始时间',
    `promotion_end_time`            datetime                                                     DEFAULT NULL COMMENT '促销结束时间',
    `promotion_per_limit`           int                                                          DEFAULT NULL COMMENT '活动限购数量',
    `promotion_type`                int                                                          DEFAULT NULL COMMENT '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
    `brand_name`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '品牌名称',
    `product_category_name`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品分类名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4028057
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = DYNAMIC COMMENT ='商品信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product`
--

LOCK TABLES `pms_product` WRITE;
/*!40000 ALTER TABLE `pms_product`
    DISABLE KEYS */;
INSERT INTO `pms_product`
VALUES (24, 6, 7, 0, NULL, 'xxx', '', '', 1, 0, NULL, 0, 0, 0, 100, 0.00, NULL, 0, 0, 0, 'xxx', '', 0.00, 100, 0, '',
        0.00, 0, '', '', '', '', '', '', '', NULL, NULL, 0, 0, '小米', '外套'),
       (26, 3, 19, 0, 3, '华为 HUAWEI P20 ',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '6946605', 1, 1,
        NULL, 1, 0, 100, 100, 3788.00, NULL, 3788, 3788, 0,
        'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', '', 4288.00, 2359, 0, '件',
        0.00, 1, '2,3,1', '', '',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '', '', '', NULL,
        NULL, 0, 1, '华为', '手机通讯'),
       (27, 6, 19, 0, 3, '小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '7437788', 1, 1, NULL, 1, 0, 0,
        100, 2599.00, NULL, 2699, 2699, 0, '骁龙845处理器，红外人脸解锁，AI变焦双摄，AI语音助手小米6X低至1299，点击抢购',
        '小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待', 2699.00, 100, 0, '', 0.00, 0, '', '', '',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '', '', '', NULL, NULL, 0, 3,
        '小米', '手机数码'),
       (1006029, 62, 109261055, NULL, NULL, '【新疆棉】宝宝也能用，全棉华夫格毛巾',
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png', 'SN1006029', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 15.90, NULL, 0, 0, NULL, '空气华夫格，自然新疆棉', '空气华夫格，自然新疆棉', 15.90,
        900, NULL, NULL, 150.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1006051, 62, 109261055, NULL, NULL, '【新疆棉】云珍·轻软旅行长绒棉毛巾',
        'http://localhost:9000/images/category/personalCare/2a16452169f9d2e8841ddef76fdd684a.png', 'SN1006051', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 31.90, NULL, 0, 0, NULL, '轻软亲肤，热销50万条', '轻软亲肤，热销50万条', 31.90, 600,
        NULL, NULL, 250.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/2a16452169f9d2e8841ddef76fdd684a.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1009026, 62, 109261055, NULL, NULL, '【新疆棉】云珍·轻软长绒棉浴巾',
        'http://localhost:9000/images/category/personalCare/957d7a338fc0de044965cc279fce68b2.png', 'SN1009026', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 129.00, NULL, 0, 0, NULL, '云朵般轻软，至柔至软', '云朵般轻软，至柔至软', 129.00,
        300, NULL, NULL, 800.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/957d7a338fc0de044965cc279fce68b2.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1021000, 62, 1013001, NULL, NULL, '厚厚一按就干爽，埃及进口长绒棉毛巾',
        'http://localhost:9000/images/category/personalCare/a5c5398a7c033edb8a052fe1fddf8a81.png', 'SN1021000', 0, 1,
        NULL, NULL, NULL, NULL, 100, 16.90, NULL, 0, 0, NULL, '厚实大毛圈，干爽瞬吸', '厚实大毛圈，干爽瞬吸', 16.90, 750,
        NULL, NULL, 220.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/a5c5398a7c033edb8a052fe1fddf8a81.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1076004, 0, 109261055, NULL, NULL, '软糯治愈系擦手，雪尼尔擦手球',
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', 'SN1076004', 0, 1, NULL, NULL, NULL,
        NULL, 800, 9.50, NULL, 0, 0, NULL, '雪尼尔擦手球', '吸水快干，不易掉屑', 9.50, 1000, 50, NULL, NULL, NULL, NULL,
        '擦手球,清洁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1085007, 0, 1005999006, NULL, NULL, '一抽即提，免脏手，加厚抽绳垃圾袋3卷60只',
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', 'SN1085007', 0, 1, NULL, NULL, NULL,
        NULL, 800, 9.50, NULL, 0, 0, NULL, '抽绳垃圾袋', '18μm及10μm两种厚度，袋身不怕漏，3秒抽绳不脏手', 9.50, 1000, 50,
        NULL, NULL, NULL, NULL, '垃圾袋,清洁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1111002, 70, 109243046, NULL, NULL, '剪出精致感，金致圆柄复古剪刀',
        'http://localhost:9000/images/category/electronics/4c6a9c8a579b00e5e9c7b002d15a33a2.jpg', 'SN1111002', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 9.90, NULL, 0, 0, NULL, '轻薄设计，简约大方', '轻薄设计，简约大方', 9.90, 1500,
        NULL, NULL, 80.00, NULL, '1,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/4c6a9c8a579b00e5e9c7b002d15a33a2.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1129016, 62, 109261055, NULL, NULL, '【新疆棉】快速擦干，阿瓦提长绒棉毛巾',
        'http://localhost:9000/images/category/personalCare/2f4ff18d601494cb7805ee099ed8a50f.png', 'SN1129016', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 16.90, NULL, 0, 0, NULL, '瞬间吸水，亲肤近0掉毛率', '瞬间吸水，亲肤近0掉毛率',
        16.90, 800, NULL, NULL, 180.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/2f4ff18d601494cb7805ee099ed8a50f.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1306017, 0, 1005999006, NULL, NULL, '大容量干湿分类，脚踏缓降静音垃圾桶',
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', 'SN1306017', 0, 1, NULL, NULL, NULL,
        NULL, 100, 89.00, NULL, 0, 0, NULL, '静音垃圾桶', '一踩开合，解放双手', 89.00, 1000, 50, NULL, NULL, NULL, NULL,
        '垃圾桶,家居', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1306019, 0, 1005999006, NULL, NULL, '日式和风简约无盖垃圾桶11L',
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', 'SN1306019', 0, 1, NULL, NULL, NULL,
        NULL, 100, 9.90, NULL, 0, 0, NULL, '日式垃圾桶', '敞口设计易洗易干触手可得的洁净与精致', 9.90, 1000, 50, NULL,
        NULL, NULL, NULL, '垃圾桶,家居', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1436010, 62, 1013001, NULL, NULL, '囤货装云珍·轻软旅行长绒棉毛巾6条装',
        'http://localhost:9000/images/category/personalCare/f4ed2e5d7b268bb270bce9ce63122ec0.jpg', 'SN1436010', 0, 1,
        NULL, NULL, NULL, NULL, 100, 139.00, NULL, 0, 0, NULL, '触碰云软，热销50万条', '触碰云软，热销50万条', 139.00,
        500, NULL, NULL, 600.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/f4ed2e5d7b268bb270bce9ce63122ec0.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1458011, 70, 109243046, NULL, NULL, '谱写爱的篇章，莫扎特钢笔墨水礼盒',
        'http://localhost:9000/images/category/electronics/b20165617d2f901e9ad926f39b737e87.png', 'SN1458011', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 88.00, NULL, 0, 0, NULL, '谱写爱的乐章', '谱写爱的乐章', 88.00, 450, NULL, NULL,
        450.00, NULL, '1,2', NULL, NULL,
        'http://localhost:9000/images/category/electronics/b20165617d2f901e9ad926f39b737e87.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1512000, 70, 109243046, NULL, NULL, '用心记录每一句诗，飞鸟集钢笔本册文具礼盒',
        'http://localhost:9000/images/category/electronics/3892e311f3494d2bcc2c1f8ed9e34271.png', 'SN1512000', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 89.00, NULL, 0, 0, NULL, '谱写情谊之歌', '谱写情谊之歌', 89.00, 600, NULL, NULL,
        500.00, NULL, '1,2,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/3892e311f3494d2bcc2c1f8ed9e34271.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (1525018, 0, 1005999006, NULL, NULL, '灰尘毛发静电吸附地板除尘干巾40片/包',
        'https://yanxuan-item.nosdn.127.net/cf7584e037706a8df54fecfc6dfdd2af.jpg', 'SN1525018', 0, 1, NULL, NULL, NULL,
        NULL, 100, 7.90, NULL, 0, 0, NULL, '地板除尘干巾', '干湿两用，静电除尘', 7.90, 1000, 50, NULL, NULL, NULL, NULL,
        '除尘,清洁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1540017, 0, NULL, NULL, NULL, '随用随丢，懒人真爱地板清洁/除菌湿巾',
        'https://yanxuan-item.nosdn.127.net/4c8a1cf2b8e40c250870491307dde11f.jpg', 'SN1540017', 0, 1, NULL, NULL, NULL,
        NULL, 100, 8.90, NULL, 0, 0, NULL, '地板清洁湿巾', '材质加厚，耐磨珍珠纹', 8.90, 1000, 50, NULL, NULL, NULL,
        NULL, '湿巾,清洁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1548001, 0, 1005999006, NULL, NULL, '添加茂金属更强韧，金属色垃圾袋',
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', 'SN1548001', 0, 1, NULL, NULL, NULL,
        NULL, 100, 8.90, NULL, 0, 0, NULL, '金属色垃圾袋', '3卷90只，茂金属添加，柔韧加倍', 8.90, 1000, 50, NULL, NULL,
        NULL, NULL, '垃圾袋,清洁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1555000, 64, 109318003, NULL, NULL, '舒眠真丝眼罩',
        'http://localhost:9000/images/category/clothing/85432452d5f40c4798c08f1f0beb4a43.png', '1555000', 0, 1, NULL,
        NULL, 1, NULL, 1000, 79.00, NULL, 0, 0, NULL, '顺滑真丝，感受舒适睡眠', '顺滑真丝，感受舒适睡眠', 79.00, 500,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/clothing/85432452d5f40c4798c08f1f0beb4a43.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, '服饰'),
       (1589017, 0, 109243016, NULL, NULL, '分场景使用不污染，超细纤维抹布分类5件套',
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', 'SN1589017', 0, 1, NULL, NULL, NULL,
        NULL, 800, 14.90, NULL, 0, 0, NULL, '超细纤维抹布分类5件套', '精细分工，洁净家居', 14.90, 1000, 50, NULL, NULL,
        NULL, NULL, '清洁,家居', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (1593000, 64, 109318003, NULL, NULL, '软糯似baby肌肤，男式高领纯小山羊绒衫',
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', '1593000', 0, 1, NULL,
        NULL, 1, NULL, 1000, 559.00, NULL, 0, 0, NULL, '绒毛取自未满1岁的山羊羊羔', '绒毛取自未满1岁的山羊羊羔', 559.00,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, '服饰'),
       (1621018, 69, 109318003, NULL, NULL, '懒人瘦出好身材，多功能甩脂塑形机',
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', '1621018', 0, 1, NULL,
        NULL, 1, NULL, 1000, 589.00, NULL, 0, 0, NULL, '懒人福音居家轻松塑身', '懒人福音居家轻松塑身', 589.00, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, '服饰'),
       (3436033, 62, 109261055, NULL, NULL, '1件装【新疆棉】云珍·轻软旅行长绒棉方巾',
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', 'SN3436033', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 7.90, NULL, 0, 0, NULL, '轻巧无捻小方巾，旅行便携', '轻巧无捻小方巾，旅行便携',
        7.90, 1000, NULL, NULL, 50.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3465081, 66, 109256013, NULL, NULL, '清洁养护一片搞定皮革护理湿巾',
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', 'SN3465081', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 9.90, NULL, 0, 0, NULL, '一擦如新懒人必备', '一擦如新懒人必备', 9.90, 1200, NULL,
        NULL, 100.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3468024, 70, 109243046, NULL, NULL, '意外设计便携钢笔花信礼盒',
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', 'SN3468024', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 398.00, NULL, 0, 0, NULL, '生活的美，诗人的心', '4.16-4.19号停止发货', 398.00, 200,
        NULL, NULL, 1200.00, NULL, '1,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3499024, 70, 109243046, NULL, NULL, '创意金属立体拼酷模型',
        'http://localhost:9000/images/category/electronics/f3784ed01706f2f2722f12410a6429c9.png', 'SN3499024', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 158.00, NULL, 0, 0, NULL, '凤舞龙翔呈现华丽视觉', '凤舞龙翔呈现华丽视觉', 158.00,
        427, NULL, NULL, 800.00, NULL, '1,2', NULL, NULL,
        'http://localhost:9000/images/category/electronics/f3784ed01706f2f2722f12410a6429c9.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3506005, 70, 1043000, NULL, NULL, '意外设计小时光便携钢笔',
        'http://localhost:9000/images/category/electronics/f3636b063dad944aa527e4652392a553.png', 'SN3506005', 0, 1,
        NULL, NULL, NULL, NULL, 100, 328.00, NULL, 0, 0, NULL, '精致与优雅随身藏', '4.16-4.19号停止发货', 328.00, 300,
        NULL, NULL, 150.00, NULL, '1,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/f3636b063dad944aa527e4652392a553.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3529022, 70, 1043000, NULL, NULL, '书源彩色按动中性笔',
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', 'SN3529022', 0, 1,
        NULL, NULL, NULL, NULL, 100, 13.90, NULL, 0, 0, NULL, '化繁为简，书写本源', '化繁为简，书写本源', 13.90, 2000,
        NULL, NULL, 30.00, NULL, '1,2,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3987992, 62, 109261055, NULL, NULL, '【新疆棉】简约山形纹全棉提花毛巾',
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', 'SN3987992', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 18.50, NULL, 0, 0, NULL, '新疆长绒棉毛巾，吸水好颜值高',
        '新疆长绒棉毛巾，吸水好颜值高', 18.50, 1000, NULL, NULL, 200.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3990343, 67, 109275000, NULL, NULL, '【囤货装】日本橙油精华去油污泡沫3瓶装',
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', 'SN3990343', 0,
        1, NULL, NULL, NULL, NULL, 1000, 67.50, NULL, 0, 0, NULL, '强力除油污，萃取橙油精华', '强力除油污，萃取橙油精华',
        67.50, 600, NULL, NULL, 900.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3990408, 67, 109243016, NULL, NULL, '1滴强力去污澳洲超浓缩不伤手洗洁精400ml',
        'http://localhost:9000/images/category/curatedSelection/9ffdc0b1f6dbbe2e9f10a187444c01a3.png', 'SN3990408', 0,
        1, NULL, NULL, NULL, NULL, 1000, 17.90, NULL, 0, 0, NULL, '温和高效去污，一瓶可作多用',
        '温和高效去污，一瓶可作多用', 17.90, 1800, NULL, NULL, 450.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/9ffdc0b1f6dbbe2e9f10a187444c01a3.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3992720, 68, 109243036, NULL, NULL, '旅途手机好伴侣，三合一车载手机支架',
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', 'SN3992720', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 49.00, NULL, 0, 0, NULL, '带安全锤和应急割刀的手机支架',
        '带安全锤和应急割刀的手机支架', 49.00, 1200, NULL, NULL, 150.00, NULL, '1', NULL, NULL,
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3994432, 70, 109243036, NULL, NULL, '平台严选x敦煌博物馆鹿游仙踪植萃车载香氛',
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', 'SN3994432', 0, 1,
        NULL, NULL, NULL, NULL, 1000, 33.90, NULL, 0, 0, NULL, '复古敦煌色系，植萃天然香氛', '安全健康孕婴可用', 33.90,
        800, NULL, NULL, 200.00, NULL, '1,2,3', NULL, NULL,
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3995013, 65, 1011000, NULL, NULL, '时髦出街更亮眼，儿童休闲老爹鞋21-26码',
        'http://localhost:9000/images/category/mother/088c9f9208b82fa4777336d22faa919d.jpg', 'SN3995013', 0, 1, NULL,
        NULL, NULL, NULL, 100, 109.00, NULL, 0, 0, NULL, '高弹鞋底，行走脚感舒适', '高弹鞋底，行走脚感舒适', 109.00, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/088c9f9208b82fa4777336d22faa919d.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (3998109, 62, 109256015, NULL, NULL, '强力去垢不伤锅天然棕榈清洁刷长/短款',
        'http://localhost:9000/images/category/curatedSelection/7537da93f26f0303d94c59f3889836ed.png', 'SN3998109', 0,
        1, NULL, NULL, NULL, NULL, 1000, 8.00, NULL, 0, 0, NULL, '短柄针对顽渍，长柄清洁死角',
        '短柄针对顽渍，长柄清洁死角', 8.00, 2000, NULL, NULL, 50.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/7537da93f26f0303d94c59f3889836ed.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (3998535, 65, 109243022, NULL, NULL, '学步更自如，婴幼童机能学步鞋4-6码',
        'http://localhost:9000/images/category/mother/ef01de6dfac9cc4c548f317f2feddafe.jpg', 'SN3998535', 0, 1, NULL,
        NULL, NULL, NULL, 1000, 109.00, NULL, 0, 0, NULL, '宝宝的第一双鞋，成长不将就', '宝宝的第一双鞋，成长不将就',
        109.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/ef01de6dfac9cc4c548f317f2feddafe.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (3999485, 62, 109275000, NULL, NULL, '意大利大公鸡管家重油污克星清洁剂625ml',
        'http://localhost:9000/images/category/curatedSelection/6a669deef604cd8f080991b3207a3078.png', 'SN3999485', 0,
        1, NULL, NULL, NULL, NULL, 1000, 39.00, NULL, 0, 0, NULL, '强效去污，操作便捷', '强效去污，操作便捷', 39.00, 1200,
        NULL, NULL, 650.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/6a669deef604cd8f080991b3207a3078.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4000009, 66, 109309012, NULL, NULL, '医美级冰脱韩国Ulike蓝宝石脉冲光脱毛仪',
        'http://localhost:9000/images/category/curatedSelection/3567b2ac2526e6b89124f3fb62fd09d3.png', 'SN4000009', 0,
        1, NULL, NULL, NULL, NULL, 1000, 1599.00, NULL, 0, 0, NULL, '蓝宝石冰点脱毛，高效更持久',
        '蓝宝石冰点脱毛，高效更持久', 1599.00, 500, NULL, NULL, 2000.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/3567b2ac2526e6b89124f3fb62fd09d3.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4007784, 65, 109243022, NULL, NULL, '婴幼儿童透气网面学步鞋小童鞋4-6码',
        'http://localhost:9000/images/category/mother/a9f428091f172db89977a511f6639fec.jpg', 'SN4007784', 0, 1, NULL,
        NULL, NULL, NULL, 1000, 119.00, NULL, 0, 0, NULL, '优质透气网布鞋面，轻盈自在', '优质透气网布鞋面，轻盈自在',
        119.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/a9f428091f172db89977a511f6639fec.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4010699, 62, 109243016, NULL, NULL, '除味净化神器Mootaa冰箱抑菌清洁剂250ml',
        'http://localhost:9000/images/category/curatedSelection/838c1b94f15e3b200bea21cef8989592.png', 'SN4010699', 0,
        1, 1, NULL, NULL, NULL, 1000, 35.00, NULL, 0, 0, NULL, '除臭杀毒，持久保鲜', '除臭杀毒，持久保鲜', 35.00, 800,
        NULL, NULL, 300.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/838c1b94f15e3b200bea21cef8989592.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4017718, NULL, 109275000, NULL, NULL, '油污克星Mootaa重油污清洁剂',
        'http://localhost:9000/images/category/curatedSelection/53a1579ead54c61a9b296d20c78a67ff.jpg', 'SN4017718', 0,
        1, NULL, NULL, NULL, NULL, 1000, 26.90, NULL, 0, 0, NULL, '一喷快速溶解油污', '一喷快速溶解油污', 26.90, 1500,
        NULL, NULL, 300.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/53a1579ead54c61a9b296d20c78a67ff.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4023638, 65, 1037006, NULL, NULL, '抓绒保暖，毛毛虫儿童运动鞋26-30',
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 'SN4023638', 0, 1, NULL,
        NULL, NULL, NULL, 100, 109.00, NULL, 0, 0, NULL, '宝贝上脚活力出街', '宝贝上脚活力出街', 109.00, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4023641, 65, 109243022, NULL, NULL, '防踢鞋头，儿童学步健康机能鞋21-30',
        'http://localhost:9000/images/category/mother/33ba674fbb13e2380ee8a74371eacf43.jpg', 'SN4023641', 0, 1, NULL,
        NULL, NULL, NULL, 1000, 129.00, NULL, 0, 0, NULL, '包头防踢用心呵护', '包头防踢用心呵护', 129.00, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/33ba674fbb13e2380ee8a74371eacf43.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4023738, 65, 109243022, NULL, NULL, '舒适软弹，糖果色儿童网孔透气运动鞋25-30',
        'http://localhost:9000/images/category/mother/c437179bc1d0d5ad77a79f15a5c6f166.png', 'SN4023738', 0, 1, NULL,
        NULL, NULL, NULL, 1000, 139.00, NULL, 0, 0, NULL, '防踢鞋头，透气网孔更舒适', '防踢鞋头，透气网孔更舒适', 139.00,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/c437179bc1d0d5ad77a79f15a5c6f166.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4023751, 65, 1011000, NULL, NULL, '释放可爱天性，棉毛布造型领哈衣59-90cm',
        'http://localhost:9000/images/category/mother/5e2b5629af983dadbceed483dd677eeb.jpg', 'SN4023751', 0, 1, 1, NULL,
        NULL, NULL, 100, 62.00, NULL, 0, 0, NULL, 'A类婴幼儿标准，安全放心', 'A类婴幼儿标准，安全放心', 62.00, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/5e2b5629af983dadbceed483dd677eeb.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4023839, 62, 109256015, NULL, NULL, '日本冰块冰球制冰模具',
        'http://localhost:9000/images/category/curatedSelection/2be38fc160992fe41f7d4a45bd0f90e5.png', 'SN4023839', 0,
        1, NULL, NULL, NULL, NULL, 1000, 29.80, NULL, 0, 0, NULL, '轻轻一拍，轻松取冰', '轻轻一拍，轻松取冰', 29.80, 2500,
        NULL, NULL, 150.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/2be38fc160992fe41f7d4a45bd0f90e5.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4027466, 65, 109243022, NULL, NULL, '儿童气泵软底学步二阶段学步鞋',
        'http://localhost:9000/images/category/mother/19bedfd20a12842b5d7f7b909a62e877.jpg', 'SN4027466', 0, 1, NULL,
        NULL, NULL, NULL, 1000, 239.00, NULL, 0, 0, NULL, '气泵大底学步鞋', '气泵大底学步鞋', 239.00, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/19bedfd20a12842b5d7f7b909a62e877.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4027473, 65, 1011000, NULL, NULL, '新款LOGO印花时尚学步叫叫鞋',
        'http://localhost:9000/images/category/mother/841d7669e6cc23cb249f47d8d39fc17c.jpg', 'SN4027473', 0, 1, NULL,
        NULL, NULL, NULL, 100, 259.00, NULL, 0, 0, NULL, '软底包头叫叫鞋', '软底包头叫叫鞋', 259.00, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/mother/841d7669e6cc23cb249f47d8d39fc17c.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4027998, 62, 109275000, NULL, NULL, '亮碟多效合一洗涤块495g',
        'http://localhost:9000/images/category/curatedSelection/e07c2b63765cf9f4a46d489c6e09c1c1.jpg', 'SN4027998', 0,
        1, NULL, NULL, NULL, NULL, 1000, 69.90, NULL, 0, 0, NULL, '洗碗机专用，强力去污', '洗碗机专用，强力去污', 69.90,
        1000, NULL, NULL, 500.00, NULL, NULL, NULL, NULL,
        'http://localhost:9000/images/category/curatedSelection/e07c2b63765cf9f4a46d489c6e09c1c1.jpg', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4027999, NULL, 109243035, NULL, NULL, '飞宇出游拍摄防抖神器手机稳定器',
        'https://yanxuan-item.nosdn.127.net/2d0a47a51fa4b3e3857f2010bd83bead.jpg', '3996603', 0, 1, 0, 0, 1, NULL, 800,
        439.00, NULL, 0, 0, NULL, '小巧便携，三轴防抖，模式随心选', '小巧便携，三轴防抖，模式随心选', NULL, 336, 50, '件',
        NULL, NULL, NULL, NULL, NULL, 'https://yanxuan-item.nosdn.127.net/2d0a47a51fa4b3e3857f2010bd83bead.jpg', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028000, NULL, 109313003, NULL, NULL, '黑科技专利款100%防水保暖针织毛线帽',
        'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', '3995454', 0, 1, 0, 0, 1, NULL, 100,
        135.00, NULL, 0, 0, NULL, '黑科技专利，做到真正的保暖防水', '黑科技专利，做到真正的保暖防水', NULL, 173, 50, '件',
        NULL, NULL, NULL, NULL, NULL, 'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028001, NULL, 109313003, NULL, NULL, '伊海诗冬日出行多功能防风保暖围脖',
        'https://yanxuan-item.nosdn.127.net/25effebb31ea6fc58b92f5a6aecda8b9.png', '3994572', 0, 1, 0, 0, 1, NULL, 100,
        35.00, NULL, 0, 0, NULL, '时尚针织印花面料，多种穿戴方式，正反两穿，亲肤保暖',
        '时尚针织印花面料，多种穿戴方式，正反两穿，亲肤保暖', NULL, 258, 50, '件', NULL, NULL, NULL, NULL, NULL,
        'https://yanxuan-item.nosdn.127.net/25effebb31ea6fc58b92f5a6aecda8b9.png', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL),
       (4028002, NULL, NULL, NULL, NULL, '运动健身跑步腰包',
        'https://yanxuan-item.nosdn.127.net/610a693cfd6f01adc6923dc1c0ec91aa.jpg', '3994179', 0, 1, 0, 0, 1, NULL, 100,
        40.00, NULL, 0, 0, NULL, '防水反光设计，大容量双口袋收纳，运动跑步更时尚',
        '防水反光设计，大容量双口袋收纳，运动跑步更时尚', NULL, 172, 50, '件', NULL, NULL, NULL, NULL, NULL,
        'https://yanxuan-item.nosdn.127.net/610a693cfd6f01adc6923dc1c0ec91aa.jpg', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL),
       (4028003, NULL, 109313003, NULL, NULL, '可触屏户外出行手套-合集',
        'https://yanxuan-item.nosdn.127.net/264df9f0faddb60e88a8b108058d25e6.png', '3993694', 0, 1, 0, 0, 1, NULL, 100,
        69.00, NULL, 0, 0, NULL, '户外轻松骑行', '户外轻松骑行', NULL, 484, 50, '件', NULL, NULL, NULL, NULL, NULL,
        'https://yanxuan-item.nosdn.127.net/264df9f0faddb60e88a8b108058d25e6.png', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL),
       (4028004, NULL, 109313003, NULL, NULL, '户外快干轻巧遮阳帽',
        'https://yanxuan-item.nosdn.127.net/310eac832a1d90fbea41c4e6a9e604e4.png', '3988016', 0, 1, 0, 0, 1, NULL, 800,
        44.00, NULL, 0, 0, NULL, '有效遮阳，可折叠收纳', '有效遮阳，可折叠收纳', NULL, 308, 50, '件', NULL, NULL, NULL,
        NULL, NULL, 'https://yanxuan-item.nosdn.127.net/310eac832a1d90fbea41c4e6a9e604e4.png', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4028005, NULL, 109313003, NULL, NULL, '可折叠户外防紫外线鸭舌帽',
        'https://yanxuan-item.nosdn.127.net/87fbba3cf009e5b69dd14781c594ef79.png', '3987478', 0, 1, 0, 0, 1, NULL, 100,
        44.00, NULL, 0, 0, NULL, '可折叠，透气网纱棒球帽', '可折叠，透气网纱棒球帽', NULL, 485, 50, '件', NULL, NULL,
        NULL, NULL, NULL, 'https://yanxuan-item.nosdn.127.net/87fbba3cf009e5b69dd14781c594ef79.png', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL),
       (4028006, NULL, 109313003, NULL, NULL, '防晒快干长檐棒球帽',
        'https://yanxuan-item.nosdn.127.net/7d0b373a6a63882783202c836bae264d.png', '3550194', 0, 1, 0, 0, 1, NULL, 100,
        69.00, NULL, 0, 0, NULL, '遮阳防晒,保暖新潮', '遮阳防晒,保暖新潮', NULL, 404, 50, '件', NULL, NULL, NULL, NULL,
        NULL, 'https://yanxuan-item.nosdn.127.net/7d0b373a6a63882783202c836bae264d.png', NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL),
       (4028007, NULL, 109313003, NULL, NULL, '探险者黑胶防晒防雨遮阳伞户外钓鱼伞',
        'https://yanxuan-item.nosdn.127.net/66090c5de391e43e4516601e14870842.jpg', '4026116', 0, 1, 0, 0, 1, NULL, 100,
        169.00, NULL, 0, 0, NULL, '防雨遮阳隔绝紫外线', '防雨遮阳隔绝紫外线', NULL, 465, 50, '件', NULL, NULL, NULL,
        NULL, NULL, 'https://yanxuan-item.nosdn.127.net/66090c5de391e43e4516601e14870842.jpg', NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL),
       (4028015, NULL, 109308000, NULL, NULL, '暖腰暖腹暖胃，蕲艾暖宫腰带',
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', 'SN3997602', 0, 1, NULL, 1, 1, NULL,
        800, 49.00, NULL, 0, 0, NULL, '暖宫暖腰暖胃，大面积热敷≈3片暖宝宝', '暖宫暖腰暖胃，大面积热敷≈3片暖宝宝', 49.00,
        1000, 10, '件', 300.00, NULL, '1,2,3', '保健,养生', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL),
       (4028016, NULL, 109308000, NULL, NULL, '真空拔罐器',
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', 'SN3987204', 0, 1, NULL, 1, 1, NULL,
        800, 49.00, NULL, 0, 0, NULL, '居家养生必备超简便拔罐套装', '居家养生必备超简便拔罐套装', 49.00, 800, 10, '套',
        200.00, NULL, '1,2,3', '中医,理疗', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028017, NULL, 109293000, NULL, NULL, '消炎镇痛一贴灵医用冷敷贴60贴/盒',
        'http://localhost:9000/images/category/home/d3807695c7d42a0247e308a936201d7c.jpg', 'SN3991840', 0, 1, 1, 1, 1,
        NULL, 800, 79.00, NULL, 0, 0, NULL, 'mini型尺寸设计性价比更高', 'mini型尺寸设计性价比更高', 79.00, 500, 10,
        '盒', 150.00, NULL, '1,2,3', '医疗,急救', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028019, NULL, 109206007, NULL, NULL, '加量50%不加价，贵州兴仁薏仁米600克',
        'https://yanxuan-item.nosdn.127.net/3e93790bba8db8aab54ee5ba72799567.png', 'SN1135080', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '粒粒饱满，颗颗香糯', '粒粒饱满，颗颗香糯', 19.00, 1500, 10, '袋', 600.00, NULL,
        '1,2,3', '薏仁米,粗粮', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028022, NULL, 109308000, NULL, NULL, '暖腰暖腹暖胃，蕲艾暖宫腰带',
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', '3997602', 1, 1, NULL, 1, 1, NULL,
        100, 49.00, NULL, 0, 0, NULL, '暖宫暖腰暖胃，大面积热敷≈3片暖宝宝', '暖宫暖腰暖胃，大面积热敷≈3片暖宝宝', 49.00,
        100, 10, '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '中医保健'),
       (4028023, NULL, 109308000, NULL, NULL, '真空拔罐器',
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', '3987204', 0, 1, NULL, 1, 1, NULL,
        100, 49.00, NULL, 0, 0, NULL, '居家养生必备超简便拔罐套装', '居家养生必备超简便拔罐套装', 49.00, 100, 10, '件',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '中医保健'),
       (4028024, NULL, 109308000, NULL, NULL, '艾灸理疗随时随地，灸疗装置8头/12头',
        'https://yanxuan-item.nosdn.127.net/941abaee58a88cb104228fe2c4cfdeb1.png', '3986121', 0, 1, NULL, 1, 1, NULL,
        100, 99.00, NULL, 0, 0, NULL, '哪里不适灸哪里，全身都可灸', '哪里不适灸哪里，全身都可灸', 99.00, 100, 10, '件',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '中医保健'),
       (4028025, NULL, 109293000, NULL, NULL, '新年佳礼，家用SPA多功能按摩床垫',
        'http://localhost:9000/images/category/home/c41003c6df90d7673195dcc2482e13f3.jpg', '3995284', 0, 1, NULL, 1, 1,
        NULL, 800, 599.00, NULL, 0, 0, NULL, '坐卧两用，随时随地做spa，多个场合随你心意',
        '坐卧两用，随时随地做spa，多个场合随你心意', 599.00, 100, 10, '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028026, NULL, 109293000, NULL, NULL, '七夕礼物·姐姐同款，穿出自信体态矫姿带',
        'http://localhost:9000/images/category/home/a6939f41c48fa9e9c8f7a7ed855351f1.jpg', '3993828', 0, 1, NULL, 1, 1,
        NULL, 800, 159.00, NULL, 0, 0, NULL, '背薄一寸，年轻十岁，时尚百搭，约会职场小心机',
        '背薄一寸，年轻十岁，时尚百搭，约会职场小心机', 159.00, 100, 10, '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028027, NULL, 109293000, NULL, NULL, '带提手可站立炫彩硅胶热水袋',
        'http://localhost:9000/images/category/home/0b120e1c37f312981f4f2242997cc862.png', '3993481', 0, 1, 1, 1, 1,
        NULL, 800, 35.00, NULL, 0, 0, NULL, '杯型式设计，轻松注水防烫伤', '杯型式设计，轻松注水防烫伤', 35.00, 100, 10,
        '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028028, NULL, 109293000, NULL, NULL, '七夕礼物·挺拔身姿，隐形内穿矫姿带',
        'http://localhost:9000/images/category/home/7d1bc78607a08c088b2a7cdbe88c05af.png', '3992367', 0, 1, NULL, 1, 1,
        NULL, 800, 149.00, NULL, 0, 0, NULL, '众筹爆品回归，专注矫姿20年，轻松矫正身姿',
        '众筹爆品回归，专注矫姿20年，轻松矫正身姿', 149.00, 100, 10, '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028029, NULL, 109293000, NULL, NULL, '消炎镇痛一贴灵医用冷敷贴60贴/盒',
        'http://localhost:9000/images/category/home/d3807695c7d42a0247e308a936201d7c.jpg', '3991840', 0, 1, NULL, 1, 1,
        NULL, 800, 79.00, NULL, 0, 0, NULL, 'mini型尺寸设计性价比更高', 'mini型尺寸设计性价比更高', 79.00, 100, 10,
        '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028030, NULL, 109293000, NULL, NULL, '入门首选，语音播报电子血压计',
        'http://localhost:9000/images/category/home/8f0c15f981c5cbcb1aa17215a259fa62.png', '3997974', 0, 1, NULL, 1, 1,
        NULL, 800, 109.00, NULL, 0, 0, NULL, '全程语音指导，一键测量，监测心率，贴心守护爸妈健康',
        '全程语音指导，一键测量，监测心率，贴心守护爸妈健康', 109.00, 100, 10, '件', NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '家庭医疗'),
       (4028031, NULL, 109206007, NULL, NULL, '黄金玉粟粥米500克',
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', '1270008', 0, 1, NULL, 1, 1, NULL,
        100, 9.90, NULL, 0, 0, NULL, '谷物缤纷，香甜软糯', '谷物缤纷，香甜软糯', 9.90, 100, 10, '袋', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028032, NULL, 109206007, NULL, NULL, '什锦素食粥米500克',
        'https://yanxuan-item.nosdn.127.net/dc4826ddb838d8e17f90402adfa3f4fe.png', '1269010', 0, 1, NULL, 1, 1, NULL,
        100, 9.90, NULL, 0, 0, NULL, '谷香米糯，营养美味', '谷香米糯，营养美味', 9.90, 100, 10, '袋', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028033, NULL, 109206007, NULL, NULL, '紫米410克',
        'https://yanxuan-item.nosdn.127.net/a3c0bb3be38ccf510ecaedb81f5bcd9f.png', '1135081', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '一年一熟的御田胭脂米', '一年一熟的御田胭脂米', 19.00, 100, 10, '袋', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028034, NULL, 109206007, NULL, NULL, '加量50%不加价，贵州兴仁薏仁米600克',
        'https://yanxuan-item.nosdn.127.net/3e93790bba8db8aab54ee5ba72799567.png', '1135080', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '粒粒饱满，颗颗香糯', '粒粒饱满，颗颗香糯', 19.00, 100, 10, '袋', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028035, NULL, 109206007, NULL, NULL, '免浸泡，12种谷物一次同享，五谷米400克',
        'https://yanxuan-item.nosdn.127.net/bfe70bd66efe94f2f18061c707d2a097.png', '1135079', 0, 1, NULL, 1, 1, NULL,
        100, 9.90, NULL, 0, 0, NULL, '无需浸泡，同煮同熟', '无需浸泡，同煮同熟', 9.90, 100, 10, '袋', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028036, NULL, 109206007, NULL, NULL, '加量45%不加价，内蒙古赤峰黄小米700克',
        'https://yanxuan-item.nosdn.127.net/564eb51c22d898179b468f5dec52d502.png', '1135077', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '赤峰好谷，米香浓郁', '赤峰好谷，米香浓郁', 19.00, 100, 10, '袋', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028037, NULL, 109206007, NULL, NULL, '红小豆450克*3袋',
        'https://yanxuan-item.nosdn.127.net/eaec90be370a438e565e10189b7a390a.png', '1135076', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '皮薄易煮，粒粒香甜', '皮薄易煮，粒粒香甜', 19.00, 100, 10, '组', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028038, NULL, 109206007, NULL, NULL, '来自东北的“黑珍珠”，黑米470克*3袋',
        'https://yanxuan-item.nosdn.127.net/1452cfeb14b5d252fb1ba97b278e9cc3.png', '1135075', 0, 1, NULL, 1, 1, NULL,
        100, 19.00, NULL, 0, 0, NULL, '米汁香稠，Q弹醇香', '米汁香稠，Q弹醇香', 19.00, 100, 10, '组', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '米面粮油'),
       (4028039, NULL, 109201001, NULL, NULL, '冻干藤椒豚骨面74克*12盒',
        'https://yanxuan-item.nosdn.127.net/7a5ffe313fe5671709d5a9826f5a83a2.jpg', '3464033', 0, 1, NULL, 1, 1, NULL,
        800, 79.00, NULL, 0, 0, NULL, '日式风味，汤浓肉鲜，椒麻过瘾', '日式风味，汤浓肉鲜，椒麻过瘾', 79.00, 100, 10, '箱',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '方便食品'),
       (4028040, NULL, 109311007, NULL, NULL, '瑜伽裸感女式运动训练紧身裤',
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', '4001126', 0, 1, NULL, 1, 1, NULL,
        100, 83.90, NULL, 0, 0, NULL, '面料韧性足，修身又舒适', '面料韧性足，修身又舒适', 83.90, 100, 10, '条', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '女式运动鞋'),
       (4028041, NULL, 109311007, NULL, NULL, '恍若没穿鞋，女式轻软舒弹健步鞋2.0',
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', '4000914', 0, 1, NULL, 1, 1, NULL,
        100, 159.00, NULL, 0, 0, NULL, '宛若没穿鞋的轻盈，体验更自由的奔跑', '宛若没穿鞋的轻盈，体验更自由的奔跑', 159.00,
        100, 10, '双', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        '女式运动鞋'),
       (4028042, NULL, 109311006, NULL, NULL, '软糯似baby肌肤，男式高领纯小山羊绒衫',
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', '1593000', 0, 1, NULL, 1, 1, NULL,
        100, 559.00, NULL, 0, 0, NULL, '绒毛取自未满1岁的山羊羊羔', '绒毛取自未满1岁的山羊羊羔', 559.00, 100, 10, '件',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '女式休闲鞋'),
       (4028043, NULL, 109303000, NULL, NULL, '「一件三穿好过冬」男中长款鹅绒防水外套',
        'https://yanxuan-item.nosdn.127.net/aa9e03278e3274a2a83f3f8e7df5ee6f.png', '4000620', 0, 1, NULL, 1, 1, NULL,
        800, 659.00, NULL, 0, 0, NULL, '一件衣服三种穿法，应对多变天气', '一件衣服三种穿法，应对多变天气', 659.00, 100,
        10, '件', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '钱包/胸包'),
       (4028044, NULL, NULL, NULL, NULL, '懒人瘦出好身材，多功能甩脂塑形机',
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', '1621018', 0, 1, NULL, 1, 1, NULL,
        100, 589.00, NULL, 0, 0, NULL, '懒人福音居家轻松塑身', '懒人福音居家轻松塑身', 589.00, 100, 10, '台', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028045, NULL, NULL, NULL, NULL, '舒眠真丝眼罩',
        'https://yanxuan-item.nosdn.127.net/85432452d5f40c4798c08f1f0beb4a43.png', '1555000', 0, 1, NULL, 1, 1, NULL,
        100, 79.00, NULL, 0, 0, NULL, '顺滑真丝，感受舒适睡眠', '顺滑真丝，感受舒适睡眠', 79.00, 100, 10, '个', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028046, NULL, NULL, NULL, NULL, '轻灵碳素耐用型羽毛球拍单双拍',
        'https://yanxuan-item.nosdn.127.net/89cc3ab3e332bb1df5dc20241b5ca4bb.png', '1281002', 0, 1, NULL, 1, 1, NULL,
        100, 119.00, NULL, 0, 0, NULL, '超轻球拍，运动随心', '超轻球拍，运动随心', 119.00, 100, 10, '副', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028047, NULL, NULL, NULL, NULL, '英伦长柄自动晴雨伞',
        'https://yanxuan-item.nosdn.127.net/e77b8f4a8ddd1e777394d84347859f7c.png', '4001285', 0, 1, NULL, 1, 1, NULL,
        100, 40.90, NULL, 0, 0, NULL, '雨天有情调，英伦风设计，给你好品味', '雨天有情调，英伦风设计，给你好品味', 40.90,
        100, 10, '把', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
       (4028048, NULL, 19999999, NULL, NULL, '分场景使用不污染，超细纤维抹布分类5件套',
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', '1589017', 0, 1, NULL, 1, 1, NULL,
        100, 14.90, NULL, 0, 0, NULL, '精细分工，洁净家居', '精细分工，洁净家居', 14.90, 100, 10, '套', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028049, NULL, 19999999, NULL, NULL, '添加茂金属更强韧，金属色垃圾袋',
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', '1548001', 0, 1, NULL, 1, 1, NULL,
        100, 8.90, NULL, 0, 0, NULL, '3卷90只，茂金属添加，柔韧加倍', '3卷90只，茂金属添加，柔韧加倍', 8.90, 100, 10, '组',
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028050, NULL, 19999999, NULL, NULL, '随用随丢，懒人真爱地板清洁/除菌湿巾',
        'https://yanxuan-item.nosdn.127.net/4c8a1cf2b8e40c250870491307dde11f.jpg', '1540017', 0, 1, NULL, 1, 1, NULL,
        100, 8.90, NULL, 0, 0, NULL, '材质加厚，耐磨珍珠纹', '材质加厚，耐磨珍珠纹', 8.90, 100, 10, '包', NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028051, NULL, 19999999, NULL, NULL, '灰尘毛发静电吸附地板除尘干巾40片/包',
        'https://yanxuan-item.nosdn.127.net/cf7584e037706a8df54fecfc6dfdd2af.jpg', '1525018', 0, 1, NULL, 1, 1, NULL,
        100, 7.90, NULL, 0, 0, NULL, '干湿两用，静电除尘', '干湿两用，静电除尘', 7.90, 100, 10, '包', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028052, NULL, 19999999, NULL, NULL, '日式和风简约无盖垃圾桶11L',
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', '1306019', 0, 1, NULL, 1, 1, NULL,
        100, 9.90, NULL, 0, 0, NULL, '敞口设计易洗易干触手可得的洁净与精致', '敞口设计易洗易干触手可得的洁净与精致',
        9.90, 100, 10, '个', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        '清洁用品'),
       (4028053, NULL, 19999999, NULL, NULL, '大容量干湿分类，脚踏缓降静音垃圾桶',
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', '1306017', 0, 1, NULL, 1, 1, NULL,
        100, 89.00, NULL, 0, 0, NULL, '一踩开合，解放双手', '一踩开合，解放双手', 89.00, 100, 10, '个', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028054, NULL, 19999999, NULL, NULL, '一抽即提，免脏手，加厚抽绳垃圾袋3卷60只',
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', '1085007', 0, 1, NULL, 1, 1, NULL,
        100, 9.50, NULL, 0, 0, NULL, '18μm及10μm两种厚度，袋身不怕漏，3秒抽绳不脏手',
        '18μm及10μm两种厚度，袋身不怕漏，3秒抽绳不脏手', 9.50, 100, 10, '组', NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028055, NULL, 19999999, NULL, NULL, '软糯治愈系擦手，雪尼尔擦手球',
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', '1076004', 0, 1, NULL, 1, 1, NULL,
        100, 9.50, NULL, 0, 0, NULL, '吸水快干，不易掉屑', '吸水快干，不易掉屑', 9.50, 100, 10, '个', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '清洁用品'),
       (4028056, NULL, NULL, 0, NULL, '经典商品Test', NULL, '', NULL, 0, 0, 0, 0, NULL, NULL, 0.00, NULL, 0, 0, NULL,
        '经典商品Test', '', 0.00, 0, NULL, '', 0.00, 0, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL);
/*!40000 ALTER TABLE `pms_product`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_attribute`
--

DROP TABLE IF EXISTS `pms_product_attribute`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_attribute`
(
    `id`                            int NOT NULL AUTO_INCREMENT,
    `product_attribute_category_id` int                                                          DEFAULT NULL COMMENT '商品属性分类id',
    `name`                          varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
    `select_type`                   int                                                          DEFAULT NULL COMMENT '属性选择类型：0->唯一；1->单选；2->多选',
    `input_type`                    int                                                          DEFAULT NULL COMMENT '属性录入方式：0->手工录入；1->从列表中选取',
    `input_list`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '可选值列表，以逗号隔开',
    `sort`                          int                                                          DEFAULT NULL COMMENT '排序字段：最高的可以单独上传图片',
    `filter_type`                   int                                                          DEFAULT NULL COMMENT '分类筛选样式：1->普通；1->颜色',
    `search_type`                   int                                                          DEFAULT NULL COMMENT '检索类型；0->不需要进行检索；1->关键字检索；2->范围检索',
    `related_status`                int                                                          DEFAULT NULL COMMENT '相同属性产品是否关联；0->不关联；1->关联',
    `hand_add_status`               int                                                          DEFAULT NULL COMMENT '是否支持手动新增；0->不支持；1->支持',
    `type`                          int                                                          DEFAULT NULL COMMENT '属性的类型；0->规格；1->参数',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 63
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='商品属性参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_attribute`
--

LOCK TABLES `pms_product_attribute` WRITE;
/*!40000 ALTER TABLE `pms_product_attribute`
    DISABLE KEYS */;
INSERT INTO `pms_product_attribute`
VALUES (13, 0, '上市年份', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1),
       (24, 1, '商品编号', 1, 0, '', 0, 0, 0, 0, 0, 1),
       (25, 1, '适用季节', 1, 1, '春季,夏季,秋季,冬季', 0, 0, 0, 0, 0, 1),
       (32, 2, '适用人群', 0, 1, '老年,青年,中年', 0, 0, 0, 0, 0, 1),
       (37, 1, '适用人群', 1, 1, '儿童,青年,中年,老年', 0, 0, 0, 0, 0, 1),
       (38, 1, '上市时间', 1, 1, '2017年秋,2017年冬,2018年春,2018年夏', 0, 0, 0, 0, 0, 1),
       (39, 1, '袖长', 1, 1, '短袖,长袖,中袖', 0, 0, 0, 0, 0, 1),
       (40, 2, '尺码', 0, 1, '29,30,31,32,33,34', 0, 0, 0, 0, 0, 0),
       (41, 2, '适用场景', 0, 1, '居家,运动,正装', 0, 0, 0, 0, 0, 1),
       (42, 2, '上市时间', 0, 1, '2018年春,2018年夏', 0, 0, 0, 0, 0, 1),
       (45, 3, '屏幕尺寸', 0, 0, '', 0, 0, 0, 0, 0, 1),
       (46, 3, '网络', 0, 1, '3G,4G', 0, 0, 0, 0, 0, 1),
       (47, 3, '系统', 0, 1, 'Android,IOS', 0, 0, 0, 0, 0, 1),
       (48, 3, '电池容量', 0, 0, '', 0, 0, 0, 0, 0, 1),
       (52, 12, '品种', 0, 1, '水蜜桃,黄桃,蟠桃,油桃,山东富士,新疆阿克苏,莱阳梨,丰水梨,', 0, 0, 1, 0, 1, 0),
       (53, 12, '国产/进口', 1, 1, '国产,进口', 0, 0, 0, 0, 1, 0),
       (54, 4, '商品产地', 1, 1, '国产,进口', 0, 0, 0, 0, 0, 0),
       (55, 4, '插口数', 1, 1, '单口,多口', 0, 0, 0, 0, 0, 1),
       (56, 5, '表面工艺', 1, 1, '浸塑', 0, 0, 0, 0, 0, 0),
       (59, 1, '颜色', 1, 1, '黑色,蓝色,金色,银色,红色,灰色,粉色,白色,藏青,曜金黑,冰霜银,樱花粉,薄荷绿,珊瑚粉,星空蓝',
        NULL, NULL, NULL, NULL, NULL, 0),
       (60, 1, '容量', 1, 1, '32G,64G,128G,256G,512G,1TB', NULL, NULL, NULL, NULL, NULL, 0),
       (61, 2, '尺寸', 1, 1, 'M,L,XL,XXL,38,39,40,41,42,36,37', NULL, NULL, NULL, NULL, NULL, 0),
       (62, 3, '风格', 1, 1, '秋季,夏季', NULL, NULL, NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `pms_product_attribute`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_attribute_category`
--

DROP TABLE IF EXISTS `pms_product_attribute_category`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_attribute_category`
(
    `id`              int NOT NULL AUTO_INCREMENT,
    `name`            varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '属性分类名称',
    `attribute_count` int                                                          DEFAULT '0' COMMENT '属性数量',
    `param_count`     int                                                          DEFAULT '0' COMMENT '参数数量',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 21
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品属性分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_attribute_category`
--

LOCK TABLES `pms_product_attribute_category` WRITE;
/*!40000 ALTER TABLE `pms_product_attribute_category`
    DISABLE KEYS */;
INSERT INTO `pms_product_attribute_category`
VALUES (1, '服装-T恤', 2, 5),
       (2, '服装-裤装', 2, 4),
       (4, '配件', 1, 1),
       (5, '居家', 1, 0),
       (6, '洗护', 0, 0),
       (11, '服装-鞋帽', 3, 0),
       (12, '生鲜水果', 0, 0),
       (15, '短袖', 0, 0),
       (18, '手机属性', 3, 0),
       (19, '服饰属性', 2, 0),
       (20, '鞋靴属性', 2, 0);
/*!40000 ALTER TABLE `pms_product_attribute_category`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_attribute_value`
--

DROP TABLE IF EXISTS `pms_product_attribute_value`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_attribute_value`
(
    `id`                   int NOT NULL AUTO_INCREMENT,
    `product_id`           int                                                          DEFAULT NULL COMMENT '商品id',
    `product_attribute_id` int                                                          DEFAULT NULL COMMENT '商品属性id',
    `value`                varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 245
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='存储产品参数信息的表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_attribute_value`
--

LOCK TABLES `pms_product_attribute_value` WRITE;
/*!40000 ALTER TABLE `pms_product_attribute_value`
    DISABLE KEYS */;
INSERT INTO `pms_product_attribute_value`
VALUES (1, 9, 1, 'X'),
       (2, 10, 1, 'X'),
       (3, 11, 1, 'X'),
       (4, 12, 1, 'X'),
       (5, 13, 1, 'X'),
       (6, 14, 1, 'X'),
       (7, 18, 1, 'X'),
       (8, 7, 1, 'X'),
       (9, 7, 1, 'XL'),
       (10, 7, 1, 'XXL'),
       (11, 22, 7, 'x,xx'),
       (12, 22, 24, 'no110'),
       (13, 22, 25, '春季'),
       (14, 22, 37, '青年'),
       (15, 22, 38, '2018年春'),
       (16, 22, 39, '长袖'),
       (124, 23, 7, '米白色,浅黄色'),
       (125, 23, 24, 'no1098'),
       (126, 23, 25, '春季'),
       (127, 23, 37, '青年'),
       (128, 23, 38, '2018年春'),
       (129, 23, 39, '长袖'),
       (130, 1, 13, NULL),
       (131, 1, 14, NULL),
       (132, 1, 15, NULL),
       (133, 1, 16, NULL),
       (134, 1, 17, NULL),
       (135, 1, 18, NULL),
       (136, 1, 19, NULL),
       (137, 1, 20, NULL),
       (138, 1, 21, NULL),
       (139, 2, 13, NULL),
       (140, 2, 14, NULL),
       (141, 2, 15, NULL),
       (142, 2, 16, NULL),
       (143, 2, 17, NULL),
       (144, 2, 18, NULL),
       (145, 2, 19, NULL),
       (146, 2, 20, NULL),
       (147, 2, 21, NULL),
       (183, 31, 24, NULL),
       (184, 31, 25, '夏季'),
       (185, 31, 37, '青年'),
       (186, 31, 38, '2018年夏'),
       (187, 31, 39, '短袖'),
       (198, 30, 24, NULL),
       (199, 30, 25, '夏季'),
       (200, 30, 37, '青年'),
       (201, 30, 38, '2018年夏'),
       (202, 30, 39, '短袖'),
       (213, 27, 43, '黑色,蓝色'),
       (214, 27, 45, '5.8'),
       (215, 27, 46, '4G'),
       (216, 27, 47, 'Android'),
       (217, 27, 48, '3000ml'),
       (218, 28, 43, '金色,银色'),
       (219, 28, 45, '5.0'),
       (220, 28, 46, '4G'),
       (221, 28, 47, 'Android'),
       (222, 28, 48, '2800ml'),
       (223, 29, 43, '金色,银色'),
       (224, 29, 45, '4.7'),
       (225, 29, 46, '4G'),
       (226, 29, 47, 'IOS'),
       (227, 29, 48, '1960ml'),
       (228, 26, 43, '金色,银色'),
       (229, 26, 45, '5.0'),
       (230, 26, 46, '4G'),
       (231, 26, 47, 'Android'),
       (232, 26, 48, '3000'),
       (233, 39, 43, '白色'),
       (234, 39, 45, '6.36英寸'),
       (235, 39, 46, '4G'),
       (236, 39, 47, 'Android'),
       (237, 39, 48, '4500'),
       (238, 55, 57, '暖宫腰带3片/盒'),
       (239, 3996603, 1, '黑色'),
       (240, 3995454, 1, '藏青色'),
       (241, 3995454, 3, '冬季'),
       (242, 3994572, 1, '卡其色'),
       (243, 3994572, 3, '秋季,冬季'),
       (244, 4026116, 2, '直径1.2米');
/*!40000 ALTER TABLE `pms_product_attribute_value`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_category`
--

DROP TABLE IF EXISTS `pms_product_category`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_category`
(
    `id`            int NOT NULL AUTO_INCREMENT,
    `parent_id`     int                                                          DEFAULT NULL COMMENT '上级分类的编号：0表示一级分类',
    `name`          varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
    `level`         int                                                          DEFAULT NULL COMMENT '分类级别：0->1级；1->2级',
    `product_count` int                                                          DEFAULT NULL COMMENT '这个类别的商品数量',
    `product_unit`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品计数单位',
    `nav_status`    int                                                          DEFAULT NULL COMMENT '是否显示在导航栏：0->不显示；1->显示',
    `show_status`   int                                                          DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
    `sort`          int                                                          DEFAULT NULL COMMENT '排序',
    `icon`          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '图标',
    `keywords`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '关键词',
    `description`   text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `picture`       varchar(500) COLLATE utf8mb4_general_ci                      DEFAULT NULL COMMENT '图片链接',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1005999007
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_category`
--

LOCK TABLES `pms_product_category` WRITE;
/*!40000 ALTER TABLE `pms_product_category`
    DISABLE KEYS */;
INSERT INTO `pms_product_category`
VALUES (52, 99, '食品生鲜', 0, NULL, '份', 1, 1, 0,
        'http://localhost:9000/images/icon/a1a9262cac294fdf8a3082142e67c909.jpg', '食品、生鲜', '蔬菜、水果、肉、蛋',
        'http://localhost:9000/images/icon/a1a9262cac294fdf8a3082142e67c909.jpg'),
       (53, 52, '新鲜水果', 1, NULL, '箱', 1, 1, 0,
        'http://localhost:9000/images/icon/b8ea3bd5331c4ee0a4086f59c2934a35.jpg', '水果', '水果',
        'http://localhost:9000/images/icon/b8ea3bd5331c4ee0a4086f59c2934a35.jpg'),
       (54, 52, '蔬菜蛋品', 1, NULL, '件', 1, 1, 0,
        'http://localhost:9000/images/icon/cb96b650060049659e0c61b5d693837f.jpg', '蔬菜、鸡蛋等', '蔬菜蛋品',
        'http://localhost:9000/images/icon/cb96b650060049659e0c61b5d693837f.jpg'),
       (1005000, 0, '居家', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/2021-05-06/201516e3-25d0-48f5-bcee-7f0cafb14176.png', NULL, NULL,
        'http://localhost:9000/images/icon/2021-05-06/201516e3-25d0-48f5-bcee-7f0cafb14176.png'),
       (1005002, 0, '美食', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/cf82e5b4-bf1b-4c68-aa86-96f66e8e5282.png', NULL, NULL,
        'http://localhost:9000/images/icon/cf82e5b4-bf1b-4c68-aa86-96f66e8e5282.png'),
       (1005012, 1005002, '南北干货', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/9af51a1090fd32f668b14451f06d6e72.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/9af51a1090fd32f668b14451f06d6e72.png?quality=95&imageView'),
       (1008006, 1043000, '影音娱乐', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/f5797ca77cfe413e7753ec69f9bd4bb1.png', NULL, NULL,
        'http://localhost:9000/images/icon/f5797ca77cfe413e7753ec69f9bd4bb1.png'),
       (1008017, 1005000, '收纳', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/366989e4d730594e86fcd60b5ab19acc.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/366989e4d730594e86fcd60b5ab19acc.png?quality=95&imageView'),
       (1009000, 1013001, '家庭清洁', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/718318c0d3b55d011fcb7c7c843902ce.png', NULL, NULL,
        'http://localhost:9000/images/icon/718318c0d3b55d011fcb7c7c843902ce.png'),
       (1010000, 0, '服饰', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/33e1f5de-0fdb-4cfa-9ba9-781233024b53.png', NULL, NULL,
        'http://localhost:9000/images/icon/33e1f5de-0fdb-4cfa-9ba9-781233024b53.png'),
       (1011000, 0, '母婴', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/b514a526-4010-4ce8-8cb9-757ed382f84a.png', NULL, NULL,
        'http://localhost:9000/images/icon/b514a526-4010-4ce8-8cb9-757ed382f84a.png'),
       (1013001, 0, '个护', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/d38a73b8-cd03-48aa-a60b-e7c4e16667ed.png', NULL, NULL,
        'http://localhost:9000/images/icon/d38a73b8-cd03-48aa-a60b-e7c4e16667ed.png'),
       (1017000, 1005000, '宠物食品', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/b42a85ef15f856081ea9f49e5f6893e2.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/b42a85ef15f856081ea9f49e5f6893e2.png?quality=95&imageView'),
       (1019000, 0, '严选', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/4b02f01f-a365-4b6c-9f7a-8b0f591dda02.png', NULL, NULL,
        'http://localhost:9000/images/icon/4b02f01f-a365-4b6c-9f7a-8b0f591dda02.png'),
       (1020002, 1013001, '浴室用品', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/dfb6142de1bd2f59b251eb8f7c7ea2fb.png', NULL, NULL,
        'http://localhost:9000/images/icon/dfb6142de1bd2f59b251eb8f7c7ea2fb.png'),
       (1020003, 1011000, 'T恤/polo/衬衫', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/1f0089afcec911db7202fbcdae57d5f8.png', NULL, NULL,
        'http://localhost:9000/images/icon/1f0089afcec911db7202fbcdae57d5f8.png'),
       (1022000, 1043000, '3C数码', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/99b8f97b2e5449606fd558574aa15982.png', NULL, NULL,
        'http://localhost:9000/images/icon/99b8f97b2e5449606fd558574aa15982.png'),
       (1028001, 1043000, '乐器', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/da0ac345e98c04594b697b56ebc373a5.png', NULL, NULL,
        'http://localhost:9000/images/icon/da0ac345e98c04594b697b56ebc373a5.png'),
       (1036003, 1005002, '调味酱菜', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/5fae33a840870b487cc903535383bf97.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/5fae33a840870b487cc903535383bf97.png?quality=95&imageView'),
       (1037006, 1011000, '儿童鞋', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/7fd14a409302391da16970981cacd336.png', NULL, NULL,
        'http://localhost:9000/images/icon/7fd14a409302391da16970981cacd336.png'),
       (1043000, 0, '数码', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/9660870d-6a59-4624-8064-b3a8cbf50d5c.png', NULL, NULL,
        'http://localhost:9000/images/icon/9660870d-6a59-4624-8064-b3a8cbf50d5c.png'),
       (1065004, 1019000, '滋补保健', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/1e619a2b22f40bf83070e6f8f6e0c8ff.png', NULL, NULL,
        'http://localhost:9000/images/icon/1e619a2b22f40bf83070e6f8f6e0c8ff.png'),
       (19999999, 0, '杂项', 0, 8, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/4ff20b9e-8150-4bd3-87a3-0cd6766938dd.png', NULL, NULL,
        'http://localhost:9000/images/icon/4ff20b9e-8150-4bd3-87a3-0cd6766938dd.png'),
       (109201001, 1005002, '方便食品', 1, 0, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/f9872b4aad6c0a943d45629ac96ee8d3.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/f9872b4aad6c0a943d45629ac96ee8d3.png?quality=95&imageView'),
       (109206007, 1005002, '米面粮油', 1, 0, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/8578759aed2268f7aa8641273cac7cb3.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/8578759aed2268f7aa8641273cac7cb3.png?quality=95&imageView'),
       (109243003, 1005000, '艺术藏品', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/9544b81aaa14c26a8038c2365ff3c2bc.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/9544b81aaa14c26a8038c2365ff3c2bc.png?quality=95&imageView'),
       (109243016, 1013001, '餐厨清洁', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/55d927e337c1f6d394359e99ef72a621.png', NULL, NULL,
        'http://localhost:9000/images/icon/55d927e337c1f6d394359e99ef72a621.png'),
       (109243018, 1011000, '外套/套装', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/773a8777f66c286f97af6d74a27d7fe1.png', NULL, NULL,
        'http://localhost:9000/images/icon/773a8777f66c286f97af6d74a27d7fe1.png'),
       (109243019, 1011000, '裤子/裙装', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/a8c52cea5f953019484a74883ad8f14b.png', NULL, NULL,
        'http://localhost:9000/images/icon/a8c52cea5f953019484a74883ad8f14b.png'),
       (109243021, 1011000, '连体衣/礼盒', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/773677cc0922628152a9b3cbd862426f.png', NULL, NULL,
        'http://localhost:9000/images/icon/773677cc0922628152a9b3cbd862426f.png'),
       (109243022, 1011000, '学步鞋', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/9a50280bb69e1c12f557f601cce1c480.png', NULL, NULL,
        'http://localhost:9000/images/icon/9a50280bb69e1c12f557f601cce1c480.png'),
       (109243029, 0, '运动', 0, 9, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/7d19752c-baff-49b6-bd02-5ece1d729214.png', NULL, NULL,
        'http://localhost:9000/images/icon/7d19752c-baff-49b6-bd02-5ece1d729214.png'),
       (109243035, 1043000, '手机配件', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/0276d68f4b7a03bbd16675ada6e707ff.png', NULL, NULL,
        'http://localhost:9000/images/icon/0276d68f4b7a03bbd16675ada6e707ff.png'),
       (109243036, 1043000, '车载用品', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/3f45fbcdac7e8532b6a1570e6d7fe171.png', NULL, NULL,
        'http://localhost:9000/images/icon/3f45fbcdac7e8532b6a1570e6d7fe171.png'),
       (109243046, 1043000, '办公文具', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/801583d2f58274b13dc6a03daed1c3c9.png', NULL, NULL,
        'http://localhost:9000/images/icon/801583d2f58274b13dc6a03daed1c3c9.png'),
       (109248004, 1005000, '宠物用品', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/e766b09029ca00680d1e651b5cdc42bd.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/e766b09029ca00680d1e651b5cdc42bd.png?quality=95&imageView'),
       (109256012, 1013001, '纸品', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/07fef43b0d14882d6662233ab30dc588.png', NULL, NULL,
        'http://localhost:9000/images/icon/07fef43b0d14882d6662233ab30dc588.png'),
       (109256013, 1013001, '干湿巾', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/985897ea31fdfc159e12696f4dbb4c13.png', NULL, NULL,
        'http://localhost:9000/images/icon/985897ea31fdfc159e12696f4dbb4c13.png'),
       (109256014, 1019000, '床品家纺', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/e6580910c1f98ed61bda867aeaf07929.png', NULL, NULL,
        'http://localhost:9000/images/icon/e6580910c1f98ed61bda867aeaf07929.png'),
       (109256015, 1019000, '锅具配件', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/50ccbf04857e86cccf44d25da0577deb.png', NULL, NULL,
        'http://localhost:9000/images/icon/50ccbf04857e86cccf44d25da0577deb.png'),
       (109261055, 1013001, '毛巾浴巾', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/949c5f8b077cf386ff9f1f18bec3408b.png', NULL, NULL,
        'http://localhost:9000/images/icon/949c5f8b077cf386ff9f1f18bec3408b.png'),
       (109264007, 1005002, '名酒馆', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/91413b1476a0697bb0592609a42d4498.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/91413b1476a0697bb0592609a42d4498.png?quality=95&imageView'),
       (109275000, 1019000, '清洁用品', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/926d919bc3e95f5c93dc5dc973faa378.png', NULL, NULL,
        'http://localhost:9000/images/icon/926d919bc3e95f5c93dc5dc973faa378.png'),
       (109285003, 1005002, '进口酒', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/bf705060f01b60fe9c11c345931b1891.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/bf705060f01b60fe9c11c345931b1891.png?quality=95&imageView'),
       (109293000, 1005000, '家庭医疗', 1, 0, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/3f34039fa8c26e18e2f4fc96ed8cb6de.png', NULL, NULL,
        'http://localhost:9000/images/icon/3f34039fa8c26e18e2f4fc96ed8cb6de.png?quality=95&imageView'),
       (109303000, 1010000, '钱包/胸包', 2, NULL, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/237613bc9c22eb422dade63e3ed7c61a.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/237613bc9c22eb422dade63e3ed7c61a.png?quality=95&imageView'),
       (109308000, 1005000, '中医保健', 1, 0, '件', 1, 1, NULL,
        'http://localhost:9000/images/icon/2bfba997fd031317caecc4f0bad17569.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/2bfba997fd031317caecc4f0bad17569.png?quality=95&imageView'),
       (109309012, 1019000, '个护电器', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/7a0eea3c515ad247c092749bcdd29855.png', NULL, NULL,
        'http://localhost:9000/images/icon/7a0eea3c515ad247c092749bcdd29855.png'),
       (109311005, 1010000, '女式靴子', 2, NULL, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/62c5dacf3e0cbe8e4188ccd263358d1a.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/62c5dacf3e0cbe8e4188ccd263358d1a.png?quality=95&imageView'),
       (109311006, 1010000, '女式休闲鞋', 2, NULL, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/8cd3a76ffffb14e9fe92ad2369117af0.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/8cd3a76ffffb14e9fe92ad2369117af0.png?quality=95&imageView'),
       (109311007, 1010000, '女式运动鞋', 2, NULL, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/7be561f2ddc2179a7e116c413636eba9.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/7be561f2ddc2179a7e116c413636eba9.png?quality=95&imageView'),
       (109312000, 109243029, '健身大器械', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/6a1d37ffb2e28622a71e3c4415eaee35.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/6a1d37ffb2e28622a71e3c4415eaee35.png?quality=95&imageView'),
       (109312001, 109243029, '健身小器械', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/8c9f060e6fddb2b75af851a9a2c60087.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/8c9f060e6fddb2b75af851a9a2c60087.png?quality=95&imageView'),
       (109312002, 109243029, '城市出行', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/b41b50710c3823f44a9f5b549a67ca81.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/b41b50710c3823f44a9f5b549a67ca81.png?quality=95&imageView'),
       (109312003, 109243029, '运动护具', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/ef9bcb99d88b3a1cfd9d2e120c158c21.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/ef9bcb99d88b3a1cfd9d2e120c158c21.png?quality=95&imageView'),
       (109313000, 109243029, '垂钓', 1, 0, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/c4eeeae307d0562cf3e95303146282b2.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/c4eeeae307d0562cf3e95303146282b2.png?quality=95&imageView'),
       (109313003, 109243029, '户外装备', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/6bbd92c68741c857d842f0afd1c7bdd5.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/6bbd92c68741c857d842f0afd1c7bdd5.png?quality=95&imageView'),
       (109315000, 1010000, '11.11购物狂欢', 2, NULL, NULL, NULL, 0, NULL,
        'http://localhost:9000/images/icon/b29297263032957553d7153b309db74b.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/b29297263032957553d7153b309db74b.png?quality=95&imageView'),
       (109318003, 1010000, '【年末狂欢季】', 2, NULL, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/8f8092d5bf6a133a8cb59ab7b9f790e9.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/8f8092d5bf6a133a8cb59ab7b9f790e9.png?quality=95&imageView'),
       (1005999003, 1005000, '居家生活用品', 1, 0, '件', 1, 0, NULL,
        'http://localhost:9000/images/icon/7f6a7b20-7902-4b43-b9c5-f33151ef1334.jpg?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/7f6a7b20-7902-4b43-b9c5-f33151ef1334.jpg?quality=95&imageView'),
       (1005999005, 1005999004, '中医保健', 1, NULL, '件', 1, 1, 2,
        'http://localhost:9000/images/icon/3bd73b7279a83d1cbb50c0e45778e6d6.png', NULL, NULL,
        'http://localhost:9000/images/icon/3bd73b7279a83d1cbb50c0e45778e6d6.png'),
       (1005999006, 19999999, '家庭清洁杂项', 1, 0, NULL, NULL, 1, NULL,
        'http://localhost:9000/images/icon/718318c0d3b55d011fcb7c7c843902ce.png?quality=95&imageView', NULL, NULL,
        'http://localhost:9000/images/icon/718318c0d3b55d011fcb7c7c843902ce.png?quality=95&imageView');
/*!40000 ALTER TABLE `pms_product_category`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_category_attribute_relation`
--

DROP TABLE IF EXISTS `pms_product_category_attribute_relation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_category_attribute_relation`
(
    `id`                   int NOT NULL AUTO_INCREMENT,
    `product_category_id`  int DEFAULT NULL COMMENT '商品类别id',
    `product_attribute_id` int DEFAULT NULL COMMENT '商品属性id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 14
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_category_attribute_relation`
--

LOCK TABLES `pms_product_category_attribute_relation` WRITE;
/*!40000 ALTER TABLE `pms_product_category_attribute_relation`
    DISABLE KEYS */;
INSERT INTO `pms_product_category_attribute_relation`
VALUES (1, 24, 24),
       (5, 26, 24),
       (7, 28, 24),
       (9, 25, 24),
       (10, 25, 25),
       (11, 109243029, 1),
       (12, 109243029, 2),
       (13, 109243029, 3);
/*!40000 ALTER TABLE `pms_product_category_attribute_relation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_full_reduction`
--

DROP TABLE IF EXISTS `pms_product_full_reduction`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_full_reduction`
(
    `id`           bigint NOT NULL AUTO_INCREMENT,
    `product_id`   int            DEFAULT NULL COMMENT '商品id',
    `full_price`   decimal(10, 2) DEFAULT NULL COMMENT '满多少元，例如：满399',
    `reduce_price` decimal(10, 2) DEFAULT NULL COMMENT '减多少元，例如：减20',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 81
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品满减表(只针对同商品)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_full_reduction`
--

LOCK TABLES `pms_product_full_reduction` WRITE;
/*!40000 ALTER TABLE `pms_product_full_reduction`
    DISABLE KEYS */;
INSERT INTO `pms_product_full_reduction`
VALUES (1, 7, 100.00, 20.00),
       (2, 8, 100.00, 20.00),
       (3, 9, 100.00, 20.00),
       (4, 10, 100.00, 20.00),
       (5, 11, 100.00, 20.00),
       (6, 12, 100.00, 20.00),
       (7, 13, 100.00, 20.00),
       (8, 14, 100.00, 20.00),
       (9, 18, 100.00, 20.00),
       (10, 7, 200.00, 50.00),
       (11, 7, 300.00, 100.00),
       (14, 22, 0.00, 0.00),
       (16, 24, 0.00, 0.00),
       (34, 23, 0.00, 0.00),
       (44, 31, 0.00, 0.00),
       (46, 32, 0.00, 0.00),
       (48, 33, 0.00, 0.00),
       (55, 34, 0.00, 0.00),
       (56, 30, 0.00, 0.00),
       (59, 27, 0.00, 0.00),
       (60, 28, 500.00, 50.00),
       (61, 28, 1000.00, 120.00),
       (62, 29, 0.00, 0.00),
       (63, 26, 0.00, 0.00),
       (78, 36, 0.00, 0.00),
       (79, 35, 0.00, 0.00),
       (80, 39, 0.00, 0.00);
/*!40000 ALTER TABLE `pms_product_full_reduction`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_product_ladder`
--

DROP TABLE IF EXISTS `pms_product_ladder`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_product_ladder`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `product_id` int            DEFAULT NULL COMMENT '商品id',
    `count`      int            DEFAULT NULL COMMENT '满足的商品数量',
    `discount`   decimal(10, 2) DEFAULT NULL COMMENT '折扣',
    `price`      decimal(10, 2) DEFAULT NULL COMMENT '折后价格',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 86
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='产品阶梯价格表(只针对同商品)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_product_ladder`
--

LOCK TABLES `pms_product_ladder` WRITE;
/*!40000 ALTER TABLE `pms_product_ladder`
    DISABLE KEYS */;
INSERT INTO `pms_product_ladder`
VALUES (1, 7, 3, 0.70, 0.00),
       (2, 8, 3, 0.70, 0.00),
       (3, 9, 3, 0.70, 0.00),
       (4, 10, 3, 0.70, 0.00),
       (5, 11, 3, 0.70, 0.00),
       (6, 12, 3, 0.70, 0.00),
       (7, 13, 3, 0.70, 0.00),
       (8, 14, 3, 0.70, 0.00),
       (12, 18, 3, 0.70, 0.00),
       (14, 7, 4, 0.60, 0.00),
       (15, 7, 5, 0.50, 0.00),
       (18, 22, 0, 0.00, 0.00),
       (20, 24, 0, 0.00, 0.00),
       (38, 23, 0, 0.00, 0.00),
       (48, 31, 0, 0.00, 0.00),
       (50, 32, 0, 0.00, 0.00),
       (52, 33, 0, 0.00, 0.00),
       (59, 34, 0, 0.00, 0.00),
       (60, 30, 0, 0.00, 0.00),
       (64, 27, 2, 0.80, 0.00),
       (65, 27, 3, 0.75, 0.00),
       (66, 28, 0, 0.00, 0.00),
       (67, 29, 0, 0.00, 0.00),
       (68, 26, 0, 0.00, 0.00),
       (83, 36, 0, 0.00, 0.00),
       (84, 35, 0, 0.00, 0.00),
       (85, 39, 0, 0.00, 0.00);
/*!40000 ALTER TABLE `pms_product_ladder`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pms_sku_stock`
--

DROP TABLE IF EXISTS `pms_sku_stock`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pms_sku_stock`
(
    `id`              int                                                          NOT NULL AUTO_INCREMENT,
    `product_id`      int            DEFAULT NULL COMMENT '商品id',
    `sku_code`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sku编码',
    `price`           decimal(10, 2) DEFAULT NULL COMMENT '价格',
    `stock`           int            DEFAULT '0' COMMENT '库存',
    `low_stock`       int            DEFAULT NULL COMMENT '预警库存',
    `pic`             text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '展示图片',
    `sale`            int            DEFAULT NULL COMMENT '销量',
    `promotion_price` decimal(10, 2) DEFAULT NULL COMMENT '单品促销价格',
    `lock_stock`      int            DEFAULT '0' COMMENT '锁定库存',
    `sp_data`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品销售属性，json格式',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 504
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='sku的库存';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pms_sku_stock`
--

LOCK TABLES `pms_sku_stock` WRITE;
/*!40000 ALTER TABLE `pms_sku_stock`
    DISABLE KEYS */;
INSERT INTO `pms_sku_stock`
VALUES (180, 3997602, 'HOME_3997602', 49.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', NULL, NULL, 0,
        '{\"颜色\":\"默认\"}'),
       (181, 3995284, 'HOME_3995284', 599.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/c41003c6df90d7673195dcc2482e13f3.jpg', NULL, NULL, 0,
        '{\"颜色\":\"默认\"}'),
       (182, 3993828, 'HOME_3993828', 159.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/a6939f41c48fa9e9c8f7a7ed855351f1.jpg', NULL, NULL, 0,
        '{\"颜色\":\"默认\"}'),
       (183, 1270008, 'FOOD_1270008', 9.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"规格\":\"500g\"}'),
       (184, 1269010, 'FOOD_1269010', 9.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/dc4826ddb838d8e17f90402adfa3f4fe.png', NULL, NULL, 0,
        '{\"规格\":\"500g\"}'),
       (185, 1621018, 'CLOTH_1621018', 589.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, 0,
        '{\"尺寸\":\"均码\",\"颜色\":\"黑色\"}'),
       (186, 1593000, 'CLOTH_1593000', 559.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"尺寸\":\"L\",\"颜色\":\"灰色\"}'),
       (187, 4027473, 'BABY_4027473', 259.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/841d7669e6cc23cb249f47d8d39fc17c.jpg', NULL, NULL, 0,
        '{\"鞋码\":\"21码\"}'),
       (188, 4027466, 'BABY_4027466', 239.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/19bedfd20a12842b5d7f7b909a62e877.jpg', NULL, NULL, 0,
        '{\"鞋码\":\"22码\"}'),
       (189, 3987992, 'CARE_3987992', 18.50, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/e0cea368f41da1587b3b7fc523f169d7.png', NULL, NULL, 0,
        '{\"规格\":\"单条装\"}'),
       (190, 3436033, 'CARE_3436033', 7.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/99c83709ca5f9fd5c5bb35d207ad7822.png', NULL, NULL, 0,
        '{\"规格\":\"单条装\"}'),
       (191, 4000009, 'YX_4000009', 1599.00, 0, NULL,
        'https://yanxuan-item.nosdn.127.net/3567b2ac2526e6b89124f3fb62fd09d3.png', NULL, NULL, 0,
        '{\"型号\":\"标准款\"}'),
       (192, 4027998, 'YX_4027998', 69.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/e07c2b63765cf9f4a46d489c6e09c1c1.jpg', NULL, NULL, 0,
        '{\"规格\":\"495g\"}'),
       (193, 3529022, 'DIGI_3529022', 13.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/21216556e7d47a4e4277dcb36a16a486.png', NULL, NULL, 0,
        '{\"颜色\":\"混色装\"}'),
       (194, 3506005, 'DIGI_3506005', 328.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/f3636b063dad944aa527e4652392a553.png', NULL, NULL, 0,
        '{\"颜色\":\"星空银\"}'),
       (195, 3996603, 'SPORT_3996603', 439.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/2d0a47a51fa4b3e3857f2010bd83bead.jpg', NULL, NULL, 0,
        '{\"型号\":\"标准款\"}'),
       (196, 3995454, 'SPORT_3995454', 135.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', NULL, NULL, 0,
        '{\"颜色\":\"黑色\"}'),
       (197, 1589017, 'OTHER_1589017', 14.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', NULL, NULL, 0,
        '{\"规格\":\"5件套\"}'),
       (198, 1548001, 'OTHER_1548001', 8.90, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"规格\":\"3卷装\"}'),
       (199, 48, '300274056', 49.00, 80, NULL,
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', NULL, NULL, 0,
        '{\"规格\": \"暖宫腰带3片/盒\"}'),
       (200, 55, '300274056', 49.00, 100, 0, '', 100, NULL, 0, '{\"规格\":\"暖宫腰带3片/盒\"}'),
       (201, 26, 'HWP20_GB_128', 3788.00, 88, 10,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, 3688.00, 0,
        '{\"颜色\":\"金色\",\"内存\":\"128GB\"}'),
       (202, 26, 'HWP20_SL_128', 3788.00, 92, 10,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, 3688.00, 0,
        '{\"颜色\":\"银色\",\"内存\":\"128GB\"}'),
       (203, 27, 'XM8_BK_64', 2599.00, 120, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', NULL, 2499.00, 0,
        '{\"颜色\":\"黑色\",\"内存\":\"64GB\"}'),
       (204, 38, 'HM50_BK_128', 4699.00, 50, 5,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, 4599.00, 0,
        '{\"颜色\":\"曜金黑\",\"内存\":\"128GB\"}'),
       (205, 38, 'HM50_WH_256', 5199.00, 30, 5,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, 5099.00, 0,
        '{\"颜色\":\"冰霜银\",\"内存\":\"256GB\"}'),
       (206, 39, 'XM14_BK_256', 4599.00, 200, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, 4399.00, 0,
        '{\"颜色\":\"黑色\",\"内存\":\"256GB\"}'),
       (207, 39, 'XM14_WH_512', 4999.00, 150, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, 4799.00, 0,
        '{\"颜色\":\"白色\",\"内存\":\"512GB\"}'),
       (208, 68, 'NZY_L', 409.00, 80, 10,
        'http://localhost:9000/images/category/clothing/0ff69c2099d98aa3cdddcb0edb9108a0.png', NULL, NULL, 0,
        '{\"颜色\":\"黑色\",\"尺码\":\"L\"}'),
       (209, 68, 'NZY_XL', 409.00, 60, 10,
        'http://localhost:9000/images/category/clothing/0ff69c2099d98aa3cdddcb0edb9108a0.png', NULL, NULL, 0,
        '{\"颜色\":\"黑色\",\"尺码\":\"XL\"}'),
       (210, 3995013, 'ETYX_26', 109.00, 45, 5,
        'http://localhost:9000/images/category/mother/088c9f9208b82fa4777336d22faa919d.jpg', NULL, NULL, 0,
        '{\"颜色\":\"白色\",\"尺码\":\"26码\"}'),
       (211, 3995013, 'ETYX_28', 109.00, 35, 5,
        'http://localhost:9000/images/category/mother/088c9f9208b82fa4777336d22faa919d.jpg', NULL, NULL, 0,
        '{\"颜色\":\"粉色\",\"尺码\":\"28码\"}'),
       (212, 1, 'NO86577-BLACK-M', 100.00, 100, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', NULL, 80.00, 0,
        '{\"颜色\":\"黑色\",\"尺寸\":\"M\"}'),
       (213, 1, 'NO86577-BLACK-X', 100.00, 80, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', NULL, 80.00, 0,
        '{\"颜色\":\"黑色\",\"尺寸\":\"X\"}'),
       (214, 1, 'NO86577-WHITE-M', 100.00, 90, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', NULL, 80.00, 0,
        '{\"颜色\":\"白色\",\"尺寸\":\"M\"}'),
       (217, 29, 'IP8P-RED-64', 5499.00, 20, 2, 'http://iphone1.jpg', NULL, NULL, 0,
        '{\"颜色\":\"红色\",\"容量\":\"64GB\"}'),
       (218, 29, 'IP8P-GOLD-256', 6499.00, 15, 2, 'http://iphone2.jpg', NULL, 6299.00, 0,
        '{\"颜色\":\"金色\",\"容量\":\"256GB\"}'),
       (219, 30, 'HNTBJ2E042A-BLUE-M', 98.00, 200, 30, 'http://tshirt1.jpg', NULL, NULL, 0,
        '{\"颜色\":\"蓝色\",\"尺寸\":\"M\"}'),
       (220, 30, 'HNTBJ2E042A-GRAY-L', 98.00, 150, 30, 'http://tshirt1.jpg', NULL, 88.00, 0,
        '{\"颜色\":\"灰色\",\"尺寸\":\"L\"}'),
       (221, 37, 'P50-BLACK-256', 4128.00, 50, 5, 'http://p50.jpg', NULL, NULL, 0,
        '{\"颜色\":\"曜金黑\",\"存储\":\"256GB\"}'),
       (222, 38, 'MATE50-SILVER-128', 4699.00, 80, 10, 'http://mate50.jpg', NULL, 4599.00, 0,
        '{\"颜色\":\"银色\",\"存储\":\"128GB\"}'),
       (223, 39, 'MI14-BLACK-512', 4599.00, 120, 15, 'http://mi14.jpg', NULL, 4399.00, 0,
        '{\"颜色\":\"黑色\",\"存储\":\"512GB\"}'),
       (224, 55, 'BELT-PINK', 49.00, 300, 50, 'http://belt.jpg', NULL, NULL, 0, '{\"颜色\":\"粉色\"}'),
       (225, 64, 'BAG-BLACK', 146.00, 80, 10, 'http://bag.jpg', NULL, NULL, 0, '{\"颜色\":\"黑色\"}'),
       (226, 72, 'POT-18CM', 149.00, 150, 20, 'http://pot.jpg', NULL, NULL, 0, '{\"规格\":\"18cm\"}'),
       (227, 26, 'HWP20-001', 3788.00, 100, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, 3688.00, 0,
        '{\"颜色\":\"亮黑色\",\"内存\":\"6GB+64GB\"}'),
       (228, 26, 'HWP20-002', 4288.00, 80, 20,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, 4188.00, 0,
        '{\"颜色\":\"宝石蓝\",\"内存\":\"6GB+128GB\"}'),
       (229, 27, 'XM8-001', 2599.00, 150, 30,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', NULL, NULL, 0,
        '{\"颜色\":\"黑色\",\"内存\":\"6GB+64GB\"}'),
       (230, 27, 'XM8-002', 2899.00, 120, 30,
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', NULL, 2799.00, 0,
        '{\"颜色\":\"蓝色\",\"内存\":\"6GB+128GB\"}'),
       (231, 38, 'HM50-001', 4699.00, 100, 20, 'http://img.huawei.com/mate50-black.jpg', NULL, 4599.00, 0,
        '{\"颜色\":\"曜金黑\",\"内存\":\"8GB+128GB\"}'),
       (232, 38, 'HM50-002', 5199.00, 80, 20, 'http://img.huawei.com/mate50-sunset.jpg', NULL, 5099.00, 0,
        '{\"颜色\":\"昆仑霞光\",\"内存\":\"8GB+256GB\"}'),
       (233, 39, 'XM14-01', 4599.00, 200, 50, 'http://img.mi.com/14-black.jpg', NULL, 4399.00, 0,
        '{\"颜色\":\"黑色\",\"内存\":\"16GB+512GB\"}'),
       (234, 39, 'XM14-02', 4999.00, 150, 50, 'http://img.mi.com/14-white.jpg', NULL, 4799.00, 0,
        '{\"颜色\":\"白色\",\"内存\":\"16GB+1TB\"}'),
       (235, 35, 'NX356-01', 369.00, 200, 50, 'http://img.shoes.com/nx-black-41.jpg', NULL, NULL, 0,
        '{\"颜色\":\"黑色\",\"尺码\":\"41\"}'),
       (236, 35, 'NX356-02', 369.00, 180, 50, 'http://img.shoes.com/nx-gray-42.jpg', NULL, 349.00, 0,
        '{\"颜色\":\"深灰\",\"尺码\":\"42\"}'),
       (237, 71, 'WS71-01', 220.00, 300, 100, 'http://img.shoes.com/ws-pink-36.jpg', NULL, NULL, 0,
        '{\"颜色\":\"樱花粉\",\"尺码\":\"36\"}'),
       (238, 71, 'WS71-02', 220.00, 250, 100, 'http://img.shoes.com/ws-green-37.jpg', NULL, 199.00, 0,
        '{\"颜色\":\"薄荷绿\",\"尺码\":\"37\"}'),
       (239, 48, 'XNG48-001', 149.00, 500, 100, 'http://img.home.com/xiaonaiguo.jpg', NULL, NULL, 0,
        '{\"规格\":\"标准款\"}'),
       (240, 58, 'WGM58-01', 9.90, 2000, 500, 'http://img.food.com/wgmi-400g.jpg', NULL, NULL, 0,
        '{\"规格\":\"400g\",\"包装\":\"袋装\"}'),
       (241, 58, 'WGM58-02', 18.90, 1500, 500, 'http://img.food.com/wgmi-800g.jpg', NULL, 17.90, 0,
        '{\"规格\":\"800g\",\"包装\":\"盒装\"}'),
       (242, 69, 'LGB69-20', 399.00, 300, 60, 'http://img.luggage.com/20-black.jpg', NULL, 379.00, 0,
        '{\"尺寸\":\"20寸\",\"颜色\":\"黑色\"}'),
       (243, 69, 'LGB69-24', 439.00, 200, 40, 'http://img.luggage.com/24-silver.jpg', NULL, NULL, 0,
        '{\"尺寸\":\"24寸\",\"颜色\":\"银色\"}'),
       (244, 70, 'DWN70-L', 659.00, 200, 40, 'http://img.coat.com/down-black-L.jpg', NULL, 639.00, 0,
        '{\"颜色\":\"黑色\",\"尺码\":\"L\"}'),
       (245, 70, 'DWN70-XL', 659.00, 180, 36, 'http://img.coat.com/down-gray-XL.jpg', NULL, NULL, 0,
        '{\"颜色\":\"深灰\",\"尺码\":\"XL\"}'),
       (246, 71, 'WS71-36', 220.00, 300, 60, 'http://img.shoes.com/ws-pink-36.jpg', NULL, 199.00, 0,
        '{\"颜色\":\"樱花粉\",\"尺码\":\"36\"}'),
       (247, 71, 'WS71-37', 220.00, 250, 50, 'http://img.shoes.com/ws-blue-37.jpg', NULL, NULL, 0,
        '{\"颜色\":\"天空蓝\",\"尺码\":\"37\"}'),
       (248, 72, 'XNG72-STD', 149.00, 800, 160, 'http://img.home.com/xiaonaiguo-std.jpg', NULL, NULL, 0,
        '{\"规格\":\"标准款\"}'),
       (249, 1555000, 'YZ1555-01', 79.00, 500, 100,
        'http://localhost:9000/images/category/clothing/85432452d5f40c4798c08f1f0beb4a43.png', NULL, NULL, 0,
        '{\"颜色\":\"黑色\"}'),
       (250, 1555000, 'YZ1555-02', 79.00, 500, 100,
        'http://localhost:9000/images/category/clothing/85432452d5f40c4798c08f1f0beb4a43.png', NULL, NULL, 0,
        '{\"颜色\":\"粉红色\"}'),
       (251, 1085007, 'LJD1085-60', 9.50, 2000, 400,
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', NULL, NULL, 0,
        '{\"规格\":\"18μm\",\"数量\":\"60只\"}'),
       (252, 1085007, 'LJD1085-90', 12.90, 1500, 300,
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', NULL, NULL, 0,
        '{\"规格\":\"22μm\",\"数量\":\"90只\"}'),
       (253, 1593000, 'SKU1593000-藏M', 559.00, 87, 18,
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', 0, NULL, 0,
        '{\"颜色\": \"藏青\", \"尺码\": \"M\"}'),
       (254, 1593000, 'SKU1593000-藏XL', 559.00, 179, 18,
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', 0, NULL, 0,
        '{\"颜色\": \"藏青\", \"尺码\": \"XL\"}'),
       (255, 1593000, 'SKU1593000-灰L', 559.00, 85, 16,
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"L\"}'),
       (256, 1593000, 'SKU1593000-灰M', 559.00, 189, 6,
        'http://localhost:9000/images/category/clothing/06156761337ba0fd1f8f51470f698b5f.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"M\"}'),
       (257, 1621018, 'SKU1621018-灰XL', 589.00, 85, 9,
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"XL\"}'),
       (258, 1621018, 'SKU1621018-灰XXL', 589.00, 172, 15,
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"XXL\"}'),
       (259, 1621018, 'SKU1621018-黑L', 589.00, 163, 8,
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"L\"}'),
       (260, 1621018, 'SKU1621018-黑XL', 589.00, 128, 9,
        'http://localhost:9000/images/category/clothing/540f84174dbf9b98d4072abbd886819e.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"XL\"}'),
       (261, 3436033, 'SKU3436033-白S', 7.90, 126, 18,
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"S\"}'),
       (262, 3436033, 'SKU3436033-白XL', 7.90, 131, 6,
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"XL\"}'),
       (263, 3436033, 'SKU3436033-红L', 7.90, 98, 6,
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"L\"}'),
       (264, 3436033, 'SKU3436033-红M', 7.90, 144, 6,
        'http://localhost:9000/images/category/personalCare/99c83709ca5f9fd5c5bb35d207ad7822.png', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"M\"}'),
       (265, 3465081, 'SKU3465081-黑XXL', 9.90, 141, 10,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"XXL\"}'),
       (266, 3465081, 'SKU3465081-黑S', 9.90, 81, 15,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"S\"}'),
       (267, 3465081, 'SKU3465081-灰M', 9.90, 169, 20,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"M\"}'),
       (268, 3465081, 'SKU3465081-灰XXL', 9.90, 142, 17,
        'http://localhost:9000/images/category/personalCare/bc32744cdf844b5136d3d84b0e6ba9d4.jpg', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"XXL\"}'),
       (269, 3468024, 'SKU3468024-红XXL', 398.00, 76, 11,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"XXL\"}'),
       (270, 3468024, 'SKU3468024-红XL', 398.00, 169, 15,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"XL\"}'),
       (271, 3468024, 'SKU3468024-灰M', 398.00, 148, 20,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"M\"}'),
       (272, 3468024, 'SKU3468024-灰S', 398.00, 174, 16,
        'http://localhost:9000/images/category/electronics/cc1c57b701f202bc585d8fff3b65571e.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"S\"}'),
       (273, 3529022, 'SKU3529022-白L', 13.90, 105, 16,
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"L\"}'),
       (274, 3529022, 'SKU3529022-白XL', 13.90, 109, 16,
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"XL\"}'),
       (275, 3529022, 'SKU3529022-蓝XL', 13.90, 104, 10,
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"XL\"}'),
       (276, 3529022, 'SKU3529022-蓝L', 13.90, 128, 8,
        'http://localhost:9000/images/category/electronics/21216556e7d47a4e4277dcb36a16a486.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"L\"}'),
       (277, 3987992, 'SKU3987992-灰S', 18.50, 86, 18,
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"S\"}'),
       (278, 3987992, 'SKU3987992-灰M', 18.50, 79, 7,
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', 0, NULL, 0,
        '{\"颜色\": \"灰色\", \"尺码\": \"M\"}'),
       (279, 3987992, 'SKU3987992-黑XL', 18.50, 184, 17,
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"XL\"}'),
       (280, 3987992, 'SKU3987992-黑M', 18.50, 158, 8,
        'http://localhost:9000/images/category/personalCare/e0cea368f41da1587b3b7fc523f169d7.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"M\"}'),
       (281, 3990343, 'SKU3990343-蓝L', 67.50, 144, 7,
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"L\"}'),
       (282, 3990343, 'SKU3990343-蓝S', 67.50, 193, 19,
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"S\"}'),
       (283, 3990343, 'SKU3990343-藏M', 67.50, 136, 7,
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', 0, NULL, 0,
        '{\"颜色\": \"藏青\", \"尺码\": \"M\"}'),
       (284, 3990343, 'SKU3990343-藏S', 67.50, 141, 9,
        'http://localhost:9000/images/category/curatedSelection/188e05584a056b0e2f17e8c568da8c00.png', 0, NULL, 0,
        '{\"颜色\": \"藏青\", \"尺码\": \"S\"}'),
       (285, 3992720, 'SKU3992720-白XL', 49.00, 102, 10,
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"XL\"}'),
       (286, 3992720, 'SKU3992720-白M', 49.00, 110, 13,
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', 0, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"M\"}'),
       (287, 3992720, 'SKU3992720-红XL', 49.00, 59, 14,
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"XL\"}'),
       (288, 3992720, 'SKU3992720-红L', 49.00, 119, 8,
        'http://localhost:9000/images/category/electronics/2245a3d6898361236babb66d834e19c8.jpg', 0, NULL, 0,
        '{\"颜色\": \"红色\", \"尺码\": \"L\"}'),
       (289, 3994432, 'SKU3994432-蓝XL', 33.90, 135, 16,
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"XL\"}'),
       (290, 3994432, 'SKU3994432-蓝M', 33.90, 118, 8,
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', 0, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"M\"}'),
       (291, 3994432, 'SKU3994432-黑M', 33.90, 150, 20,
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"M\"}'),
       (292, 3994432, 'SKU3994432-黑XL', 33.90, 83, 7,
        'http://localhost:9000/images/category/electronics/15db90ea8c8c7456c1fee4e18abb25da.png', 0, NULL, 0,
        '{\"颜色\": \"黑色\", \"尺码\": \"XL\"}'),
       (293, 1006029, 'SN1006029-WHITE', 15.90, 300, 50,
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png', NULL, NULL, 0,
        '{\"颜色\": \"白色\", \"规格\": \"标准装\"}'),
       (294, 1006029, 'SN1006029-GRAY', 15.90, 300, 50,
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png', NULL, NULL, 0,
        '{\"颜色\": \"灰色\", \"规格\": \"标准装\"}'),
       (295, 1006029, 'SN1006029-FAMILY', 15.90, 300, 50,
        'http://localhost:9000/images/category/personalCare/3480e3fa68b810f23afb43f6bf2fe45b.png', NULL, NULL, 0,
        '{\"颜色\": \"米白\", \"规格\": \"家庭装\"}'),
       (296, 1076004, 'SN1076004-PINK', 9.50, 333, 17,
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', NULL, NULL, 0,
        '{\"颜色\": \"樱花粉\"}'),
       (297, 1076004, 'SN1076004-BLUE', 9.50, 333, 17,
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', NULL, NULL, 0,
        '{\"颜色\": \"天空蓝\"}'),
       (298, 1076004, 'SN1076004-GREEN', 9.50, 334, 16,
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', NULL, NULL, 0,
        '{\"颜色\": \"薄荷绿\"}'),
       (299, 3998535, 'SN3998535-4', 109.00, 142, 20,
        'http://localhost:9000/images/category/mother/ef01de6dfac9cc4c548f317f2feddafe.jpg', NULL, NULL, 0,
        '{\"尺码\": \"4码\", \"适用阶段\": \"学步期\"}'),
       (300, 3998535, 'SN3998535-5', 109.00, 142, 20,
        'http://localhost:9000/images/category/mother/ef01de6dfac9cc4c548f317f2feddafe.jpg', NULL, NULL, 0,
        '{\"尺码\": \"5码\", \"适用阶段\": \"学步期\"}'),
       (301, 3998535, 'SN3998535-6', 109.00, 143, 20,
        'http://localhost:9000/images/category/mother/ef01de6dfac9cc4c548f317f2feddafe.jpg', NULL, NULL, 0,
        '{\"尺码\": \"6码\", \"适用阶段\": \"稳步期\"}'),
       (302, 1006051, 'SN1006051-GRAY', 31.90, 300, 50,
        'http://localhost:9000/images/.../2a16452169f9d2e8841ddef76fdd684a.png', NULL, NULL, 0,
        '{\"颜色\": \"灰色\", \"规格\": \"标准装\"}'),
       (303, 1006051, 'SN1006051-BLUE', 31.90, 300, 50,
        'http://localhost:9000/images/.../2a16452169f9d2e8841ddef76fdd684a.png', NULL, NULL, 0,
        '{\"颜色\": \"蓝色\", \"规格\": \"标准装\"}'),
       (304, 1006051, 'SN1006051-BEIGE', 31.90, 400, 50,
        'http://localhost:9000/images/.../2a16452169f9d2e8841ddef76fdd684a.png', NULL, NULL, 0,
        '{\"颜色\": \"米色\", \"规格\": \"标准装\"}'),
       (305, 1306017, 'SN1306017-BLACK-11L', 89.00, 500, 50,
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', NULL, NULL, 0,
        '{\"颜色\": \"黑色\", \"容量\": \"11L\"}'),
       (306, 1306017, 'SN1306017-WHITE-15L', 89.00, 500, 50,
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', NULL, NULL, 0,
        '{\"颜色\": \"白色\", \"容量\": \"15L\"}'),
       (307, 4007784, 'SN4007784-PINK', 119.00, 334, 50,
        'http://localhost:9000/images/.../a9f428091f172db89977a511f6639fec.jpg', NULL, NULL, 0,
        '{\"颜色\": \"粉色\", \"尺码\": \"4-6码\"}'),
       (308, 4007784, 'SN4007784-BLUE', 119.00, 333, 50,
        'http://localhost:9000/images/.../a9f428091f172db89977a511f6639fec.jpg', NULL, NULL, 0,
        '{\"颜色\": \"蓝色\", \"尺码\": \"4-6码\"}'),
       (309, 4007784, 'SN4007784-WHITE', 119.00, 333, 50,
        'http://localhost:9000/images/.../a9f428091f172db89977a511f6639fec.jpg', NULL, NULL, 0,
        '{\"颜色\": \"白色\", \"尺码\": \"4-6码\"}'),
       (310, 3998109, 'SN3998109-LONG', 8.00, 1000, 50,
        'http://localhost:9000/.../7537da93f26f0303d94c59f3889836ed.png', NULL, NULL, 0, '{\"类型\": \"长款\"}'),
       (311, 3998109, 'SN3998109-SHORT', 8.00, 1000, 50,
        'http://localhost:9000/.../7537da93f26f0303d94c59f3889836ed.png', NULL, NULL, 0, '{\"类型\": \"短款\"}'),
       (312, 4028000, 'SN4028000-BLACK', 135.00, 173, 50,
        'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', NULL, NULL, 0,
        '{\"颜色\": \"黑色\"}'),
       (313, 4028000, 'SN4028000-GREY', 135.00, 173, 50,
        'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', NULL, NULL, 0,
        '{\"颜色\": \"灰色\"}'),
       (314, 4028000, 'SN4028000-RED', 135.00, 154, 50,
        'https://yanxuan-item.nosdn.127.net/3683d874b9623434a10b4ab0c2e6be9f.png', NULL, NULL, 0,
        '{\"颜色\": \"红色\"}'),
       (315, 1009026, 'SN1009026-BE', 129.00, 1000, 100,
        'http://localhost:9000/images/category/personalCare/957d7a338fc0de044965cc279fce68b2.png', 0, NULL, 0,
        '{\"颜色\": \"米色\"}'),
       (316, 1009026, 'SN1009026-DB', 129.00, 1000, 100,
        'http://localhost:9000/images/category/personalCare/957d7a338fc0de044965cc279fce68b2.png', 0, NULL, 0,
        '{\"颜色\": \"深蓝色\"}'),
       (317, 1021000, 'SN1021000-GN', 16.90, 1000, 100,
        'http://localhost:9000/images/category/personalCare/a5c5398a7c033edb8a052fe1fddf8a81.png', 0, NULL, 0,
        '{\"颜色\": \"绿色\"}'),
       (318, 1021000, 'SN1021000-PK', 16.90, 1000, 100,
        'http://localhost:9000/images/category/personalCare/a5c5398a7c033edb8a052fe1fddf8a81.png', 0, NULL, 0,
        '{\"颜色\": \"粉色\"}'),
       (319, 1111002, 'SN1111002-GD', 9.90, 1000, 100,
        'http://localhost:9000/images/category/electronics/4c6a9c8a579b00e5e9c7b002d15a33a2.jpg', 0, NULL, 0,
        '{\"颜色\": \"金色\"}'),
       (320, 1111002, 'SN1111002-SL', 9.90, 1000, 100,
        'http://localhost:9000/images/category/electronics/4c6a9c8a579b00e5e9c7b002d15a33a2.jpg', 0, NULL, 0,
        '{\"颜色\": \"银色\"}'),
       (321, 1129016, 'SN1129016-GY', 16.90, 1000, 100,
        'http://localhost:9000/images/category/personalCare/2f4ff18d601494cb7805ee099ed8a50f.png', 0, NULL, 0,
        '{\"颜色\": \"浅灰\"}'),
       (322, 1129016, 'SN1129016-BE', 16.90, 1000, 100,
        'http://localhost:9000/images/category/personalCare/2f4ff18d601494cb7805ee099ed8a50f.png', 0, NULL, 0,
        '{\"颜色\": \"米色\"}'),
       (323, 1306017, 'SN1306017-BK', 9.90, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', 0, NULL, 0, '{\"颜色\": \"黑色\"}'),
       (324, 1306017, 'SN1306017-WH', 9.90, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', 0, NULL, 0, '{\"颜色\": \"白色\"}'),
       (325, 1306019, 'SN1306019-BE', 9.90, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', 0, NULL, 0, '{\"颜色\": \"米色\"}'),
       (326, 1306019, 'SN1306019-GY', 9.90, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/ca7144b1f5fda5528dd8e4c40abc3bcc.png', 0, NULL, 0, '{\"颜色\": \"灰色\"}'),
       (327, 1436010, 'SN1436010-MIX', 139.00, 1000, 100,
        'http://localhost:9000/images/category/personalCare/f4ed2e5d7b268bb270bce9ce63122ec0.jpg', 0, NULL, 0,
        '{\"类型\": \"多色组合装\"}'),
       (328, 1436010, 'SN1436010-BE', 139.00, 1000, 100,
        'http://localhost:9000/images/category/personalCare/f4ed2e5d7b268bb270bce9ce63122ec0.jpg', 0, NULL, 0,
        '{\"颜色\": \"米色\"}'),
       (329, 1436010, 'SN1436010-DB', 139.00, 1000, 100,
        'http://localhost:9000/images/category/personalCare/f4ed2e5d7b268bb270bce9ce63122ec0.jpg', 0, NULL, 0,
        '{\"颜色\": \"深蓝色\"}'),
       (330, 1458011, 'SN1458011-BK', 88.00, 1000, 100,
        'http://localhost:9000/images/category/electronics/b20165617d2f901e9ad926f39b737e87.png', 0, NULL, 0,
        '{\"墨水颜色\": \"黑色\"}'),
       (331, 1458011, 'SN1458011-BL', 88.00, 1000, 100,
        'http://localhost:9000/images/category/electronics/b20165617d2f901e9ad926f39b737e87.png', 0, NULL, 0,
        '{\"墨水颜色\": \"蓝色\"}'),
       (332, 1512000, 'SN1512000-FCJ', 89.00, 1000, 100,
        'http://localhost:9000/images/category/electronics/3892e311f3494d2bcc2c1f8ed9e34271.png', 0, NULL, 0,
        '{\"主题\": \"飞鸟集\"}'),
       (333, 1512000, 'SN1512000-XK', 89.00, 1000, 100,
        'http://localhost:9000/images/category/electronics/3892e311f3494d2bcc2c1f8ed9e34271.png', 0, NULL, 0,
        '{\"主题\": \"星空\"}'),
       (334, 3998109, 'SN3998109-LONG', 26.90, 1000, 100,
        'http://localhost:9000/images/category/curatedSelection/53a1579ead54c61a9b296d20c78a67ff.jpg', 0, NULL, 0,
        '{\"款式\": \"长柄\"}'),
       (335, 3998109, 'SN3998109-SHORT', 26.90, 1000, 100,
        'http://localhost:9000/images/category/curatedSelection/53a1579ead54c61a9b296d20c78a67ff.jpg', 0, NULL, 0,
        '{\"款式\": \"短柄\"}'),
       (336, 4007784, 'SN4007784-4', 119.00, 1000, 100,
        'http://localhost:9000/images/category/mother/a9f428091f172db89977a511f6639fec.jpg', 0, NULL, 0,
        '{\"尺寸\": \"4码\"}'),
       (337, 4007784, 'SN4007784-5', 119.00, 1000, 100,
        'http://localhost:9000/images/category/mother/a9f428091f172db89977a511f6639fec.jpg', 0, NULL, 0,
        '{\"尺寸\": \"5码\"}'),
       (338, 4007784, 'SN4007784-6', 119.00, 1000, 100,
        'http://localhost:9000/images/category/mother/a9f428091f172db89977a511f6639fec.jpg', 0, NULL, 0,
        '{\"尺寸\": \"6码\"}'),
       (339, 4023638, 'SN4023638-26-RED', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"红色\"}'),
       (340, 4023638, 'SN4023638-26-BLUE', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"26\", \"颜色\": \"蓝色\"}'),
       (341, 4023638, 'SN4023638-27-RED', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"27\", \"颜色\": \"红色\"}'),
       (342, 4023638, 'SN4023638-27-BLUE', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"27\", \"颜色\": \"蓝色\"}'),
       (343, 4023638, 'SN4023638-28-RED', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"28\", \"颜色\": \"红色\"}'),
       (344, 4023638, 'SN4023638-28-BLUE', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"28\", \"颜色\": \"蓝色\"}'),
       (345, 4023638, 'SN4023638-29-RED', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"29\", \"颜色\": \"红色\"}'),
       (346, 4023638, 'SN4023638-29-BLUE', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"29\", \"颜色\": \"蓝色\"}'),
       (347, 4023638, 'SN4023638-30-RED', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"30\", \"颜色\": \"红色\"}'),
       (348, 4023638, 'SN4023638-30-BLUE', 109.00, 1000, 100,
        'http://localhost:9000/images/category/mother/d917c92e663c5ed0bb577c7ded73e4ec.png', 0, NULL, 0,
        '{\"尺寸\": \"30\", \"颜色\": \"蓝色\"}'),
       (349, 4028001, 'SN4028001-BK', 35.00, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/25effebb31ea6fc58b92f5a6aecda8b9.png', 0, NULL, 0, '{\"颜色\": \"黑色\"}'),
       (350, 4028001, 'SN4028001-GY', 35.00, 1000, 100,
        'https://yanxuan-item.nosdn.127.net/25effebb31ea6fc58b92f5a6aecda8b9.png', 0, NULL, 0, '{\"颜色\": \"灰色\"}'),
       (351, 1525018, 'SKU1525018-01', 7.90, 1000, 50, NULL, NULL, NULL, 0, '{\"规格\":\"40片/包\"}'),
       (352, 1540017, 'SKU1540017-01', 8.90, 1000, 50, NULL, NULL, NULL, 0, '{\"规格\":\"单包\"}'),
       (353, 3499024, 'SKU3499024-GOLD', 158.00, 200, 800, NULL, NULL, NULL, 0, '{\"颜色\":\"金色\"}'),
       (354, 3499024, 'SKU3499024-SILVER', 158.00, 227, 800, NULL, NULL, NULL, 0, '{\"颜色\":\"银色\"}'),
       (355, 3990408, 'SKU3990408-01', 17.90, 1800, 450, NULL, NULL, NULL, 0, '{\"容量\":\"400ml\"}'),
       (356, 3999485, 'SKU3999485-01', 39.00, 1200, 650, NULL, NULL, NULL, 0, '{\"容量\":\"625ml\"}'),
       (357, 4010699, 'SKU4010699-01', 35.00, 800, 300, NULL, NULL, NULL, 0, '{\"容量\":\"250ml\"}'),
       (358, 4017718, 'SKU4017718-01', 26.90, 1500, 300, NULL, NULL, NULL, 0, '{\"规格\":\"标准装\"}'),
       (359, 4023641, 'SKU4023641-21', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"21\"}'),
       (360, 4023641, 'SKU4023641-22', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"22\"}'),
       (361, 4023641, 'SKU4023641-23', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"23\"}'),
       (362, 4023641, 'SKU4023641-24', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"24\"}'),
       (363, 4023641, 'SKU4023641-25', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"25\"}'),
       (364, 4023641, 'SKU4023641-26', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"26\"}'),
       (365, 4023641, 'SKU4023641-27', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"27\"}'),
       (366, 4023641, 'SKU4023641-28', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"28\"}'),
       (367, 4023641, 'SKU4023641-29', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"29\"}'),
       (368, 4023641, 'SKU4023641-30', 129.00, 100, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"30\"}'),
       (369, 4023738, 'SKU4023738-25', 139.00, 166, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"25\"}'),
       (370, 4023738, 'SKU4023738-26', 139.00, 166, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"26\"}'),
       (371, 4023738, 'SKU4023738-27', 139.00, 166, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"27\"}'),
       (372, 4023738, 'SKU4023738-28', 139.00, 166, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"28\"}'),
       (373, 4023738, 'SKU4023738-29', 139.00, 166, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"29\"}'),
       (374, 4023738, 'SKU4023738-30', 139.00, 170, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"30\"}'),
       (375, 4023751, 'SKU4023751-59', 62.00, 200, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"59cm\"}'),
       (376, 4023751, 'SKU4023751-66', 62.00, 200, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"66cm\"}'),
       (377, 4023751, 'SKU4023751-73', 62.00, 200, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"73cm\"}'),
       (378, 4023751, 'SKU4023751-80', 62.00, 200, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"80cm\"}'),
       (379, 4023751, 'SKU4023751-90', 62.00, 200, NULL, NULL, NULL, NULL, 0, '{\"尺码\":\"90cm\"}'),
       (380, 4023839, 'SKU4023839-ICE', 29.80, 1250, 75, NULL, NULL, NULL, 0, '{\"类型\":\"冰块\"}'),
       (381, 4023839, 'SKU4023839-BALL', 29.80, 1250, 75, NULL, NULL, NULL, 0, '{\"类型\":\"冰球\"}'),
       (382, 4027999, 'SKU4027999-BLACK', 439.00, 168, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"黑色\"}'),
       (383, 4027999, 'SKU4027999-WHITE', 439.00, 168, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"白色\"}'),
       (384, 4028002, 'SKU4028002-BLACK', 40.00, 86, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"黑色\"}'),
       (385, 4028002, 'SKU4028002-BLUE', 40.00, 86, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"蓝色\"}'),
       (386, 4028003, 'SKU4028003-S', 69.00, 161, NULL, NULL, NULL, NULL, 0, '{\"尺寸\":\"S\"}'),
       (387, 4028003, 'SKU4028003-M', 69.00, 161, NULL, NULL, NULL, NULL, 0, '{\"尺寸\":\"M\"}'),
       (388, 4028003, 'SKU4028003-L', 69.00, 162, NULL, NULL, NULL, NULL, 0, '{\"尺寸\":\"L\"}'),
       (389, 4028004, 'SKU4028004-BLUE', 44.00, 154, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"深蓝\"}'),
       (390, 4028004, 'SKU4028004-PINK', 44.00, 154, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"浅粉\"}'),
       (391, 4028005, 'SKU4028005-BLACK', 44.00, 242, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"黑色\"}'),
       (392, 4028005, 'SKU4028005-WHITE', 44.00, 243, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"米白\"}'),
       (393, 4028006, 'SKU4028006-BLACK', 69.00, 202, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"曜石黑\"}'),
       (394, 4028006, 'SKU4028006-NAVY', 69.00, 202, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"海军蓝\"}'),
       (395, 4028007, 'SKU4028007-GREEN', 169.00, 233, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"军绿色\"}'),
       (396, 4028007, 'SKU4028007-CAMO', 169.00, 232, NULL, NULL, NULL, NULL, 0, '{\"颜色\":\"迷彩色\"}'),
       (397, 4028040, '4001126-BLACK-M', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"曜石黑\",\"尺码\":\"M\"}'),
       (398, 4028040, '4001126-BLACK-L', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"曜石黑\",\"尺码\":\"L\"}'),
       (399, 4028040, '4001126-BLACK-XL', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"曜石黑\",\"尺码\":\"XL\"}'),
       (400, 4028040, '4001126-GRAY-M', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"太空灰\",\"尺码\":\"M\"}'),
       (401, 4028040, '4001126-GRAY-L', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"太空灰\",\"尺码\":\"L\"}'),
       (402, 4028040, '4001126-GRAY-XL', 83.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/872275c2e2edacc917e0364065c90121.png', NULL, NULL, 0,
        '{\"颜色\":\"太空灰\",\"尺码\":\"XL\"}'),
       (403, 4028041, '4000914-WHITE-36', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"36\"}'),
       (404, 4028041, '4000914-WHITE-37', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"37\"}'),
       (405, 4028041, '4000914-WHITE-38', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"38\"}'),
       (406, 4028041, '4000914-WHITE-39', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"云朵白\",\"尺码\":\"39\"}'),
       (407, 4028041, '4000914-PINK-36', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"樱花粉\",\"尺码\":\"36\"}'),
       (408, 4028041, '4000914-PINK-37', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"樱花粉\",\"尺码\":\"37\"}'),
       (409, 4028041, '4000914-PINK-38', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/feec7bde4d52521ae70ab4c5010ce992.png', NULL, NULL, 0,
        '{\"颜色\":\"樱花粉\",\"尺码\":\"38\"}'),
       (410, 4028043, '4000620-NAVY-L', 659.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/aa9e03278e3274a2a83f3f8e7df5ee6f.png', NULL, NULL, 0,
        '{\"颜色\":\"海军蓝\",\"尺码\":\"L\"}'),
       (411, 4028043, '4000620-NAVY-XL', 659.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/aa9e03278e3274a2a83f3f8e7df5ee6f.png', NULL, NULL, 0,
        '{\"颜色\":\"海军蓝\",\"尺码\":\"XL\"}'),
       (412, 4028043, '4000620-BLACK-L', 659.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/aa9e03278e3274a2a83f3f8e7df5ee6f.png', NULL, NULL, 0,
        '{\"颜色\":\"经典黑\",\"尺码\":\"L\"}'),
       (413, 4028043, '4000620-BLACK-XL', 659.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/aa9e03278e3274a2a83f3f8e7df5ee6f.png', NULL, NULL, 0,
        '{\"颜色\":\"经典黑\",\"尺码\":\"XL\"}'),
       (414, 4028049, '1548001-SILVER-30L', 8.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"金属银\",\"规格\":\"30L/90只\"}'),
       (415, 4028049, '1548001-GOLD-30L', 8.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"香槟金\",\"规格\":\"30L/90只\"}'),
       (416, 4028049, '1548001-SILVER-45L', 9.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"金属银\",\"规格\":\"45L/60只\"}'),
       (417, 4028042, '1593000-CASH-M', 559.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"颜色\":\"经典驼色\",\"尺码\":\"M\",\"材质\":\"100%山羊绒\"}'),
       (418, 4028042, '1593000-CASH-L', 559.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"颜色\":\"经典驼色\",\"尺码\":\"L\",\"材质\":\"100%山羊绒\"}'),
       (419, 4028042, '1593000-CASH-XL', 559.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"颜色\":\"经典驼色\",\"尺码\":\"XL\",\"材质\":\"100%山羊绒\"}'),
       (420, 4028042, '1593000-GREY-M', 559.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"颜色\":\"高级灰\",\"尺码\":\"M\",\"材质\":\"100%山羊绒\"}'),
       (421, 4028042, '1593000-GREY-L', 559.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/06156761337ba0fd1f8f51470f698b5f.png', NULL, NULL, 0,
        '{\"颜色\":\"高级灰\",\"尺码\":\"L\",\"材质\":\"100%山羊绒\"}'),
       (422, 4028044, '1621018-PRO1', 589.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, 0,
        '{\"档位\":\"3档\",\"适用部位\":\"腰腹\"}'),
       (423, 4028044, '1621018-PRO2', 589.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, 0,
        '{\"档位\":\"5档\",\"适用部位\":\"腰腹\"}'),
       (424, 4028044, '1621018-PRO3', 589.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, 0,
        '{\"档位\":\"3档\",\"适用部位\":\"腿部\"}'),
       (425, 4028044, '1621018-PRO4', 589.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/540f84174dbf9b98d4072abbd886819e.png', NULL, NULL, 0,
        '{\"档位\":\"5档\",\"适用部位\":\"腿部\"}'),
       (426, 4028049, '1548001-SILVER-30L', 8.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"金属银\",\"规格\":\"30L/90只\"}'),
       (427, 4028049, '1548001-SILVER-45L', 9.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"金属银\",\"规格\":\"45L/60只\"}'),
       (428, 4028049, '1548001-GOLD-30L', 8.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"香槟金\",\"规格\":\"30L/90只\"}'),
       (429, 4028049, '1548001-GOLD-45L', 9.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/251393c0d8db7b0b594ccf86f1e796d0.png', NULL, NULL, 0,
        '{\"颜色\":\"香槟金\",\"规格\":\"45L/60只\"}'),
       (432, 4028038, '1135075-3BAGS', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1452cfeb14b5d252fb1ba97b278e9cc3.png', NULL, NULL, 0,
        '{\"包装规格\":\"470g*3袋\",\"产地\":\"黑龙江五常\"}'),
       (433, 4028038, '1135075-5BAGS', 31.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1452cfeb14b5d252fb1ba97b278e9cc3.png', NULL, NULL, 0,
        '{\"包装规格\":\"470g*5袋\",\"产地\":\"黑龙江五常\"}'),
       (434, 4028037, '1135076-3BAGS', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/eaec90be370a438e565e10189b7a390a.png', NULL, NULL, 0,
        '{\"包装规格\":\"450g*3袋\",\"品种\":\"东北红小豆\"}'),
       (435, 4028037, '1135076-6BAGS', 36.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/eaec90be370a438e565e10189b7a390a.png', NULL, NULL, 0,
        '{\"包装规格\":\"450g*6袋\",\"品种\":\"东北红小豆\"}'),
       (436, 4028038, '1135075-3BAGS', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1452cfeb14b5d252fb1ba97b278e9cc3.png', NULL, NULL, 0,
        '{\"包装规格\":\"470g*3袋\",\"产地\":\"黑龙江五常\"}'),
       (437, 4028038, '1135075-5BAGS', 31.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1452cfeb14b5d252fb1ba97b278e9cc3.png', NULL, NULL, 0,
        '{\"包装规格\":\"470g*5袋\",\"产地\":\"黑龙江五常\"}'),
       (438, 4028039, '3464033-SPICY-12', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/7a5ffe313fe5671709d5a9826f5a83a2.jpg', NULL, NULL, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*12盒\"}'),
       (439, 4028039, '3464033-SPICY-6', 42.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/7a5ffe313fe5671709d5a9826f5a83a2.jpg', NULL, NULL, 0,
        '{\"口味\":\"藤椒豚骨\",\"规格\":\"74g*6盒\"}'),
       (440, 4028039, '3464033-TOMYUM-12', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/7a5ffe313fe5671709d5a9826f5a83a2.jpg', NULL, NULL, 0,
        '{\"口味\":\"冬阴功\",\"规格\":\"74g*12盒\"}'),
       (441, 4028048, '1589017-BLUE-5', 14.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', NULL, NULL, 0,
        '{\"颜色\":\"深海蓝\",\"数量\":\"5片装\"}'),
       (442, 4028048, '1589017-GRAY-5', 14.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', NULL, NULL, 0,
        '{\"颜色\":\"高级灰\",\"数量\":\"5片装\"}'),
       (443, 4028048, '1589017-BLUE-10', 27.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/c520bba8209bae877158e8810d889aca.png', NULL, NULL, 0,
        '{\"颜色\":\"深海蓝\",\"数量\":\"10片装\"}'),
       (444, 4028054, '1085007-18μm-3', 9.50, 100, 10,
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', NULL, NULL, 0,
        '{\"厚度\":\"18μm\",\"数量\":\"3卷60只\"}'),
       (445, 4028054, '1085007-25μm-3', 11.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', NULL, NULL, 0,
        '{\"厚度\":\"25μm\",\"数量\":\"3卷60只\"}'),
       (446, 4028054, '1085007-18μm-6', 18.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/72af0b7c1d7b0b9710de621788326d2b.png', NULL, NULL, 0,
        '{\"厚度\":\"18μm\",\"数量\":\"6卷120只\"}'),
       (447, 4028053, '1306017-12L-FOOT', 89.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', NULL, NULL, 0,
        '{\"容量\":\"12L\",\"开合方式\":\"脚踏式\"}'),
       (448, 4028053, '1306017-18L-FOOT', 99.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', NULL, NULL, 0,
        '{\"容量\":\"18L\",\"开合方式\":\"脚踏式\"}'),
       (449, 4028053, '1306017-12L-TOUCH', 109.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/1b322ed8c25f94f1fbf39ddb5fedeb47.jpg', NULL, NULL, 0,
        '{\"容量\":\"12L\",\"开合方式\":\"感应式\"}'),
       (450, 4028034, '1135080-JUMBO', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/3e93790bba8db8aab54ee5ba72799567.png', NULL, NULL, 0,
        '{\"净含量\":\"600g\",\"加量比例\":\"50%\"}'),
       (451, 4028035, '1135079-MIXED', 9.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/bfe70bd66efe94f2f18061c707d2a097.png', NULL, NULL, 0,
        '{\"谷物种类\":\"12种\",\"烹饪方式\":\"免浸泡\"}'),
       (452, 4028036, '1135077-YELLOW', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/564eb51c22d898179b468f5dec52d502.png', NULL, NULL, 0,
        '{\"品种\":\"赤峰黄小米\",\"加量比例\":\"45%\"}'),
       (453, 4028045, '1555000-SILK', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/85432452d5f40c4798c08f1f0beb4a43.png', NULL, NULL, 0,
        '{\"材质\":\"6A级桑蚕丝\",\"遮光度\":\"100%\"}'),
       (454, 4028046, '1281002-DUAL', 119.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/89cc3ab3e332bb1df5dc20241b5ca4bb.png', NULL, NULL, 0,
        '{\"类型\":\"双拍套装\",\"材质\":\"碳纤维\"}'),
       (455, 4028047, '4001285-AUTO', 40.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/e77b8f4a8ddd1e777394d84347859f7c.png', NULL, NULL, 0,
        '{\"直径\":\"105cm\",\"功能\":\"防晒UPF50+\"}'),
       (456, 4028022, '3997602-WAIST', 49.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', NULL, NULL, 0,
        '{\"适用部位\":\"腰部\",\"规格\":\"标准款\"}'),
       (457, 4028022, '3997602-ABDOMEN', 49.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', NULL, NULL, 0,
        '{\"适用部位\":\"腹部\",\"规格\":\"加强款\"}'),
       (458, 4028022, '3997602-FULLSET', 89.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/9892cc73945da1591fa5259ad076b23c.jpg', NULL, NULL, 0,
        '{\"适用部位\":\"全身\",\"规格\":\"三区护理套装\"}'),
       (459, 4028023, '3987204-STD', 49.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"规格\":\"6罐基础装\",\"材质\":\"高硼硅玻璃\"}'),
       (460, 4028023, '3987204-PRO', 69.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"规格\":\"12罐专业装\",\"材质\":\"医用级硅胶\"}'),
       (461, 4028024, '3986121-8H', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/941abaee58a88cb104228fe2c4cfdeb1.png', NULL, NULL, 0,
        '{\"灸头数量\":\"8头\",\"适用场景\":\"局部穴位\"}'),
       (462, 4028024, '3986121-12H', 99.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/941abaee58a88cb104228fe2c4cfdeb1.png', NULL, NULL, 0,
        '{\"灸头数量\":\"12头\",\"适用场景\":\"全身理疗\"}'),
       (463, 4028025, '3995284-BASIC', 599.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/c41003c6df90d7673195dcc2482e13f3.jpg', NULL, NULL, 0,
        '{\"模式\":\"3种基础模式\",\"承重\":\"150kg\"}'),
       (464, 4028025, '3995284-PRO', 799.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/c41003c6df90d7673195dcc2482e13f3.jpg', NULL, NULL, 0,
        '{\"模式\":\"6种专业模式\",\"承重\":\"200kg\"}'),
       (465, 4028026, '3993828-S', 159.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/a6939f41c48fa9e9c8f7a7ed855351f1.jpg', NULL, NULL, 0,
        '{\"适用人群\":\"青少年\",\"调节档位\":\"5档\"}'),
       (466, 4028026, '3993828-L', 179.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/a6939f41c48fa9e9c8f7a7ed855351f1.jpg', NULL, NULL, 0,
        '{\"适用人群\":\"成人\",\"调节档位\":\"7档\"}'),
       (467, 4028028, '3992367-INVIS', 149.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/7d1bc78607a08c088b2a7cdbe88c05af.png', NULL, NULL, 0,
        '{\"佩戴方式\":\"隐形款\",\"支撑强度\":\"中级\"}'),
       (468, 4028028, '3992367-OUTER', 129.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/7d1bc78607a08c088b2a7cdbe88c05af.png', NULL, NULL, 0,
        '{\"佩戴方式\":\"外穿款\",\"支撑强度\":\"基础\"}'),
       (469, 4028050, '1540017-40P', 8.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/4c8a1cf2b8e40c250870491307dde11f.jpg', NULL, NULL, 0,
        '{\"功能\":\"基础清洁\",\"片数\":\"40片/包\"}'),
       (470, 4028050, '1540017-60P', 12.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/4c8a1cf2b8e40c250870491307dde11f.jpg', NULL, NULL, 0,
        '{\"功能\":\"除菌加强\",\"片数\":\"60片/包\"}'),
       (471, 4028055, '1076004-WHITE', 9.50, 100, 10,
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', NULL, NULL, 0,
        '{\"颜色\":\"云朵白\",\"材质\":\"短绒雪尼尔\"}'),
       (472, 4028055, '1076004-GREY', 9.50, 100, 10,
        'https://yanxuan-item.nosdn.127.net/43d99e9b97cc55033b0f59b95a91ae49.png', NULL, NULL, 0,
        '{\"颜色\":\"高级灰\",\"材质\":\"长绒雪尼尔\"}'),
       (473, 4028031, '1270008-500G', 9.90, 100, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"包装规格\":\"500g袋装\",\"品种\":\"黄金玉米\"}'),
       (474, 4028031, '1270008-1KG', 18.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"包装规格\":\"1kg礼盒装\",\"品种\":\"黄金玉米\"}'),
       (475, 4028033, '1135081-YN', 19.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/a3c0bb3be38ccf510ecaedb81f5bcd9f.png', NULL, NULL, 0,
        '{\"产地\":\"云南\",\"特性\":\"当季新米\"}'),
       (476, 4028033, '1135081-GX', 21.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/a3c0bb3be38ccf510ecaedb81f5bcd9f.png', NULL, NULL, 0,
        '{\"产地\":\"广西\",\"特性\":\"有机种植\"}'),
       (477, 4028016, 'SN3987204-R5', 49.00, 200, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"颜色\": \"红色\", \"数量\": \"5只\"}'),
       (478, 4028016, 'SN3987204-R10', 98.00, 200, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"颜色\": \"红色\", \"数量\": \"10只\"}'),
       (479, 4028016, 'SN3987204-B5', 49.00, 200, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"颜色\": \"蓝色\", \"数量\": \"5只\"}'),
       (480, 4028016, 'SN3987204-B10', 98.00, 200, 10,
        'https://yanxuan-item.nosdn.127.net/16222847be7d090eb538a944a7e0b01b.jpg', NULL, NULL, 0,
        '{\"颜色\": \"蓝色\", \"数量\": \"10只\"}'),
       (481, 4028017, 'SN3991840-60mini', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', NULL, NULL, 0,
        '{\"规格\": \"60贴\", \"类型\": \"mini型\"}'),
       (482, 4028017, 'SN3991840-120mini', 139.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', NULL, NULL, 0,
        '{\"规格\": \"120贴\", \"类型\": \"mini型\"}'),
       (483, 4028017, 'SN3991840-60std', 79.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', NULL, NULL, 0,
        '{\"规格\": \"60贴\", \"类型\": \"标准型\"}'),
       (484, 4028017, 'SN3991840-120std', 139.00, 100, 10,
        'https://yanxuan-item.nosdn.127.net/d3807695c7d42a0247e308a936201d7c.jpg', NULL, NULL, 0,
        '{\"规格\": \"120贴\", \"类型\": \"标准型\"}'),
       (485, 4028018, 'SN1270008-SH1', 9.90, 500, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"产地\": \"山东\", \"包装\": \"单袋\"}'),
       (486, 4028018, 'SN1270008-SH3', 28.00, 500, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"产地\": \"山东\", \"包装\": \"3袋装\"}'),
       (487, 4028018, 'SN1270008-JX1', 9.90, 500, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"产地\": \"江西\", \"包装\": \"单袋\"}'),
       (488, 4028018, 'SN1270008-JX3', 28.00, 500, 10,
        'https://yanxuan-item.nosdn.127.net/5f62c7ab543b1152383a0e9941c09bfd.png', NULL, NULL, 0,
        '{\"产地\": \"江西\", \"包装\": \"3袋装\"}'),
       (489, 4028015, '4028015-01', 49.00, 100, 10, NULL, NULL, NULL, 0,
        '{\"温度档位\":\"三档调节\",\"适用部位\":\"全身\"}'),
       (490, 4028015, '4028015-02', 49.00, 100, 10, NULL, NULL, NULL, 0,
        '{\"温度档位\":\"三档调节\",\"适用部位\":\"艾草包套装\"}'),
       (491, 4028015, '4028015-01', 49.00, 100, 10, NULL, NULL, NULL, 0,
        '{\"温度档位\":\"五档调节\",\"适用部位\":\"全身\"}'),
       (492, 4028015, '4028015-02', 49.00, 80, 10, NULL, NULL, NULL, 0,
        '{\"温度档位\":\"五档调节\",\"配件\":\"艾草包套装\"}'),
       (493, 4028019, '4028019-01', 19.00, 500, 50, NULL, NULL, NULL, 0,
        '{\"包装规格\":\"600g/袋\",\"储存方式\":\"阴凉干燥\"}'),
       (494, 4028027, '4028027-01', 35.00, 200, 20, NULL, NULL, NULL, 0, '{\"颜色\":\"珊瑚粉\",\"容量\":\"1500ml\"}'),
       (495, 4028027, '4028027-02', 35.00, 200, 20, NULL, NULL, NULL, 0, '{\"颜色\":\"薄荷绿\",\"容量\":\"1500ml\"}'),
       (496, 4028027, '4028027-03', 35.00, 150, 15, NULL, NULL, NULL, 0, '{\"颜色\":\"星空蓝\",\"容量\":\"1500ml\"}'),
       (497, 4028029, '4028029-01', 79.00, 300, 30, NULL, NULL, NULL, 0,
        '{\"规格\":\"60贴/盒\",\"功效\":\"消炎镇痛\"}'),
       (498, 4028030, '4028030-01', 109.00, 150, 15, NULL, NULL, NULL, 0,
        '{\"显示方式\":\"LED背光\",\"记忆组数\":\"99组\"}'),
       (499, 4028030, '4028030-02', 129.00, 100, 10, NULL, NULL, NULL, 0,
        '{\"显示方式\":\"彩屏触控\",\"记忆组数\":\"99组\"}'),
       (500, 4028032, '4028032-01', 9.90, 400, 40, NULL, NULL, NULL, 0, '{\"净含量\":\"500g\",\"保质期\":\"12个月\"}'),
       (501, 4028051, '4028051-01', 7.90, 600, 60, NULL, NULL, NULL, 0, '{\"规格\":\"40片/包\",\"材质\":\"无纺布\"}'),
       (502, 4028052, '4028052-01', 9.90, 300, 30, NULL, NULL, NULL, 0, '{\"容量\":\"11L\",\"颜色\":\"象牙白\"}'),
       (503, 4028052, '4028052-02', 9.90, 200, 20, NULL, NULL, NULL, 0, '{\"容量\":\"11L\",\"颜色\":\"高级灰\"}');
/*!40000 ALTER TABLE `pms_sku_stock`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_home_advertise`
--

DROP TABLE IF EXISTS `sms_home_advertise`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_home_advertise`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '录播图名称',
    `type`        int      DEFAULT NULL COMMENT '轮播位置：0->PC首页轮播；1->app首页轮播',
    `pic`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '图片地址',
    `start_time`  datetime DEFAULT NULL COMMENT '开始时间',
    `end_time`    datetime DEFAULT NULL COMMENT '结束时间',
    `status`      int      DEFAULT NULL COMMENT '上下线状态：0->下线；1->上线',
    `click_count` int      DEFAULT NULL COMMENT '点击数',
    `order_count` int      DEFAULT NULL COMMENT '下单数',
    `url`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '链接地址',
    `note`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注',
    `sort`        int      DEFAULT '0' COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='首页轮播广告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_home_advertise`
--

LOCK TABLES `sms_home_advertise` WRITE;
/*!40000 ALTER TABLE `sms_home_advertise`
    DISABLE KEYS */;
INSERT INTO `sms_home_advertise`
VALUES (9, '电影推荐广告', 1, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20181113/movie_ad.jpg',
        '2018-11-01 00:00:00', '2018-11-24 00:00:00', 1, 0, 0, 'www.baidu.com', '电影推荐广告', 100),
       (10, '汽车促销广告', 1, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20181113/car_ad.jpg',
        '2018-11-13 00:00:00', '2018-11-24 00:00:00', 1, 0, 0, 'xxx', NULL, 99),
       (11, '汽车推荐广告', 1, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20181113/car_ad2.jpg',
        '2018-11-13 00:00:00', '2018-11-30 00:00:00', 1, 0, 0, 'xxx', NULL, 98),
       (12, '小米13上市', 0, 'http://localhost:8080/minio/image/c55966069106463f8ea5896ebea685e1.jpg',
        '2022-12-15 00:00:00', '2022-12-30 00:00:00', 1, 0, 0, 'https://item.jd.com/100049486745.html', '小米13上市',
        500),
       (13, '小米Redmi K50', 0, 'http://localhost:8080/minio/image/a09910c8e5bc4bb998db502993405720.jpg',
        '2022-12-12 00:00:00', '2022-12-19 00:00:00', 1, 0, 0,
        'https://item.jd.com/100035246702.html?extension_id=eyJhZCI6IjM1MDQiLCJjaCI6IjIiLCJza3UiOiIxMDAwMzUyNDY3MDIiLCJ0cyI6IjE2NzEwNjU3NzYiLCJ1bmlxaWQiOiJ7XCJjbGlja19pZFwiOlwiZDQ0MDVlMjAtYjc5OS00NjczLThkY2MtZDEwMzQ3MjQ1MGY1XCIsXCJtYXRlcmlhbF9pZFwiOlwiNjYyNDE4NTAyOVwiLFwicG9zX2lkXCI6XCIzNTA0XCIsXCJzaWRcIjpcImM1NGFiNjI3LWFkYTItNGVkNS1iMDQ3LTdkY2U5MWQzZTRmOVwifSJ9&jd_pop=d4405e20-b799-4673-8dcc-d103472450f5&abt=0',
        '性价比超神', 200),
       (14, 'HUAWEI Mate 50 直屏旗舰', 0, 'http://localhost:8000/minio/image/72600af6bb3c4b46a6c7e039a3a1fd12.jpg',
        '2023-02-13 16:00:00', '2023-02-18 16:00:00', 1, 0, 0,
        'https://item.jd.com/100035295081.html?extension_id=eyJhZCI6IjM1MDMiLCJjaCI6IjIiLCJza3UiOiIxMDAwMzUyOTUwODEiLCJ0cyI6IjE2NzYzMzkwMDEiLCJ1bmlxaWQiOiJ7XCJjbGlja19pZFwiOlwiNTBlNWQyNjctNzZkYS00Nzg4LWI0MWQtNmM1NWU0MDgxYzNlXCIsXCJtYXRlcmlhbF9pZFwiOlwiOTQ3MjY5NTI0NlwiLFwicG9zX2lkXCI6XCIzNTAzXCIsXCJzaWRcIjpcImQwMzVmNWY1LTA1ZWEtNDc3Ny1hMTY1LWZmN2FmZmJjZTQ3YVwifSJ9&jd_pop=50e5d267-76da-4788-b41d-6c55e4081c3e&abt=0',
        '没有备注', 0),
       (15, '京挑惠选2', 0, 'http://localhost:8000/minio/image/8f62e4362c8d4afd9d3f0be76bfadde2.jpg',
        '2023-02-15 00:00:00', '2023-02-20 00:00:00', 1, 0, 0,
        'https://pro.jd.com/mall/active/3ZYfZKGRAhbHzJySpRriJoGWo8v6/index.html?innerAnchor=100012043978&focus=3',
        '京挑惠选2', 0);
/*!40000 ALTER TABLE `sms_home_advertise`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_home_brand`
--

DROP TABLE IF EXISTS `sms_home_brand`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_home_brand`
(
    `id`               int NOT NULL AUTO_INCREMENT,
    `brand_id`         int                                                          DEFAULT NULL COMMENT '品牌id',
    `brand_name`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品牌名称',
    `recommend_status` int                                                          DEFAULT NULL COMMENT '推荐状态 0->不推荐，1->推荐',
    `sort`             int                                                          DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 45
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='首页推荐品牌表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_home_brand`
--

LOCK TABLES `sms_home_brand` WRITE;
/*!40000 ALTER TABLE `sms_home_brand`
    DISABLE KEYS */;
INSERT INTO `sms_home_brand`
VALUES (1, 1, '万和', 1, 200),
       (6, 6, '小米', 1, 300),
       (8, 5, '方太', 1, 100),
       (33, 51, '苹果', 1, 10),
       (34, 2, '三星', 1, 0),
       (35, 3, '华为', 1, 500),
       (40, 49, '七匹狼', 1, 0),
       (41, 21, 'OPPO', 1, 0),
       (42, 58, 'NIKE', 1, NULL),
       (43, 59, '伊利', 1, 1),
       (44, 61, '雪中飞', 1, 1);
/*!40000 ALTER TABLE `sms_home_brand`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_home_new_product`
--

DROP TABLE IF EXISTS `sms_home_new_product`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_home_new_product`
(
    `id`               int NOT NULL AUTO_INCREMENT,
    `product_id`       int                                                          DEFAULT NULL COMMENT '商品id',
    `product_name`     varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
    `recommend_status` int                                                          DEFAULT NULL COMMENT '推荐状态 0->不推荐，1->推荐',
    `sort`             int                                                          DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 19
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='新鲜好物表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_home_new_product`
--

LOCK TABLES `sms_home_new_product` WRITE;
/*!40000 ALTER TABLE `sms_home_new_product`
    DISABLE KEYS */;
INSERT INTO `sms_home_new_product`
VALUES (2, 27, '小米8 全面屏游戏智能手机 6GB+64GB 黑色 全网通4G 双卡双待', 1, 200),
       (8, 26, '华为 HUAWEI P20 ', 1, 0),
       (12, 30, 'HLA海澜之家简约动物印花短袖T恤', 1, 10),
       (13, 36, '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', 1, 0),
       (14, 37, 'HUAWEI P50', 1, 300),
       (16, 34, '小米（MI）小米电视4A 65英寸', 1, 100),
       (17, 38, '华为HUAWEI Mate 50', 1, 50),
       (18, 39, '小米14', 1, 0);
/*!40000 ALTER TABLE `sms_home_new_product`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_home_recommend_product`
--

DROP TABLE IF EXISTS `sms_home_recommend_product`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_home_recommend_product`
(
    `id`               int NOT NULL AUTO_INCREMENT,
    `product_id`       int                                                          DEFAULT NULL COMMENT '商品id',
    `product_name`     varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
    `recommend_status` int                                                          DEFAULT NULL COMMENT '推荐状态 0->不推荐，1->推荐',
    `sort`             int                                                          DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 15
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='人气推荐商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_home_recommend_product`
--

LOCK TABLES `sms_home_recommend_product` WRITE;
/*!40000 ALTER TABLE `sms_home_recommend_product`
    DISABLE KEYS */;
INSERT INTO `sms_home_recommend_product`
VALUES (3, 26, '华为 HUAWEI P20 ', 1, 0),
       (7, 30, 'HLA海澜之家简约动物印花短袖T恤', 1, 100),
       (8, 33, '小米（MI）小米电视4A ', 1, 300),
       (9, 34, '小米（MI）小米电视4A 65英寸', 1, 0),
       (10, 37, 'HUAWEI P50', 1, 200),
       (12, 38, '华为HUAWEI Mate 50', 1, 30),
       (13, 31, 'HLA海澜之家蓝灰花纹圆领针织布短袖T恤', 1, 20),
       (14, 32, 'HLA海澜之家短袖T恤男基础款', 1, 10);
/*!40000 ALTER TABLE `sms_home_recommend_product`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_admin`
--

DROP TABLE IF EXISTS `ums_admin`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_admin`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `username`    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
    `password`    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
    `icon`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '头像',
    `email`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '邮箱',
    `nick_name`   text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '昵称',
    `note`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注信息',
    `create_time` datetime                                                     DEFAULT NULL COMMENT '创建时间',
    `login_time`  datetime                                                     DEFAULT NULL COMMENT '最后登录时间',
    `status`      int                                                          DEFAULT '1' COMMENT '帐号启用状态：0->禁用；1->启用',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_username` (`username`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_admin`
--

LOCK TABLES `ums_admin` WRITE;
/*!40000 ALTER TABLE `ums_admin`
    DISABLE KEYS */;
INSERT INTO `ums_admin`
VALUES (3, 'admin', '$2a$10$ZJRkT8EaVHoLMMx7Sc3w2OmOD90ddimwiVYpLJHCTAJJ0oj/bQx8i',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', 'admin@163.com', '系统管理员',
        '系统管理员', '2018-10-08 13:32:47', '2024-03-01 11:50:34', 1),
       (4, 'macro', '$2a$10$ZJRkT8EaVHoLMMx7Sc3w2OmOD90ddimwiVYpLJHCTAJJ0oj/bQx8i', 'string', 'macro@qq.com', 'macro',
        'macro专用', '2019-10-06 15:53:51', '2020-02-03 14:55:55', 1),
       (6, 'productAdmin', '$2a$10$ZJRkT8EaVHoLMMx7Sc3w2OmOD90ddimwiVYpLJHCTAJJ0oj/bQx8i', NULL, 'product@qq.com',
        '商品管理员', '只有商品权限', '2020-02-07 16:15:08', '2023-11-19 19:50:01', 1),
       (7, 'orderAdmin', '$2a$10$ZJRkT8EaVHoLMMx7Sc3w2OmOD90ddimwiVYpLJHCTAJJ0oj/bQx8i', NULL, 'order@qq.com',
        '订单管理员', '只有订单管理权限', '2020-02-07 16:15:50', '2024-01-26 09:54:45', 1),
       (8, 'cluoAdmin', '$2a$10$slyWif1.HCM7Rb7g5SjnN.oUyw6HLM14UUhkg2cShtC7Yo9McpRcq', NULL, '178009922@163.com',
        'C罗', 'xx模块管理员', NULL, '2023-02-07 10:19:24', 1),
       (9, 'meixiAdmin', '$2a$10$/4t6iKt5E3aRfsQXjuwbXO7kasjc/Ztcm8kkft4SmPxgJD/oA87Iu', NULL, 'meixi1@qq.com', '梅西',
        'xx模块管理员1', '2022-11-29 09:22:16', '2022-11-29 11:27:23', 0),
       (10, 'admin_curry', '$2a$10$sfqJTHitMDEu9YPU3n4sC.fs5XOyKDC7djoYed9F9.PZeuX.eFLHm', 'default.jpg',
        '101010@qq.com', '你的小酷酷', '不是饮水机管理员', '2023-02-03 11:21:30', '2023-02-06 16:11:39', 1),
       (13, 'admin666', '$2a$10$Pl9jHt0pkny8rRJjsqwCQukqjemypZybi0FVDJMj9UxqUeD2Jc61y', 'http://example.com/avatar.jpg',
        'admin001@example.com', 'Admin001', '系统管理员账号', '2025-05-05 13:55:55', '2025-05-27 00:11:52', 1),
       (14, 'admin111', '$2a$10$fA9inKBABdYPijRzq7zhtuILyS1JgiINTcOl7rvpUyYNnPlH9df0a', NULL, NULL, NULL, NULL,
        '2025-04-26 21:39:38', '2025-04-26 23:10:47', 1);
/*!40000 ALTER TABLE `ums_admin`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_admin_role_relation`
--

DROP TABLE IF EXISTS `ums_admin_role_relation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_admin_role_relation`
(
    `id`       int NOT NULL AUTO_INCREMENT,
    `admin_id` int DEFAULT NULL COMMENT '管理员id',
    `role_id`  int DEFAULT '5' COMMENT '角色id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 46
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台用户和角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_admin_role_relation`
--

LOCK TABLES `ums_admin_role_relation` WRITE;
/*!40000 ALTER TABLE `ums_admin_role_relation`
    DISABLE KEYS */;
INSERT INTO `ums_admin_role_relation`
VALUES (26, 3, 5),
       (27, 6, 1),
       (28, 7, 2),
       (29, 1, 5),
       (30, 4, 5),
       (31, 1, 2),
       (32, 1, 1),
       (35, 8, 1),
       (36, 8, 2),
       (41, 9, 7),
       (45, 13, 5);
/*!40000 ALTER TABLE `ums_admin_role_relation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_member`
--

DROP TABLE IF EXISTS `ums_member`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_member`
(
    `id`                     int NOT NULL AUTO_INCREMENT,
    `member_level_id`        int                                                          DEFAULT '4' COMMENT '会员等级ID',
    `username`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
    `password`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
    `nickname`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '昵称',
    `phone`                  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号码',
    `status`                 int                                                          DEFAULT '1' COMMENT '帐号启用状态:0->禁用；1->启用',
    `create_time`            datetime                                                     DEFAULT NULL COMMENT '注册时间',
    `icon`                   text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '头像',
    `gender`                 int                                                          DEFAULT '0' COMMENT '性别：0->未知；1->男；2->女',
    `personalized_signature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '个性签名',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `idx_username` (`username`) USING BTREE,
    UNIQUE KEY `idx_phone` (`phone`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 30
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_member`
--

LOCK TABLES `ums_member` WRITE;
/*!40000 ALTER TABLE `ums_member`
    DISABLE KEYS */;
INSERT INTO `ums_member`
VALUES (1, 4, 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'windir', '18061581849', 1,
        '2018-08-02 10:35:44', 'http://localhost:9000/images/avatar/default.jpg', 1, 'test'),
       (3, 4, 'windy', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'windy', '18061581848', 1,
        '2018-08-03 16:46:38', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (4, 4, 'zhengsan', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'zhengsan', '18061581847', 1,
        '2018-11-12 14:12:04', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (5, 4, 'lisi', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'lisi', '18061581841', 1,
        '2018-11-12 14:12:38', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (6, 4, 'wangwu', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'wangwu', '18061581842', 1,
        '2018-11-12 14:13:09', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (7, 4, 'lion', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'lion', '18061581845', 1,
        '2018-11-12 14:21:39', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (8, 4, 'shari', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'shari', '18061581844', 1,
        '2018-11-12 14:22:00', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (9, 4, 'aewen', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'aewen', '18061581843', 1,
        '2018-11-12 14:22:55', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (10, NULL, 'liye0101', '$2a$10$4826DQesSllZYmZ6hpNOjO0hyf6x3IQxaDyaycXyIaAl5tsxitzrm', '李野老师01',
        '13200001234', 1, '2024-03-27 14:59:57', 'http://localhost:9000/images/avatar/default.jpg', 1, NULL),
       (11, 4, 'xiaoerhei', '$2a$10$4Bqnpwf3sMGEed1Ue1//TOSeTbk1ECMRceenjLzL4QsH7.2UpvTHG', '小二黑', '13123456789', 1,
        '2024-04-18 12:20:48', 'http://localhost:9000/images/avatar/default.jpg', 2, '我是小二黑'),
       (12, 4, 'Member13812345678', '$2a$10$dpGg6Z.tf0/mqQbOZrRfUu64.i7oNTODLPYDnPImKGE6YtRpLCTW.', '会员13812345678',
        '13812345678', 1, '2024-04-18 12:28:05', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (13, 4, 'Member18612345678', '$2a$10$elzVpFYITk/imifgqcAX0O19ghmnXLJeB9jxsXIYeng7OlCrcG.t6', '会员18612345678',
        '18612345678', 1, '2024-04-18 13:41:32', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (14, 4, 'Member13200001111', '$2a$10$AJxF0DZXZwIwlT8.L4eR7.aDMVerq9nAdbEWuT70snCS9IuXCAkZa', '会员13200001111',
        '13200001111', 1, '2024-04-18 14:12:55', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (17, NULL, NULL, '$2a$10$NFc37AtRPtQ.34i4We7PJOVqRz0i7/nDYXi2zZUGTM9aPuI0bar5W', NULL, 'user001', NULL,
        '2025-04-27 16:37:27', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (19, NULL, NULL, '$2a$10$MOuexUQnZpSS9nIbNAEqVOTvmQf2nz1QLEmSiy6m94UcGzmfoMWP6', NULL, 'user002', NULL,
        '2025-04-27 16:44:43', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (20, NULL, 'user003', '$2a$10$I.BlSyK5DliNKyIOv3RaRO0tgC9ZmonyyIDz69iOw7aU3x/Sat6u.', NULL, NULL, NULL,
        '2025-04-27 16:49:06', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (21, NULL, 'user004', '$2a$10$/Ctt1oiOy3NFzYKygF7TUON4GAk4rNdXptFy6WVZ20QabYy7habTa', NULL, NULL, NULL,
        '2025-04-27 16:51:32', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (22, NULL, 'user005', '$2a$10$8reiHgvbz7TzKlNahj4uZ.z5uAp4PYWK6h.HZ6lbS9iFIygTeqK72', NULL, NULL, NULL,
        '2025-04-27 18:06:36', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (23, 4, 'user006', '$2a$10$deA4nBNdvR2MsHfwQ4Skr.kzpliPRMPnQZSbM1SOx22Cu9CgYEIzi', NULL, NULL, 1,
        '2025-04-30 20:06:00', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (24, 4, 'user007', '$2a$10$/wiz9tEoAH07BK6I8L99/.0kLTyo9W.mhzEHI/HX55KDP3XmZ1/uK', NULL, NULL, 1,
        '2025-04-30 20:15:48', 'http://localhost:9000/images/avatar/default.jpg', NULL, NULL),
       (25, 4, 'user008', '$2a$10$Dn1h4hj8LPBYLlZyrD7DE.tdLFVXLlUqiiaaKbzsNmNh/eY0CJNRm', NULL, NULL, 1,
        '2025-04-30 20:48:52', 'http://localhost:9000/images/avatar/default.jpg', 0, NULL),
       (26, 4, 'user010', '$2a$10$OBd/rigwi3v6vafaybOG4OXjsAQ7s02WrorBE7u5NTNvkntjYhdTi', NULL, '15322225698', 1,
        '2025-06-01 13:50:17', 'http://localhost:9000/images/avatar/default.jpg', 1, NULL),
       (27, 4, 'user011', '$2a$10$ngz5gUxMkCgzJAOIHwDV0Ooh82fmFIcl0exCvQMKN0.vAX2inYG2m', NULL, '15236665854', 1,
        '2025-06-01 17:05:53', 'http://localhost:9000/images/avatar/default.jpg', 1, NULL),
       (28, 4, 'user012', '$2a$10$m90G767HOksx1oVhNhp9Ru9/Ga2zD3eNPITt9DWffrz8mZfrd5tha', NULL, '15266663288', 1,
        '2025-06-01 17:09:23', 'http://localhost:9000/images/avatar/default.jpg', 1, NULL),
       (29, 4, 'user013', '$2a$10$aMI4KUD1Iqx.hG8KkXo4/enjrGDzlwLAX0bZhCPM6tqkQYEUXtvPi', NULL, '13223334567', 1,
        '2025-06-01 17:57:31', 'http://localhost:9000/images/avatar/default.jpg', 1, NULL);
/*!40000 ALTER TABLE `ums_member`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_member_level`
--

DROP TABLE IF EXISTS `ums_member_level`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_member_level`
(
    `id`                      int NOT NULL AUTO_INCREMENT,
    `name`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '等级名称',
    `growth_point`            int            DEFAULT NULL COMMENT '成长值阈值，例如：>5000',
    `default_status`          int            DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
    `free_freight_point`      decimal(10, 2) DEFAULT NULL COMMENT '免运费标准',
    `comment_growth_point`    int            DEFAULT NULL COMMENT '每次评价获取的成长值',
    `priviledge_free_freight` int            DEFAULT NULL COMMENT '是否有免邮特权',
    `priviledge_sign_in`      int            DEFAULT NULL COMMENT '是否有签到特权',
    `priviledge_comment`      int            DEFAULT NULL COMMENT '是否有评论获奖励特权',
    `priviledge_promotion`    int            DEFAULT NULL COMMENT '是否有专享活动特权',
    `priviledge_member_price` int            DEFAULT NULL COMMENT '是否有会员价格特权',
    `priviledge_birthday`     int            DEFAULT NULL COMMENT '是否有生日特权',
    `note`                    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='会员等级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_member_level`
--

LOCK TABLES `ums_member_level` WRITE;
/*!40000 ALTER TABLE `ums_member_level`
    DISABLE KEYS */;
INSERT INTO `ums_member_level`
VALUES (1, '黄金会员', 1000, 0, 199.00, 5, 1, 1, 1, 1, 1, 1, NULL),
       (2, '白金会员', 5000, 0, 99.00, 10, 1, 1, 1, 1, 1, 1, NULL),
       (3, '钻石会员', 15000, 0, 69.00, 15, 1, 1, 1, 1, 1, 1, NULL),
       (4, '普通会员', 1, 1, 199.00, 20, 1, 1, 1, 1, 0, 0, NULL);
/*!40000 ALTER TABLE `ums_member_level`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_member_receive_address`
--

DROP TABLE IF EXISTS `ums_member_receive_address`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_member_receive_address`
(
    `id`             int NOT NULL AUTO_INCREMENT,
    `member_id`      int                                                           DEFAULT NULL COMMENT '会员id',
    `name`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '收货人名称',
    `phone_number`   varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  DEFAULT NULL COMMENT '收货人电话',
    `default_status` int                                                           DEFAULT NULL COMMENT '是否为默认',
    `post_code`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '邮政编码',
    `province`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '省份/直辖市',
    `city`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '城市',
    `region`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '区',
    `detail_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '详细地址(街道)',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='会员收货地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_member_receive_address`
--

LOCK TABLES `ums_member_receive_address` WRITE;
/*!40000 ALTER TABLE `ums_member_receive_address`
    DISABLE KEYS */;
INSERT INTO `ums_member_receive_address`
VALUES (1, 1, '大梨', '18033441849', 0, '518000', '广东省', '深圳市', '南山区', '科兴科学园'),
       (3, 1, '大梨', '18033441849', 0, '518000', '广东省', '深圳市', '福田区', '清水河街道'),
       (4, 1, '大梨', '18033441849', 1, '518000', '广东省', '深圳市', '福田区', '东晓街道'),
       (5, 10, '111', '13200001234', 0, '150080', '黑龙江省', '哈尔滨', '南岗区', '中兴大道哈学院2号楼'),
       (6, 10, '111', '13200001234', 1, '150080', '黑龙江省', '哈尔滨', '南岗区', '学府路xx小区2号楼'),
       (7, 10, '111', '13200007890', 0, '150604', '北京', '北京市', '海淀区', 'xx路xx小区2号楼'),
       (8, 25, 'user008', '13200001234', 0, '150604', '上海', '上海市', '浦东新区', '秀沿路1254号1'),
       (11, 25, '六六', '15322224122', 0, '151107', '黑龙江', '哈尔滨市', '南岗区', '11'),
       (12, 28, '六六', '15326664236', 0, '151107', '黑龙江', '哈尔滨市', '南岗区',
        '黑龙江省哈尔滨市学府路74号黑龙江大学');
/*!40000 ALTER TABLE `ums_member_receive_address`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_menu`
--

DROP TABLE IF EXISTS `ums_menu`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_menu`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `parent_id`   int      DEFAULT NULL COMMENT '父级ID',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `title`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '菜单名称',
    `level`       int      DEFAULT NULL COMMENT '菜单级数',
    `sort`        int      DEFAULT NULL COMMENT '菜单排序',
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '前端名称',
    `icon`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '前端图标',
    `hidden`      int      DEFAULT NULL COMMENT '前端隐藏',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 32
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_menu`
--

LOCK TABLES `ums_menu` WRITE;
/*!40000 ALTER TABLE `ums_menu`
    DISABLE KEYS */;
INSERT INTO `ums_menu`
VALUES (1, 0, '2020-02-02 14:50:36', '商品', 0, 0, 'pms', 'product', 0),
       (2, 1, '2020-02-02 14:51:50', '商品列表', 1, 0, 'product', 'product-list', 0),
       (3, 1, '2020-02-02 14:52:44', '添加商品', 1, 0, 'addProduct', 'product-add', 0),
       (4, 1, '2020-02-02 14:53:51', '商品分类', 1, 0, 'productCate', 'product-cate', 0),
       (5, 1, '2020-02-02 14:54:51', '商品类型', 1, 0, 'productAttr', 'product-attr', 0),
       (6, 1, '2020-02-02 14:56:29', '品牌管理', 1, 0, 'brand', 'product-brand', 0),
       (7, 0, '2020-02-02 16:54:07', '订单', 0, 0, 'oms', 'order', 0),
       (8, 7, '2020-02-02 16:55:18', '订单列表', 1, 0, 'order', 'product-list', 0),
       (9, 7, '2020-02-02 16:56:46', '订单设置', 1, 0, 'orderSetting', 'order-setting', 0),
       (10, 7, '2020-02-02 16:57:39', '退货申请处理', 1, 0, 'returnApply', 'order-return', 0),
       (11, 7, '2020-02-02 16:59:40', '退货原因设置', 1, 0, 'returnReason', 'order-return-reason', 0),
       (12, 0, '2020-02-04 16:18:00', '营销', 0, 0, 'sms', 'sms', 0),
       (13, 12, '2020-02-04 16:19:22', '秒杀活动列表', 1, 0, 'flash', 'sms-flash', 0),
       (14, 12, '2020-02-04 16:20:16', '优惠券列表', 1, 0, 'coupon', 'sms-coupon', 0),
       (16, 12, '2020-02-07 16:22:38', '品牌推荐', 1, 0, 'homeBrand', 'product-brand', 0),
       (17, 12, '2020-02-07 16:23:14', '新品推荐', 1, 0, 'homeNew', 'sms-new', 0),
       (18, 12, '2020-02-07 16:26:38', '人气推荐', 1, 0, 'homeHot', 'sms-hot', 0),
       (19, 12, '2020-02-07 16:28:16', '专题推荐', 1, 0, 'homeSubject', 'sms-subject', 0),
       (20, 12, '2020-02-07 16:28:42', '广告列表', 1, 0, 'homeAdvertise', 'sms-ad', 0),
       (21, 0, '2020-02-07 16:29:13', '权限', 0, 0, 'ums', 'ums', 0),
       (22, 21, '2020-02-07 16:29:51', '用户列表', 1, 0, 'admin', 'ums-admin', 0),
       (23, 21, '2020-02-07 16:30:13', '角色列表', 1, 0, 'role', 'ums-role', 0),
       (24, 21, '2020-02-07 16:30:53', '菜单列表', 1, 0, 'menu', 'ums-menu', 0),
       (25, 21, '2020-02-07 16:31:13', '资源列表', 1, 0, 'resource', 'ums-resource', 0),
       (28, 0, '2022-11-30 09:34:52', '商家服务', 0, 0, 'bms', 'ums', 1),
       (29, 28, '2022-11-30 09:35:39', '合作招商', 1, 0, 'bms-hzzs', 'ums', 0),
       (30, 28, '2024-01-29 14:18:19', '合作招商2', 2, 0, '合作招商2', 'ums', 0),
       (31, 28, '2024-01-29 14:19:27', '合作招商3', 0, 0, '合作招商3', 'ums', 0);
/*!40000 ALTER TABLE `ums_menu`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_permission`
--

DROP TABLE IF EXISTS `ums_permission`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_permission`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `pid`         int      DEFAULT NULL COMMENT '父级权限id',
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '名称',
    `value`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '权限值',
    `icon`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '图标',
    `type`        int      DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
    `uri`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '前端资源路径',
    `status`      int      DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `sort`        int      DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 19
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台用户权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_permission`
--

LOCK TABLES `ums_permission` WRITE;
/*!40000 ALTER TABLE `ums_permission`
    DISABLE KEYS */;
INSERT INTO `ums_permission`
VALUES (1, 0, '商品', NULL, NULL, 0, NULL, 1, '2018-09-29 16:15:14', 0),
       (2, 1, '商品列表', 'pms:product:read', NULL, 1, '/pms/product/index', 1, '2018-09-29 16:17:01', 0),
       (3, 1, '添加商品', 'pms:product:create', NULL, 1, '/pms/product/add', 1, '2018-09-29 16:18:51', 0),
       (4, 1, '商品分类', 'pms:productCategory:read', NULL, 1, '/pms/productCate/index', 1, '2018-09-29 16:23:07', 0),
       (5, 1, '商品类型', 'pms:productAttribute:read', NULL, 1, '/pms/productAttr/index', 1, '2018-09-29 16:24:43', 0),
       (6, 1, '品牌管理', 'pms:brand:read', NULL, 1, '/pms/brand/index', 1, '2018-09-29 16:25:45', 0),
       (7, 2, '编辑商品', 'pms:product:update', NULL, 2, '/pms/product/updateProduct', 1, '2018-09-29 16:34:23', 0),
       (8, 2, '删除商品', 'pms:product:delete', NULL, 2, '/pms/product/delete', 1, '2018-09-29 16:38:33', 0),
       (9, 4, '添加商品分类', 'pms:productCategory:create', NULL, 2, '/pms/productCate/create', 1,
        '2018-09-29 16:43:23', 0),
       (10, 4, '修改商品分类', 'pms:productCategory:update', NULL, 2, '/pms/productCate/update', 1,
        '2018-09-29 16:43:55', 0),
       (11, 4, '删除商品分类', 'pms:productCategory:delete', NULL, 2, '/pms/productAttr/delete', 1,
        '2018-09-29 16:44:38', 0),
       (12, 5, '添加商品类型', 'pms:productAttribute:create', NULL, 2, '/pms/productAttr/create', 1,
        '2018-09-29 16:45:25', 0),
       (13, 5, '修改商品类型', 'pms:productAttribute:update', NULL, 2, '/pms/productAttr/update', 1,
        '2018-09-29 16:48:08', 0),
       (14, 5, '删除商品类型', 'pms:productAttribute:delete', NULL, 2, '/pms/productAttr/delete', 1,
        '2018-09-29 16:48:44', 0),
       (15, 6, '添加品牌', 'pms:brand:create', NULL, 2, '/pms/brand/add', 1, '2018-09-29 16:49:34', 0),
       (16, 6, '修改品牌', 'pms:brand:update', NULL, 2, '/pms/brand/update', 1, '2018-09-29 16:50:55', 0),
       (17, 6, '删除品牌', 'pms:brand:delete', NULL, 2, '/pms/brand/delete', 1, '2018-09-29 16:50:59', 0),
       (18, 0, '首页', NULL, NULL, 0, NULL, 1, '2018-09-29 16:51:57', 0);
/*!40000 ALTER TABLE `ums_permission`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_resource`
--

DROP TABLE IF EXISTS `ums_resource`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_resource`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '资源名称',
    `url`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '资源URL',
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `category_id` int      DEFAULT NULL COMMENT '资源分类ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 35
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_resource`
--

LOCK TABLES `ums_resource` WRITE;
/*!40000 ALTER TABLE `ums_resource`
    DISABLE KEYS */;
INSERT INTO `ums_resource`
VALUES (1, '2020-02-04 17:04:55', '商品品牌管理', '/brand/**', NULL, 1),
       (2, '2020-02-04 17:05:35', '商品属性分类管理', '/productAttribute/**', NULL, 1),
       (3, '2020-02-04 17:06:13', '商品属性管理', '/productAttribute/**', NULL, 1),
       (4, '2020-02-04 17:07:15', '商品分类管理', '/productCategory/**', NULL, 1),
       (5, '2020-02-04 17:09:16', '商品管理', '/product/**', NULL, 1),
       (6, '2020-02-04 17:09:53', '商品库存管理', '/sku/**', NULL, 1),
       (8, '2020-02-05 14:43:37', '订单管理', '/order/**', '', 2),
       (9, '2020-02-05 14:44:22', ' 订单退货申请管理', '/returnApply/**', '', 2),
       (10, '2020-02-05 14:45:08', '退货原因管理', '/returnReason/**', '', 2),
       (11, '2020-02-05 14:45:43', '订单设置管理', '/orderSetting/**', '', 2),
       (12, '2020-02-05 14:46:23', '收货地址管理', '/companyAddress/**', '', 2),
       (13, '2020-02-07 16:37:22', '优惠券管理', '/coupon/**', '', 3),
       (14, '2020-02-07 16:37:59', '优惠券领取记录管理', '/couponHistory/**', '', 3),
       (15, '2020-02-07 16:38:28', '限时购活动管理', '/flash/**', '', 3),
       (16, '2020-02-07 16:38:59', '限时购商品关系管理', '/flashProductRelation/**', '', 3),
       (17, '2020-02-07 16:39:22', '限时购场次管理', '/flashSession/**', '', 3),
       (18, '2020-02-07 16:40:07', '首页轮播广告管理', '/home/advertise/**', '', 3),
       (19, '2020-02-07 16:40:34', '首页品牌管理', '/home/brand/**', '', 3),
       (20, '2020-02-07 16:41:06', '首页新品管理', '/home/newProduct/**', '', 3),
       (21, '2020-02-07 16:42:16', '首页人气推荐管理', '/home/recommendProduct/**', '', 3),
       (22, '2020-02-07 16:42:48', '首页专题推荐管理', '/home/recommendSubject/**', '', 3),
       (23, '2020-02-07 16:44:56', ' 商品优选管理', '/prefrenceArea/**', '', 5),
       (24, '2020-02-07 16:45:39', '商品专题管理', '/subject/**', '', 5),
       (25, '2020-02-07 16:47:34', '后台用户管理', '/admin/**', '', 4),
       (26, '2020-02-07 16:48:24', '后台用户角色管理', '/role/**', '', 4),
       (27, '2020-02-07 16:48:48', '后台菜单管理', '/menu/**', '', 4),
       (28, '2020-02-07 16:49:18', '后台资源分类管理', '/resourceCategory/**', '', 4),
       (29, '2020-02-07 16:49:45', '后台资源管理', '/resource/**', '', 4),
       (31, '2022-11-30 10:19:48', 'xyz测试资源_02', '/xyz2', '用于测试的资源22', 6),
       (32, '2023-02-08 16:42:14', '团购资源2', '/pms/tg2', '团购资源/团购资源2', 2),
       (33, NULL, '问我', '订单', '111', 1),
       (34, '2024-01-24 15:49:03', '22', '33', '44', 1);
/*!40000 ALTER TABLE `ums_resource`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_resource_category`
--

DROP TABLE IF EXISTS `ums_resource_category`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_resource_category`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '分类名称',
    `sort`        int      DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='资源分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_resource_category`
--

LOCK TABLES `ums_resource_category` WRITE;
/*!40000 ALTER TABLE `ums_resource_category`
    DISABLE KEYS */;
INSERT INTO `ums_resource_category`
VALUES (1, '2020-02-05 10:21:44', '商品模块', 0),
       (2, '2020-02-05 10:22:34', '订单模块', 0),
       (3, '2020-02-05 10:22:48', '营销模块', 0),
       (4, '2020-02-05 10:23:04', '权限模块', 0),
       (5, '2020-02-07 16:34:27', '内容模块', 0),
       (6, '2020-02-07 16:35:49', '其他模块', 0),
       (8, '2022-11-30 10:10:54', 'yy模块', 1);
/*!40000 ALTER TABLE `ums_resource_category`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_role`
--

DROP TABLE IF EXISTS `ums_role`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_role`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `name`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '名称',
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `admin_count` int      DEFAULT NULL COMMENT '后台用户数量',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `status`      int      DEFAULT '1' COMMENT '启用状态：0->禁用；1->启用',
    `sort`        int      DEFAULT '0' COMMENT '排序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 11
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_role`
--

LOCK TABLES `ums_role` WRITE;
/*!40000 ALTER TABLE `ums_role`
    DISABLE KEYS */;
INSERT INTO `ums_role`
VALUES (1, '商品管理员', '只能查看及操作商品', 0, '2020-02-03 16:50:37', 1, 0),
       (2, '订单管理员', '只能查看及操作订单', 0, '2018-09-30 15:53:45', 1, 0),
       (5, '超级管理员', '拥有所有查看和操作功能', 0, '2020-02-02 15:11:05', 1, 0),
       (7, '营销管理员', '负责处理营销相关业务', 0, '2022-11-29 10:57:53', 1, 0),
       (8, '市场管理员', '负责市场xx业务', 0, NULL, 1, 0),
       (9, 'AA管理员', '负责A业务', 0, NULL, 1, 0),
       (10, 'BB管理员', '负责B业务', 0, '2024-01-24 15:55:31', 1, 0);
/*!40000 ALTER TABLE `ums_role`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_role_menu_relation`
--

DROP TABLE IF EXISTS `ums_role_menu_relation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_role_menu_relation`
(
    `id`      int NOT NULL AUTO_INCREMENT,
    `role_id` int DEFAULT NULL COMMENT '角色ID',
    `menu_id` int DEFAULT NULL COMMENT '菜单ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 223
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台角色菜单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_role_menu_relation`
--

LOCK TABLES `ums_role_menu_relation` WRITE;
/*!40000 ALTER TABLE `ums_role_menu_relation`
    DISABLE KEYS */;
INSERT INTO `ums_role_menu_relation`
VALUES (33, 1, 1),
       (34, 1, 2),
       (35, 1, 3),
       (36, 1, 4),
       (37, 1, 5),
       (38, 1, 6),
       (53, 2, 7),
       (54, 2, 8),
       (55, 2, 9),
       (56, 2, 10),
       (57, 2, 11),
       (110, 7, 12),
       (111, 7, 13),
       (112, 7, 14),
       (113, 7, 16),
       (114, 7, 17),
       (115, 7, 18),
       (116, 7, 19),
       (117, 7, 20),
       (118, 8, 28),
       (119, 8, 29),
       (143, 5, 1),
       (144, 5, 2),
       (145, 5, 3),
       (146, 5, 4),
       (147, 5, 5),
       (148, 5, 6),
       (149, 5, 7),
       (150, 5, 8),
       (151, 5, 9),
       (152, 5, 10),
       (153, 5, 11),
       (154, 5, 12),
       (155, 5, 13),
       (156, 5, 14),
       (157, 5, 16),
       (158, 5, 17),
       (159, 5, 18),
       (160, 5, 19),
       (161, 5, 20),
       (162, 5, 21),
       (163, 5, 22),
       (164, 5, 23),
       (165, 5, 24),
       (166, 5, 25),
       (209, 10, 1),
       (210, 10, 2),
       (211, 10, 3),
       (212, 10, 4),
       (213, 10, 5),
       (214, 10, 6),
       (215, 10, 12),
       (216, 10, 13),
       (217, 10, 14),
       (218, 10, 16),
       (219, 10, 17),
       (220, 10, 18),
       (221, 10, 19),
       (222, 10, 20);
/*!40000 ALTER TABLE `ums_role_menu_relation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_role_permission_relation`
--

DROP TABLE IF EXISTS `ums_role_permission_relation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_role_permission_relation`
(
    `id`            int NOT NULL AUTO_INCREMENT,
    `role_id`       int DEFAULT NULL COMMENT '角色id',
    `permission_id` int DEFAULT NULL COMMENT '权限id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 18
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台用户角色和权限关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_role_permission_relation`
--

LOCK TABLES `ums_role_permission_relation` WRITE;
/*!40000 ALTER TABLE `ums_role_permission_relation`
    DISABLE KEYS */;
INSERT INTO `ums_role_permission_relation`
VALUES (1, 1, 1),
       (2, 1, 2),
       (3, 1, 3),
       (4, 1, 7),
       (5, 1, 8),
       (6, 2, 4),
       (7, 2, 9),
       (8, 2, 10),
       (9, 2, 11),
       (10, 3, 5),
       (11, 3, 12),
       (12, 3, 13),
       (13, 3, 14),
       (14, 4, 6),
       (15, 4, 15),
       (16, 4, 16),
       (17, 4, 17);
/*!40000 ALTER TABLE `ums_role_permission_relation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_role_resource_relation`
--

DROP TABLE IF EXISTS `ums_role_resource_relation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_role_resource_relation`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `role_id`     int DEFAULT NULL COMMENT '角色ID',
    `resource_id` int DEFAULT NULL COMMENT '资源ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 233
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPACT COMMENT ='后台角色资源关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_role_resource_relation`
--

LOCK TABLES `ums_role_resource_relation` WRITE;
/*!40000 ALTER TABLE `ums_role_resource_relation`
    DISABLE KEYS */;
INSERT INTO `ums_role_resource_relation`
VALUES (103, 2, 8),
       (104, 2, 9),
       (105, 2, 10),
       (106, 2, 11),
       (107, 2, 12),
       (142, 5, 1),
       (143, 5, 2),
       (144, 5, 3),
       (145, 5, 4),
       (146, 5, 5),
       (147, 5, 6),
       (148, 5, 8),
       (149, 5, 9),
       (150, 5, 10),
       (151, 5, 11),
       (152, 5, 12),
       (153, 5, 13),
       (154, 5, 14),
       (155, 5, 15),
       (156, 5, 16),
       (157, 5, 17),
       (158, 5, 18),
       (159, 5, 19),
       (160, 5, 20),
       (161, 5, 21),
       (162, 5, 22),
       (163, 5, 23),
       (164, 5, 24),
       (165, 5, 25),
       (166, 5, 26),
       (167, 5, 27),
       (168, 5, 28),
       (169, 5, 29),
       (170, 1, 1),
       (171, 1, 2),
       (172, 1, 3),
       (173, 1, 4),
       (174, 1, 5),
       (175, 1, 6),
       (176, 1, 23),
       (177, 1, 24),
       (205, 7, 13),
       (206, 7, 14),
       (207, 7, 15),
       (208, 7, 16),
       (209, 7, 17),
       (210, 7, 18),
       (211, 7, 19),
       (212, 7, 20),
       (213, 7, 21),
       (214, 7, 22),
       (215, 7, 23),
       (216, 7, 24),
       (220, 8, 23),
       (221, 8, 24),
       (222, 8, 26),
       (223, 8, 27),
       (224, 8, 31),
       (225, 10, 1),
       (226, 10, 2),
       (227, 10, 3),
       (228, 10, 4),
       (229, 10, 5),
       (230, 10, 6),
       (231, 10, 33),
       (232, 10, 34);
/*!40000 ALTER TABLE `ums_role_resource_relation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log`
(
    `id`            bigint       NOT NULL AUTO_INCREMENT,
    `branch_id`     bigint       NOT NULL,
    `xid`           varchar(100) NOT NULL,
    `context`       varchar(128) NOT NULL,
    `rollback_info` longblob     NOT NULL,
    `log_status`    int          NOT NULL,
    `log_created`   datetime     NOT NULL,
    `log_modified`  datetime     NOT NULL,
    `ext`           varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 182
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `undo_log`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2025-06-02 22:58:22
