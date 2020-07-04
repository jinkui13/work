drop table if exists admin;

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   admin_id             varchar(30) not null comment '员工编号',
   admin_name           varchar(20) comment '员工姓名',
   admin_pwd            varchar(40) not null comment '登录密码',
   primary key (admin_id)
);



drop table if exists coupon;

/*==============================================================*/
/* Table: coupon                                                */
/*==============================================================*/
create table coupon
(
   coupon_id            int not null  AUTO_INCREMENT comment '优惠券编号',
   coupon_amount        float not null comment '优惠金额',
   need_count           int not null comment '集单要求数',
   start_time           datetime not null comment '起始日期',
   end_time             datetime not null comment '结束日期',
   primary key (coupon_id)
);

drop table if exists store;

/*==============================================================*/
/* Table: store                                                 */
/*==============================================================*/
create table store
(
   store_id             int not null AUTO_INCREMENT comment '商家编号',
   store_name           varchar(40) comment '商家名',
   store_star           int comment '商家星级',
   avg_amount           float comment '人均消费',
   total_sales          int comment '总销量',
   primary key (store_id)
);


drop table if exists goods_type;

/*==============================================================*/
/* Table: goods_type                                            */
/*==============================================================*/
create table goods_type
(
   type_id              int not null AUTO_INCREMENT comment '分类编号',
   type_name            varchar(100) comment '分类栏目名',
   goods_count          int not null comment '商品数量',
   primary key (type_id)
);

drop table if exists good_item;

/*==============================================================*/
/* Table: good_item                                             */
/*==============================================================*/
create table good_item
(
   goods_id             int not null AUTO_INCREMENT comment '商品编号',
   type_id              int comment '分类编号',
   goods_name           varchar(100) comment '商品名',
   goods_price          float not null comment '价格',
   dis_price            float not null comment '优惠价格',
   primary key (goods_id)
);

alter table good_item add constraint FK_Reference_19 foreign key (type_id)
      references goods_type (type_id) on delete restrict on update restrict;


drop table if exists discount;

/*==============================================================*/
/* Table: discount                                              */
/*==============================================================*/
create table discount
(
   dis_id               int not null AUTO_INCREMENT comment '满减编号',
   nead_amount          float not null comment '要求金额',
   dis_amount           float not null comment '优惠金额',
   flag                 bool not null DEFAULT 0  comment '是否可与优惠券叠加',
   primary key (dis_id)
);

drop table if exists delivery;

/*==============================================================*/
/* Table: delivery                                              */
/*==============================================================*/
create table delivery
(
   dl_id                int not null AUTO_INCREMENT comment '骑手编号',
   dl_name              varchar(40) not null comment '骑手姓名',
   entry_date           datetime comment '入职日期',
   idt                  int DEFAULT '0' comment '骑手身份',
   primary key (dl_id)
);

drop table if exists user;

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null AUTO_INCREMENT comment '用户编号',
   user_name            varchar(40) not null comment '姓名',
   user_sex             varchar(20) comment '性别',
   user_pwd             varchar(20) not null comment '密码',
   ph_no                varchar(40) comment '手机号码',
   mail                 varchar(100) comment '邮箱',
   city                 varchar(100) comment '所在城市',
   rgs_date             datetime comment '注册时间',
   member               boolean not null DEFAULT 0 comment '是否会员',
   me_enddate           datetime comment '会员截止日期',
   primary key (user_id)
);

drop table if exists goods_assess;

/*==============================================================*/
/* Table: goods_assess                                          */
/*==============================================================*/
create table goods_assess
(
   goods_id             int not null comment '商品编号',
   store_id             int not null comment '商家编号',
   user_id              int not null comment '用户编号',
   assess               varchar(200) comment '评价内容',
   as_date              datetime comment '评价日期',
   star                 int comment '星级',
   image                longblob comment '照片',
   primary key (store_id, goods_id, user_id)
);

alter table goods_assess add constraint FK_goods_assess foreign key (store_id)
      references store (store_id) on delete restrict on update restrict;

alter table goods_assess add constraint FK_goods_assess2 foreign key (goods_id)
      references good_item (goods_id) on delete restrict on update restrict;

alter table goods_assess add constraint FK_goods_assess3 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;



drop table if exists coupon_hold;

/*==============================================================*/
/* Table: coupon_hold                                           */
/*==============================================================*/
create table coupon_hold
(
   user_id              int not null comment '用户编号',
   coupon_id            int not null comment '优惠券编号',
   store_id             int not null comment '商家编号',
   coupon_amount        float not null DEFAULT 0 comment '优惠金额',
   hold_count           int not null DEFAULT 1 comment '数量',
   end_time             datetime comment '截止日期',
   primary key (store_id, coupon_id, user_id)
);

