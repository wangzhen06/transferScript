CREATE TABLE `voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `trans_no` varchar(40) NOT NULL DEFAULT '' COMMENT '交易号',
  `restaurant_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅当日流水号',
  `order_created_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '订单创建时间',
  `order_completed_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '订单完结时间',
  `status_code` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `refund_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '退单号（退单时有效）',
  `refund_created_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '退单创建时间（退单时有效）',
  `refund_completed_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '退单完结时间（退单时有效）',
  `order_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单类型',
  `order_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单处理模式',
  `paid_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付方式',
  `settlement_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '结算方式',
  `delivery_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '配送方式',
  `charge_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单收费类型',
  `business_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '业务类型',
  `user_online_paid_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '用户实际支付金额',
  `food_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '菜价',
  `packing_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '打包（餐盒）费',
  `eleme_subsidy_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT 'ele 承担活动补贴',
  `merchant_subsidy_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商户承担活动补贴',
  `eleme_gift_subsidy_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT 'ele 赠品补贴',
  `eleme_hongbao_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT 'ele 红包',
  `eleme_cash_coupon` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT 'ele 承担代金券补贴',
  `merchant_cash_coupon` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商户承担代金券补贴  ',
  `vip_no_delivery_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '会员卡免配送费金额',
  `merchant_delivery_cost` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商户替用戶承担的配送费',
  `original_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '基础配送费',
  `user_paid_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '用户支付配送费',
  `merchant_hudan_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商家呼单支付配送费',
  `merchant_agent_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商家支付代理商配送费',
  `delivery_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '运单号',
  `delivery_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '运单主状态',
  `delivery_sub_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '运单子状态',
  `night_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '夜间加价',
  `distance_delivery_fee` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '超远距离加价',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '处理结果',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_trans_no` (`trans_no`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_order_id_business_type` (`order_id`,`business_type`),
  KEY `ix_status_created_at` (`status`,`created_at`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外卖订单凭证表';


CREATE TABLE `voucher_extra` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `voucher_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'voucher.id',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `full_guarantee_price_range` varchar(512) NOT NULL DEFAULT '' COMMENT '城市保底价区间',
  `merchant_commission_rate_range` varchar(512) NOT NULL DEFAULT '' COMMENT '抽佣费率区间',
  `merchant_commission_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '抽佣（服务费）类型',
  `base_price` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '物流抽佣保底价',
  `eleme_profit_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '平台分润比率',
  `zhuan_shan_profit_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '馔山分润比率 ',
  `agent_profit_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '代理商分润比率',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_voucher_id` (`voucher_id`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外卖订单凭证表扩展';


CREATE TABLE `biz_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `trans_no` varchar(40) NOT NULL DEFAULT '' COMMENT '交易流水号',
  `comment` varchar(512) NOT NULL DEFAULT '' COMMENT '备注',
  `amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '赔偿金额',
  `compensation_rate` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '赔偿费率',
  `business_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '业务类型',
  `operate_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '处理结果',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_trans_no` (`trans_no`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_order_id_business_type` (`order_id`,`business_type`),
  KEY `ix_status_created_at` (`status`,`created_at`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='赔偿业务凭证表';


CREATE TABLE `settle_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `trans_no` varchar(40) NOT NULL DEFAULT '' COMMENT '交易号',

  `restaurant_id` bigint(20) NOT NULL DEFAULT -1 COMMENT '商户ID',
  `order_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单号',

  `order_created_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '订单创建时间',
  `order_completed_at` datetime NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '订单完结时间',

  `platform_income` decimal(11,2) DEFAULT 0 COMMENT '平台收入',
  `agent_income` decimal(11,2) DEFAULT 0 COMMENT '代理商收入',
  `zhuan_shan_income` decimal(11,2) DEFAULT 0 COMMENT '馔山收入',

  `merchant_commission_amount` decimal(11,2) DEFAULT 0 COMMENT '商户抽佣金额',
  `merchant_commission_rate` decimal(11,2) DEFAULT 0 COMMENT '商户抽佣比率',
  `goods_amount` decimal(11,2) DEFAULT 0 COMMENT '货款',
  `full_guarantee_fee` decimal(11,2) DEFAULT 0 COMMENT '满额(城市)保底价',

  `comment` varchar(512) DEFAULT 0 COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',

  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_trans_no` (`trans_no`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='订单详情表';


CREATE TABLE `settle_merchant_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',

  `settle_detail_id` bigint(20) NOT NULL DEFAULT -1 COMMENT 'settle_detail.id',
  `restaurant_id` bigint(20) NOT NULL DEFAULT -1 COMMENT '商户ID',
  `order_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单号',

  `detail_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '详情类型',
  `detail_sub_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '详情子类型',

  `merchant_income` decimal(11,2) DEFAULT 0 COMMENT '商户收入',
  `in_fund` decimal(11,2) DEFAULT 0 COMMENT '内资',
  `out_fund` decimal(11,2) DEFAULT 0 COMMENT '外资',
  `merchant_delivery_fee_income` decimal(11,2) DEFAULT 0 COMMENT '商户配送费收入',

  `comment` varchar(512) DEFAULT 0 COMMENT '备注',

  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '处理结果, 0 待处理 1 处理完成',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',

  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_order_id_d_type` (`order_id`, `detail_type`, `detail_sub_type`),
  KEY `ix_settle_detail_id` (`settle_detail_id`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_status_created_at` (`status`, `created_at`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商户侧详情表';


CREATE TABLE `settle_deliver_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `settle_detail_id` bigint(20) NOT NULL DEFAULT -1 COMMENT 'settle_detail.id',

  `restaurant_id` bigint(20) NOT NULL DEFAULT -1 COMMENT '商户ID',
  `order_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单号',

  `detail_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '详情类型 1:正常单 2:赔付单',

  `deliver_income` decimal(11,2) DEFAULT 0 COMMENT '物流收入',
  `deliver_delivery_fee_income` decimal(11,2) DEFAULT 0 COMMENT '物流配送费收入',
  `deliver_commission_amount` decimal(11,2) DEFAULT 0 COMMENT '物流服务费',
  `deliver_commission_rate` decimal(11,2) DEFAULT 0 COMMENT '物流抽佣比率',
  `deliver_base_price` decimal(11,2) DEFAULT 0 COMMENT '物流抽佣保底价',
  `deliver_due_amount` decimal(11,2) DEFAULT 0 COMMENT '物流赔付金额',
  `carrier_payable_amount` decimal(11,2) DEFAULT 0 COMMENT '骑手垫付金额',

  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',

  PRIMARY KEY (`id`),
  KEY `ix_settle_detail_id` (`settle_detail_id`),
  UNIQUE KEY `ix_order_id_d_type` (`order_id`, `detail_type`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='物流侧详情表';


CREATE TABLE `settle_lost_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT comment '表主键',
  `trans_no` varchar(40) NOT NULL DEFAULT '' comment '交易号',

  `restaurant_id` bigint(20) NOT NULL DEFAULT 0 comment '商户 ID',
  `order_id` bigint(20) NOT NULL DEFAULT 0 comment '订单号',

  `settle_rule` smallint(6) DEFAULT NULL DEFAULT -555 comment '结算规则',
  `error_code` smallint(6) DEFAULT NULL DEFAULT -1 comment 'Error Code',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_order_id_error_code` (`order_id`, `error_code`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_error_code` (`error_code`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='未出账订单表';


CREATE TABLE `settle_clearing_charge_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅id',
  `ref_id` varchar(40) NOT NULL DEFAULT ' ' COMMENT '业务系统流水号,前四位系统标识：1001(结算系统)',
  `out_fund_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '外资金额',
  `in_fund_amount` decimal(11,2) NOT NULLDEFAULT '0.00' COMMENT '内资金额',
  `trans_date` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '业务日期',
  `closing_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '入账日期',
  `payment_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '出账日期',
  `settlement_type` varchar(6) NOT NULL DEFAULT 'D' COMMENT '结算类型，1:应收, 2:应付',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ref_id` (`ref_id`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_trans_date` (`trans_date`),
  KEY `ix_closing_date` (`closing_date`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_payment_date` (`payment_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记账流水表';


CREATE TABLE `settle_clearing_payable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅id',
  `in_fund_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '内资金额',
  `out_fund_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '外资金额',
  `closing_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '入账日期',
  `payment_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '出账日期',
  `pay_plan_no` varchar(40) NOT NULL DEFAULT ' ' COMMENT '付款计划流水号',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '处理状态,1:初始化 2:已生成付款计划',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_restaurant_id_closing_date` (`restaurant_id`,`closing_date`),
  KEY `ix_closing_date` (`closing_date`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_payment_date` (`payment_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应付款表';

CREATE TABLE `settle_clearing_receivable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅id',
  `receivable_in_balance` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收内资余额',
  `receivable_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收内资金额',
  `received_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '已收内资金额',
  `receivable_out_balance` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收外资余额',
  `receivable_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收外资金额',
  `received_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '已收外资金额',
  `closing_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '入账日期',
  `payment_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '出账日期',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '处理状态,1:初始化 2:部分收回 3:全部收回',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_restaurant_id_closing_date` (`restaurant_id`,`closing_date`),
  KEY `ix_closing_date` (`closing_date`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`),
  KEY `ix_payment_date` (`payment_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应付款表';


CREATE TABLE `settle_clearing_pay_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅id',
  `pay_plan_no` varchar(40) NOT NULL DEFAULT ' ' COMMENT '付款计划ID',
  `head_restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '总店ID',
  `pay_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '实付内资金额',
  `pay_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '实付外资金额',
  `pay_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '实付总金额',
  `closing_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '入账日期',
  `payment_date` date NOT NULL DEFAULT '1970-01-01' COMMENT '出账日期',
  `into_balance_date` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '入余额时间',
  `into_balance_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '入余额状态，1:入余额初始，2:入余额完成，3:无需入余额(实付0)',
  `withdraw_date` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '提现时间',
  `withdraw_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '提现状态，1. 初始，2:已提现，3:无需提现',
  `pay_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '付款类型，1. 单店计算，2:总店结算',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_pay_plan_no` (`pay_plan_no`),
  UNIQUE KEY `uk_restaurant_id_closing_date` (`restaurant_id`,`closing_date`),
  KEY `ix_closing_date` (`closing_date`),
  KEY `ix_payment_date` (`payment_date`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款计划表';


CREATE TABLE `settle_clearing_deductible_rel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `restaurant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '餐厅id',
  `pay_plan_no` varchar(40) NOT NULL DEFAULT ' ' COMMENT '付款计划ID',
  `payable_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '应付款ID(payable:id)',
  `receivable_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '应收款ID(receivable:id)',
  `deduct_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '抵扣应收内资金额',
  `deduct_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '抵扣应收外资金额',
  `receivable_in_balance` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收内资余额',
  `receivable_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收内资金额',
  `received_in_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '已收内资金额',
  `received_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '已收外资金额',
  `receivable_out_balance` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收外资余额',
  `receivable_out_amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '应收外资金额',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  KEY `ix_restaurant_id` (`restaurant_id`),
  KEY `ix_pay_plan_no` (`pay_plan_no`),
  KEY `ix_payable_id` (`payable_id`),
  KEY `ix_receivable_id` (`receivable_id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抵扣关系表';
