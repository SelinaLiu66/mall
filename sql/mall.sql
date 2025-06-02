create table cart
(
    id          bigint auto_increment
        primary key,
    member_id   bigint                               not null comment '会员ID',
    sku_id      bigint                               not null comment 'SKU ID',
    count       int                                  not null comment '购买数量',
    selected    tinyint(1) default 1                 not null comment '选中状态',
    price       decimal(10, 2)                       not null comment '加入时价格',
    create_time datetime   default CURRENT_TIMESTAMP not null,
    update_time datetime   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
    comment '购物车表';

create index idx_member
    on cart (member_id);

create index idx_sku
    on cart (sku_id);

create table hot
(
    id      varchar(10)  not null comment '推荐ID'
        primary key,
    picture varchar(500) not null comment '图片地址',
    title   varchar(100) not null comment '推荐标题',
    alt     varchar(100) not null comment '推荐描述'
)
    comment '热门推荐表';

create table oms_order
(
    id                      int auto_increment comment '订单id'
        primary key,
    member_id               int            not null comment '会员ID',
    coupon_id               int            null comment '优惠券ID',
    order_sn                varchar(64)    null comment '订单编号',
    create_time             datetime       null comment '提交时间',
    member_username         varchar(64)    null comment '用户帐号',
    total_amount            decimal(10, 2) null comment '订单总金额',
    pay_amount              decimal(10, 2) null comment '应付金额（实际支付金额）',
    freight_amount          decimal(10, 2) null comment '运费金额',
    pay_type                int default 0  null comment '支付方式：0->未支付；1->支付宝；2->微信',
    status                  int default 1  null comment '订单状态：1->待付款；2->待发货；3->已发货；4->待评价；5->已完成；0->已取消；',
    order_type              int default 0  null comment '订单类型：0->正常订单；1->秒杀订单',
    delivery_company        varchar(64)    null comment '物流公司(配送方式)',
    delivery_sn             varchar(64)    null comment '物流单号',
    auto_confirm_day        int            null comment '自动确认时间（天）',
    receiver_name           text           not null comment '收货人姓名',
    receiver_phone          varchar(32)    not null comment '收货人电话',
    receiver_post_code      varchar(32)    null comment '收货人邮编',
    receiver_province       varchar(32)    null comment '省份/直辖市',
    receiver_city           varchar(32)    null comment '城市',
    receiver_region         varchar(32)    null comment '区',
    receiver_detail_address text           null comment '详细地址',
    note                    text           null comment '订单备注',
    confirm_status          int default 0  null comment '确认收货状态：0->未确认；1->已确认',
    delete_status           int default 0  not null comment '删除状态：0->未删除；1->已删除',
    payment_time            datetime       null comment '支付时间',
    delivery_time           datetime       null comment '发货时间',
    receive_time            datetime       null comment '确认收货时间',
    comment_time            datetime       null comment '评价时间',
    modify_time             datetime       null comment '修改时间'
)
    comment '订单表' collate = utf8mb4_general_ci
                     row_format = COMPACT;

create table oms_order_item
(
    id                  int auto_increment comment '订单项id，自增'
        primary key,
    order_id            int            null comment '订单id',
    order_sn            varchar(64)    null comment '订单编号',
    product_id          int            null comment '商品id',
    product_pic         text           null comment '商品封面图',
    product_name        text           null comment '商品名称',
    product_brand       text           null comment '品牌',
    product_sn          varchar(64)    null comment '商品编码',
    product_price       decimal(10, 2) null comment '销售价格',
    product_quantity    int            null comment '购买数量',
    product_sku_id      int            null comment '商品sku编号',
    product_sku_code    varchar(50)    null comment '商品sku条码',
    product_category_id int            null comment '商品分类id',
    promotion_name      text           null comment '商品促销名称',
    promotion_amount    decimal(10, 2) null comment '商品促销分解金额',
    coupon_amount       decimal(10, 2) null comment '优惠券优惠分解金额',
    integration_amount  decimal(10, 2) null comment '积分优惠分解金额',
    real_amount         decimal(10, 2) null comment '该商品经过优惠后的分解金额',
    gift_integration    int default 0  null comment '赠送计分',
    gift_growth         int default 0  null comment '赠送成长值',
    product_attr        text           null comment '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]'
)
    comment '订单中所包含的商品' collate = utf8mb4_general_ci
                                 row_format = COMPACT;

create table oms_order_operate_history
(
    id           int auto_increment
        primary key,
    order_id     int      null comment '订单id',
    operate_man  text     null comment '操作人：用户；系统；后台管理员',
    create_time  datetime null comment '操作时间',
    order_status int      null comment '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
    note         text     null comment '备注'
)
    comment '订单操作历史记录' collate = utf8mb4_general_ci
                               row_format = COMPACT;

create table oms_order_return_apply
(
    id                 int auto_increment
        primary key,
    order_id           int            null comment '订单id',
    company_address_id int            null comment '收货地址表id',
    product_id         int            null comment '退货商品id',
    order_sn           varchar(64)    null comment '订单编号',
    create_time        datetime       null comment '申请时间',
    member_username    varchar(64)    null comment '会员用户名',
    return_amount      decimal(10, 2) null comment '退款金额',
    return_name        text           null comment '退货人姓名',
    return_phone       text           null comment '退货人电话',
    status             int            null comment '申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝',
    handle_time        datetime       null comment '处理时间',
    product_pic        text           null comment '商品图片',
    product_name       text           null comment '商品名称',
    product_brand      text           null comment '商品品牌',
    product_attr       text           null comment '商品销售属性：颜色：红色；尺码：xl;',
    product_count      int            null comment '退货数量',
    product_price      decimal(10, 2) null comment '商品单价',
    product_real_price decimal(10, 2) null comment '商品实际支付单价',
    reason             text           null comment '原因',
    description        text           null comment '描述',
    proof_pics         text           null comment '凭证图片，以逗号隔开',
    handle_note        text           null comment '处理备注',
    handle_man         text           null comment '处理人员',
    receive_man        text           null comment '收货人',
    receive_time       datetime       null comment '收货时间',
    receive_note       text           null comment '收货备注'
)
    comment '订单退货申请' collate = utf8mb4_general_ci
                           row_format = DYNAMIC;

create table oms_order_return_reason
(
    id          int auto_increment
        primary key,
    name        text     null comment '退货类型',
    sort        int      null comment '排序',
    status      int      null comment '状态：0->不启用；1->启用',
    create_time datetime null comment '添加时间'
)
    comment '退货原因表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table pms_banner
(
    id         bigint       not null comment '轮播图ID'
        primary key,
    img_url    varchar(500) not null comment '图片地址',
    type       tinyint      not null comment '类型（1-商品轮播）',
    product_id bigint       not null comment '关联商品ID'
)
    comment '商品轮播图表';

create table pms_brand
(
    id                    int auto_increment
        primary key,
    name                  varchar(64) null comment '品牌名称',
    first_letter          varchar(8)  null comment '首字母',
    sort                  int         null comment '排序',
    factory_status        int         null comment '是否为品牌制造商：0->不是；1->是',
    show_status           int         null comment '是否显示',
    product_count         int         null comment '产品数量',
    product_comment_count int         null comment '产品评论数量',
    logo                  text        null comment '品牌logo',
    big_pic               text        null comment '专区大图',
    brand_story           text        null comment '品牌故事'
)
    comment '品牌表' collate = utf8mb4_general_ci
                     row_format = COMPACT;

create table pms_comment_replay
(
    id               int auto_increment
        primary key,
    comment_id       int      null comment '评论id',
    member_nick_name text     null comment '回复评论的会员昵称',
    member_icon      text     null comment '回复评论的会员头像',
    content          text     null comment '回复的内容',
    create_time      datetime null comment '时间',
    type             int      null comment '评论人员类型；0->会员；1->管理员'
)
    comment '产品评价回复表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table pms_member_price
(
    id                int auto_increment
        primary key,
    product_id        int            null comment '商品id',
    member_level_id   int            null comment '会员等级',
    member_price      decimal(10, 2) null comment '会员价格',
    member_level_name text           null comment '会员等级名称'
)
    comment '商品会员价格表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table pms_product
(
    id                            int auto_increment
        primary key,
    brand_id                      int            null comment '品牌id',
    product_category_id           int            null comment '商品类别',
    feight_template_id            int            null comment '运费标准id',
    product_attribute_category_id int            null comment '商品属性分类id',
    name                          varchar(64)    not null comment '商品名称',
    pic                           text           null comment '封面',
    product_sn                    varchar(64)    not null comment '货号',
    delete_status                 int            null comment '删除状态：0->未删除；1->已删除',
    publish_status                int            null comment '上架状态：0->下架；1->上架',
    new_status                    int            null comment '新品状态:0->不是新品；1->新品',
    recommand_status              int            null comment '主页推荐状态；0->不推荐；1->推荐',
    verify_status                 int            null comment '审核状态：0->未审核；1->审核通过',
    sort                          int            null comment '排序',
    sale                          int            null comment '销量',
    price                         decimal(10, 2) null comment '定价',
    promotion_price               decimal(10, 2) null comment '促销价格',
    gift_growth                   int default 0  null comment '赠送的成长值',
    gift_point                    int default 0  null comment '赠送的积分',
    use_point_limit               int            null comment '限制使用的积分数',
    sub_title                     text           null comment '副标题',
    description                   text           null comment '商品描述',
    original_price                decimal(10, 2) null comment '市场价',
    stock                         int            null comment '库存',
    low_stock                     int            null comment '库存预警值',
    unit                          varchar(16)    null comment '单位',
    weight                        decimal(10, 2) null comment '商品重量，默认为克',
    preview_status                int            null comment '是否为预告商品：0->不是；1->是',
    service_ids                   varchar(64)    null comment '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
    keywords                      text           null comment '商品关键词',
    note                          text           null comment '备注',
    album_pics                    text           null comment '画册图片，连产品图片限制为5张，以逗号分割',
    detail_title                  text           null comment '详细标题',
    detail_desc                   text           null comment '详细描述',
    detail_mobile_html            text           null comment '移动端网页详情',
    promotion_start_time          datetime       null comment '促销开始时间',
    promotion_end_time            datetime       null comment '促销结束时间',
    promotion_per_limit           int            null comment '活动限购数量',
    promotion_type                int            null comment '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
    brand_name                    text           null comment '品牌名称',
    product_category_name         text           null comment '商品分类名称'
)
    comment '商品信息' collate = utf8mb4_general_ci
                       row_format = DYNAMIC;

create table pms_product_attribute
(
    id                            int auto_increment
        primary key,
    product_attribute_category_id int         null comment '商品属性分类id',
    name                          varchar(64) null comment '名称',
    select_type                   int         null comment '属性选择类型：0->唯一；1->单选；2->多选',
    input_type                    int         null comment '属性录入方式：0->手工录入；1->从列表中选取',
    input_list                    text        null comment '可选值列表，以逗号隔开',
    sort                          int         null comment '排序字段：最高的可以单独上传图片',
    filter_type                   int         null comment '分类筛选样式：1->普通；1->颜色',
    search_type                   int         null comment '检索类型；0->不需要进行检索；1->关键字检索；2->范围检索',
    related_status                int         null comment '相同属性产品是否关联；0->不关联；1->关联',
    hand_add_status               int         null comment '是否支持手动新增；0->不支持；1->支持',
    type                          int         null comment '属性的类型；0->规格；1->参数'
)
    comment '商品属性参数表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table pms_product_attribute_category
(
    id              int auto_increment
        primary key,
    name            varchar(64)   null comment '属性分类名称',
    attribute_count int default 0 null comment '属性数量',
    param_count     int default 0 null comment '参数数量'
)
    comment '产品属性分类表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table pms_product_attribute_value
(
    id                   int auto_increment
        primary key,
    product_id           int         null comment '商品id',
    product_attribute_id int         null comment '商品属性id',
    value                varchar(64) null comment '手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开'
)
    comment '存储产品参数信息的表' collate = utf8mb4_general_ci
                                   row_format = COMPACT;

create table pms_product_category
(
    id            int auto_increment
        primary key,
    parent_id     int          null comment '上级分类的编号：0表示一级分类',
    name          varchar(64)  null comment '名称',
    level         int          null comment '分类级别：0->1级；1->2级',
    product_count int          null comment '这个类别的商品数量',
    product_unit  varchar(64)  null comment '商品计数单位',
    nav_status    int          null comment '是否显示在导航栏：0->不显示；1->显示',
    show_status   int          null comment '显示状态：0->不显示；1->显示',
    sort          int          null comment '排序',
    icon          text         null comment '图标',
    keywords      text         null comment '关键词',
    description   text         null comment '描述',
    picture       varchar(500) null comment '图片链接'
)
    comment '产品分类' collate = utf8mb4_general_ci
                       row_format = COMPACT;

create table pms_product_category_attribute_relation
(
    id                   int auto_increment
        primary key,
    product_category_id  int null comment '商品类别id',
    product_attribute_id int null comment '商品属性id'
)
    comment '产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）' collate = utf8mb4_general_ci
                                                                            row_format = COMPACT;

create table pms_product_full_reduction
(
    id           bigint auto_increment
        primary key,
    product_id   int            null comment '商品id',
    full_price   decimal(10, 2) null comment '满多少元，例如：满399',
    reduce_price decimal(10, 2) null comment '减多少元，例如：减20'
)
    comment '产品满减表(只针对同商品)' collate = utf8mb4_general_ci
                                       row_format = COMPACT;

create table pms_product_ladder
(
    id         int auto_increment
        primary key,
    product_id int            null comment '商品id',
    count      int            null comment '满足的商品数量',
    discount   decimal(10, 2) null comment '折扣',
    price      decimal(10, 2) null comment '折后价格'
)
    comment '产品阶梯价格表(只针对同商品)' collate = utf8mb4_general_ci
                                           row_format = COMPACT;

create table pms_sku_stock
(
    id              int auto_increment
        primary key,
    product_id      int            null comment '商品id',
    sku_code        varchar(64)    not null comment 'sku编码',
    price           decimal(10, 2) null comment '价格',
    stock           int default 0  null comment '库存',
    low_stock       int            null comment '预警库存',
    pic             text           null comment '展示图片',
    sale            int            null comment '销量',
    promotion_price decimal(10, 2) null comment '单品促销价格',
    lock_stock      int default 0  null comment '锁定库存',
    sp_data         text           null comment '商品销售属性，json格式'
)
    comment 'sku的库存' collate = utf8mb4_general_ci
                        row_format = COMPACT;

create table sms_home_advertise
(
    id          int auto_increment
        primary key,
    name        text          null comment '录播图名称',
    type        int           null comment '轮播位置：0->PC首页轮播；1->app首页轮播',
    pic         text          null comment '图片地址',
    start_time  datetime      null comment '开始时间',
    end_time    datetime      null comment '结束时间',
    status      int           null comment '上下线状态：0->下线；1->上线',
    click_count int           null comment '点击数',
    order_count int           null comment '下单数',
    url         text          null comment '链接地址',
    note        text          null comment '备注',
    sort        int default 0 null comment '排序'
)
    comment '首页轮播广告表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table sms_home_brand
(
    id               int auto_increment
        primary key,
    brand_id         int         null comment '品牌id',
    brand_name       varchar(64) null comment '品牌名称',
    recommend_status int         null comment '推荐状态 0->不推荐，1->推荐',
    sort             int         null comment '排序'
)
    comment '首页推荐品牌表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table sms_home_new_product
(
    id               int auto_increment
        primary key,
    product_id       int         null comment '商品id',
    product_name     varchar(64) null comment '商品名称',
    recommend_status int         null comment '推荐状态 0->不推荐，1->推荐',
    sort             int         null comment '排序'
)
    comment '新鲜好物表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table sms_home_recommend_product
(
    id               int auto_increment
        primary key,
    product_id       int         null comment '商品id',
    product_name     varchar(64) null comment '商品名称',
    recommend_status int         null comment '推荐状态 0->不推荐，1->推荐',
    sort             int         null comment '排序'
)
    comment '人气推荐商品表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table ums_admin
(
    id          int auto_increment
        primary key,
    username    varchar(64)   null comment '用户名',
    password    varchar(64)   null comment '密码',
    icon        text          null comment '头像',
    email       text          null comment '邮箱',
    nick_name   text          null comment '昵称',
    note        text          null comment '备注信息',
    create_time datetime      null comment '创建时间',
    login_time  datetime      null comment '最后登录时间',
    status      int default 1 null comment '帐号启用状态：0->禁用；1->启用',
    constraint uk_username
        unique (username)
)
    comment '后台用户表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table ums_admin_role_relation
(
    id       int auto_increment
        primary key,
    admin_id int           null comment '管理员id',
    role_id  int default 5 null comment '角色id'
)
    comment '后台用户和角色关系表' collate = utf8mb4_general_ci
                                   row_format = COMPACT;

create table ums_member
(
    id                     int auto_increment
        primary key,
    member_level_id        int default 4 null comment '会员等级ID',
    username               varchar(64)   null comment '用户名',
    password               varchar(64)   null comment '密码',
    nickname               varchar(64)   null comment '昵称',
    phone                  varchar(64)   null comment '手机号码',
    status                 int default 1 null comment '帐号启用状态:0->禁用；1->启用',
    create_time            datetime      null comment '注册时间',
    icon                   text          null comment '头像',
    gender                 int default 0 null comment '性别：0->未知；1->男；2->女',
    personalized_signature text          null comment '个性签名',
    constraint idx_phone
        unique (phone),
    constraint idx_username
        unique (username)
)
    comment '会员表' collate = utf8mb4_general_ci
                     row_format = COMPACT;

create table ums_member_level
(
    id                      int auto_increment
        primary key,
    name                    text           null comment '等级名称',
    growth_point            int            null comment '成长值阈值，例如：>5000',
    default_status          int            null comment '是否为默认等级：0->不是；1->是',
    free_freight_point      decimal(10, 2) null comment '免运费标准',
    comment_growth_point    int            null comment '每次评价获取的成长值',
    priviledge_free_freight int            null comment '是否有免邮特权',
    priviledge_sign_in      int            null comment '是否有签到特权',
    priviledge_comment      int            null comment '是否有评论获奖励特权',
    priviledge_promotion    int            null comment '是否有专享活动特权',
    priviledge_member_price int            null comment '是否有会员价格特权',
    priviledge_birthday     int            null comment '是否有生日特权',
    note                    text           null comment '备注'
)
    comment '会员等级表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table ums_member_receive_address
(
    id             int auto_increment
        primary key,
    member_id      int          null comment '会员id',
    name           text         null comment '收货人名称',
    phone_number   varchar(64)  null comment '收货人电话',
    default_status int          null comment '是否为默认',
    post_code      text         null comment '邮政编码',
    province       text         null comment '省份/直辖市',
    city           text         null comment '城市',
    region         text         null comment '区',
    detail_address varchar(128) null comment '详细地址(街道)'
)
    comment '会员收货地址表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table ums_menu
(
    id          int auto_increment
        primary key,
    parent_id   int      null comment '父级ID',
    create_time datetime null comment '创建时间',
    title       text     null comment '菜单名称',
    level       int      null comment '菜单级数',
    sort        int      null comment '菜单排序',
    name        text     null comment '前端名称',
    icon        text     null comment '前端图标',
    hidden      int      null comment '前端隐藏'
)
    comment '后台菜单表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table ums_permission
(
    id          int auto_increment
        primary key,
    pid         int      null comment '父级权限id',
    name        text     null comment '名称',
    value       text     null comment '权限值',
    icon        text     null comment '图标',
    type        int      null comment '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
    uri         text     null comment '前端资源路径',
    status      int      null comment '启用状态；0->禁用；1->启用',
    create_time datetime null comment '创建时间',
    sort        int      null comment '排序'
)
    comment '后台用户权限表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table ums_resource
(
    id          int auto_increment
        primary key,
    create_time datetime null comment '创建时间',
    name        text     null comment '资源名称',
    url         text     null comment '资源URL',
    description text     null comment '描述',
    category_id int      null comment '资源分类ID'
)
    comment '后台资源表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table ums_resource_category
(
    id          int auto_increment
        primary key,
    create_time datetime null comment '创建时间',
    name        text     null comment '分类名称',
    sort        int      null comment '排序'
)
    comment '资源分类表' collate = utf8mb4_general_ci
                         row_format = COMPACT;

create table ums_role
(
    id          int auto_increment
        primary key,
    name        text          null comment '名称',
    description text          null comment '描述',
    admin_count int           null comment '后台用户数量',
    create_time datetime      null comment '创建时间',
    status      int default 1 null comment '启用状态：0->禁用；1->启用',
    sort        int default 0 null comment '排序'
)
    comment '后台用户角色表' collate = utf8mb4_general_ci
                             row_format = COMPACT;

create table ums_role_menu_relation
(
    id      int auto_increment
        primary key,
    role_id int null comment '角色ID',
    menu_id int null comment '菜单ID'
)
    comment '后台角色菜单关系表' collate = utf8mb4_general_ci
                                 row_format = COMPACT;

create table ums_role_permission_relation
(
    id            int auto_increment
        primary key,
    role_id       int null comment '角色id',
    permission_id int null comment '权限id'
)
    comment '后台用户角色和权限关系表' collate = utf8mb4_general_ci
                                       row_format = COMPACT;

create table ums_role_resource_relation
(
    id          int auto_increment
        primary key,
    role_id     int null comment '角色ID',
    resource_id int null comment '资源ID'
)
    comment '后台角色资源关系表' collate = utf8mb4_general_ci
                                 row_format = COMPACT;

create table undo_log
(
    id            bigint auto_increment
        primary key,
    branch_id     bigint       not null,
    xid           varchar(100) not null,
    context       varchar(128) not null,
    rollback_info longblob     not null,
    log_status    int          not null,
    log_created   datetime     not null,
    log_modified  datetime     not null,
    ext           varchar(100) null,
    constraint ux_undo_log
        unique (xid, branch_id)
)
    charset = utf8mb3;