alter table coupon_hold add constraint FK_coupon_hold foreign key (store_id)
      references store (store_id) on delete restrict on update restrict;

alter table coupon_hold add constraint FK_coupon_hold2 foreign key (coupon_id)
      references coupon (coupon_id) on delete restrict on update restrict;

alter table coupon_hold add constraint FK_coupon_hold3 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;


drop table if exists free_count;

/*==============================================================*/
/* Table: free_count                                            */
/*==============================================================*/
create table free_count
(
   user_id          int not null comment '用户编号',
   store_id         int not null comment '商家编号',
   coupon_id            int not null comment '优惠券编号',
   need_count           int not null DEFAULT 999 comment '集单要求数',
   had_count            int not null DEFAULT 1 comment '已订单数',
   primary key (use_user_id, coupon_id, sto_store_id)
);

alter table free_count add constraint FK_user_c foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table free_count add constraint FK_user_c2 foreign key (coupon_id)
      references coupon (coupon_id) on delete restrict on update restrict;

alter table free_count add constraint FK_user_c3 foreign key (store_id)
      references store (store_id) on delete restrict on update restrict;


drop table if exists address;

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id           int not null comment '地址编号',
   user_id              int comment '用户编号',
   shen                 varchar(40) comment '省',
   shi                  varchar(40) comment '市',
   qu                   varchar(40) comment '区',
   address              varchar(100) not null comment '地址',
   address_name         varchar(40) comment '联系人',
   ph_no                varchar(40) comment '电话',
   primary key (address_id)
);

alter table address add constraint FK_Relationship_8 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;


drop table if exists usr_order;

/*==============================================================*/
/* Table: order                                               */
/*==============================================================*/
create table usr_order
(
   order_id             int not null comment '订单编号',
   store_id             int not null comment '商家编号',
   user_id              int not null comment '用户编号',
   dl_id                int not null comment '骑手编号',
   strat_pirce          float comment '原始金额',
   end_price            float comment '结算金额',
   discount_id          int comment '满减编号',
   coupon_id            int comment '优惠券编号',
   enter_time           timestamp comment '下单时间',
   hope_time            timestamp comment '送达时间',
   address_id           int not null comment '地址编号',
   status               int not null DEFAULT 0 comment '订单状态',
   primary key (order_id)
);

alter table usr_order add constraint FK_Reference_24 foreign key (address_id)
      references address (address_id) on delete restrict on update restrict;

alter table usr_order add constraint FK_Relationship_2 foreign key (store_id)
      references store (store_id) on delete restrict on update restrict;

alter table usr_order add constraint FK_Relationship_4 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table usr_order add constraint FK_Relationship_5 foreign key (dl_id)
      references delivery (dl_id) on delete restrict on update restrict;

alter table usr_order add constraint FK_Relationship_6 foreign key (discount_id)
      references discount (dis_id) on delete restrict on update restrict;

alter table usr_order add constraint FK_Relationship_7 foreign key (coupon_id)
      references coupon (coupon_id) on delete restrict on update restrict;

drop table if exists order_item;

/*==============================================================*/
/* Table: order_item                                            */
/*==============================================================*/
create table order_item
(
   order_id             int comment '订单编号',
   goods_id             int comment '商品编号',
   count                int not null DEFAULT 0 comment '价格',
   dis_price            float not null DEFAULT 0 comment '单品优惠',
   primary key (order_id, goods_id)
);

alter table order_item add constraint FK_Reference_20 foreign key (order_id)
      references usr_order (order_id) on delete restrict on update restrict;

alter table order_item add constraint FK_Reference_21 foreign key (goods_id)
      references good_item (goods_id) on delete restrict on update restrict;


drop table if exists bill;

/*==============================================================*/
/* Table: bill                                                  */
/*==============================================================*/
create table bill
(
   dl_id                int not null comment '骑手编号',
   order_id             int not null comment '订单编号',
   entry_time           datetime comment '接单时间',
   user_assess          varchar(400) comment '用户评价',
   income               float not null DEFAULT 0 comment '单笔收入',
   primary key (dl_id, order_id)
);

alter table bill add constraint FK_Reference_22 foreign key (dl_id)
      references delivery (dl_id) on delete restrict on update restrict;

alter table bill add constraint FK_Reference_23 foreign key (order_id)
      references usr_order (order_id) on delete restrict on update restrict;