# -*- coding: utf8 -*-


class Context(object):
    def __init__(self, bill_detail, bill,
                 delivery_bill_detail=None,
                 delivery_abnormal_bill_detail=None):
        self.bill_detail = bill_detail
        self.bill = bill

        self.d_detail = delivery_bill_detail
        self.d_abnormal_detail = delivery_abnormal_bill_detail


class Default(object):
    Number = 0
    DateTime = '1970-01-01 08:00:01'
    Timestamp = 0
    String = ''


def gen_trans_no(restaurant_id, order_id,
                 detail_type=0,
                 detail_sub_type=0):
    return '|'.join([
        'P', restaurant_id, order_id, detail_type, detail_sub_type
    ])


class VoucherConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = self.ctx.bill_detail

    @property
    def restaurant_id(self):
        """#bigint -- 商户id"""
        return self.detail.entity_id

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        return self.detail.eleme_order_id

    @property
    def trans_no(self):
        """#varchar -- 交易号"""
        return gen_trans_no(self.restaurant_id,
                            self.order_id,
                            self.detail.bill_type)

    @property
    def restaurant_number(self):
        """#bigint -- 餐厅当日流水号"""
        return self.detail.restaurant_number

    @property
    def order_created_at(self):
        """#datetime -- 订单创建时间"""
        return self.detail.order_created_at

    @property
    def order_completed_at(self):
        """#datetime -- 订单完结时间"""
        return self.detail.order_completed_at

    @property
    def status_code(self):
        """#tinyint -- 订单状态"""
        return Default.Number

    @property
    def refund_id(self):
        """#bigint -- 退单号（退单时有效）"""
        return Default.Number

    @property
    def refund_created_at(self):
        """#datetime -- 退单创建时间（退单时有效）"""
        return Default.DateTime

    @property
    def refund_completed_at(self):
        """#datetime -- 退单完结时间（退单时有效）"""
        return Default.DateTime

    @property
    def order_type(self):
        """#tinyint -- 订单类型"""
        return int(self.detail.is_book)

    @property
    def order_mode(self):
        """#tinyint -- 订单处理模式"""
        return Default.Number

    @property
    def paid_type(self):
        """#tinyint -- 支付方式"""
        return int(self.detail.is_online_paid)

    @property
    def settlement_type(self):
        """#tinyint -- 结算方式"""
        return int(self.detail.is_online_settle)

    @property
    def delivery_type(self):
        """#tinyint -- 配送方式"""
        pass

    @property
    def charge_type(self):
        """#tinyint -- 订单收费类型"""
        return Default.Number

    @property
    def business_type(self):
        """#tinyint -- 业务类型"""
        pass

    @property
    def user_online_paid_amount(self):
        """#decimal -- 用户实际支付金额"""
        return self.detail.user_online_paid_amount

    @property
    def food_amount(self):
        """#decimal -- 菜价"""
        return self.detail.food_amount

    @property
    def packing_amount(self):
        """#decimal -- 打包（餐盒）费"""
        return self.detail.packing_amount

    @property
    def eleme_subsidy_amount(self):
        """#decimal -- ele 承担活动补贴"""
        return self.detail.subsidy_eleme_amount

    @property
    def merchant_subsidy_amount(self):
        """#decimal -- 商户承担活动补贴"""
        return self.detail.subsidy_merchant_amount

    @property
    def eleme_gift_subsidy_amount(self):
        """#decimal -- ele 赠品补贴"""
        return self.detail.subsidy_eleme_gift_amount

    @property
    def eleme_hongbao_amount(self):
        """#decimal -- ele 红包"""
        return self.detail.coupon_amount

    @property
    def eleme_cash_coupon(self):
        """#decimal -- ele 承担代金券补贴"""
        return self.detail.eleme_cash_coupon

    @property
    def merchant_cash_coupon(self):
        """#decimal -- 商户承担代金券补贴  """
        return self.detail.merchant_cash_coupon

    @property
    def vip_no_delivery_amount(self):
        """#decimal -- 会员卡免配送费金额"""
        return Default.Number

    @property
    def merchant_delivery_cost(self):
        """#decimal -- 商户替用戶承担的配送费"""
        return self.detail.merchant_delivery_cost

    @property
    def original_delivery_fee(self):
        """#decimal -- 基础配送费"""
        pass

    @property
    def user_paid_delivery_fee(self):
        """#decimal -- 用户支付配送费"""
        return self.detail.user_side_delivery_fee

    @property
    def merchant_hudan_delivery_fee(self):
        """#decimal -- 商家呼单支付配送费"""
        return Default.Number

    @property
    def merchant_agent_delivery_fee(self):
        """#decimal -- 商家支付代理商配送费"""
        return Default.Number

    @property
    def delivery_id(self):
        """#bigint -- 运单号"""
        pass

    @property
    def delivery_state(self):
        """#tinyint -- 运单主状态"""
        return Default.Number

    @property
    def delivery_sub_state(self):
        """#tinyint -- 运单子状态"""
        return Default.Number

    @property
    def night_delivery_fee(self):
        """#decimal -- 夜间加价"""
        pass

    @property
    def distance_delivery_fee(self):
        """#decimal -- 超远距离加价"""
        pass

    @property
    def status(self):
        """#tinyint -- 处理结果"""
        return 1


class VoucherExtraConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = ctx.bill_detail

    @property
    def voucher_id(self):
        """#bigint -- voucher.id"""
        pass

    @property
    def restaurant_id(self):
        """#bigint -- 商户id"""
        return self.detail.entity_id

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        return self.detail.eleme_order_id

    @property
    def full_guarantee_price_range(self):
        """#varchar -- 城市保底价区间"""
        return ''

    @property
    def merchant_commission_rate_range(self):
        """#varchar -- 抽佣费率区间"""
        return ''

    @property
    def merchant_commission_type(self):
        """#tinyint -- 抽佣（服务费）类型"""
        return Default.Number

    @property
    def base_price(self):
        """#decimal -- 物流抽佣保底价"""
        return Default.Number

    @property
    def eleme_profit_rate(self):
        """#decimal -- 平台分润比率"""
        return Default.Number

    @property
    def zhuan_shan_profit_rate(self):
        """#decimal -- 馔山分润比率 """
        return Default.Number

    @property
    def agent_profit_rate(self):
        """#decimal -- 代理商分润比率"""
        return Default.Number


class BizVoucherConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = ctx.bill_detail

    @property
    def restaurant_id(self):
        """#bigint -- 商户id"""
        pass

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        pass

    @property
    def trans_no(self):
        """#varchar -- 交易流水号"""
        pass

    @property
    def comment(self):
        """#varchar -- 备注"""
        pass

    @property
    def amount(self):
        """#decimal -- 赔偿金额"""
        pass

    @property
    def compensation_rate(self):
        """#decimal -- 赔偿费率"""
        pass

    @property
    def business_type(self):
        """#tinyint -- 业务类型"""
        pass

    @property
    def operate_type(self):
        """#tinyint -- 操作类型"""
        pass

    @property
    def status(self):
        """#tinyint -- 处理结果"""
        pass


class SettleDetailConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = ctx.bill_detail

    @property
    def trans_no(self):
        """#varchar -- 交易号"""
        pass

    @property
    def restaurant_id(self):
        """#bigint -- 商户ID"""
        return self.detail.entity_id

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        return self.detail.eleme_order_id

    @property
    def order_created_at(self):
        """#datetime -- 订单创建时间"""
        return self.detail.order_created_at

    @property
    def order_completed_at(self):
        """#datetime -- 订单完结时间"""
        return self.detail.order_completed_at

    @property
    def platform_income(self):
        """#decimal -- 平台收入"""
        return Default.Number

    @property
    def agent_income(self):
        """#decimal -- 代理商收入"""
        return Default.Number

    @property
    def zhuan_shan_income(self):
        """#decimal -- 馔山收入"""
        return Default.Number

    @property
    def merchant_commission_amount(self):
        """#decimal -- 商户抽佣金额"""
        return self.detail.commission_amount

    @property
    def merchant_commission_rate(self):
        """#decimal -- 商户抽佣比率"""
        return self.detail.commission_rate  # TODO: xx% or xx

    @property
    def goods_amount(self):
        """#decimal -- 货款"""
        return self.detail.goods_amount

    @property
    def full_guarantee_fee(self):
        """#decimal -- 满额(城市)保底价"""
        return self.detail.full_guarantee_price

    @property
    def comment(self):
        """#varchar -- 备注"""
        return self.detail.remark


class SettleMerchantDetailConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = ctx.bill_detail

    @property
    def settle_detail_id(self):
        """#bigint -- settle_detail.id"""
        pass

    @property
    def restaurant_id(self):
        """#bigint -- 商户ID"""
        return self.detail.entity_id

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        return self.detail.eleme_order_id

    @property
    def detail_type(self):
        """#tinyint -- 详情类型"""
        return self.detail.bill_type

    @property
    def detail_sub_type(self):
        """#tinyint -- 详情子类型"""
        pass

    @property
    def merchant_income(self):
        """#decimal -- 商户收入"""
        return self.detail.total

    @property
    def in_fund(self):
        """#decimal -- 内资"""
        return self.detail.total

    @property
    def out_fund(self):
        """#decimal -- 外资"""
        return 0

    @property
    def merchant_delivery_fee_income(self):
        """#decimal -- 商户配送费收入"""
        pass

    @property
    def comment(self):
        """#varchar -- 备注"""
        return self.detail.remark

    @property
    def status(self):
        """#tinyint -- 处理结果, 0 待处理 1 处理完成"""
        return 1


class SettleDeliverDetailConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.d_detail = ctx.delivery_bill_detail

    @property
    def settle_detail_id(self):
        """#bigint -- settle_detail.id"""
        pass

    @property
    def restaurant_id(self):
        """#bigint -- 商户ID"""
        return self.d_detail.restaurant_id

    @property
    def order_id(self):
        """#bigint -- 订单号"""
        return self.d_detail.eleme_order_id

    @property
    def detail_type(self):
        """#tinyint -- 详情类型 1:正常单 2:赔付单"""
        return 1

    @property
    def deliver_income(self):
        """#decimal -- 物流收入"""
        return self.d_detail.amount

    @property
    def deliver_delivery_fee_income(self):
        """#decimal -- 物流配送费收入"""
        pass

    @property
    def deliver_commission_amount(self):
        """#decimal -- 物流服务费"""
        pass

    @property
    def deliver_commission_rate(self):
        """#decimal -- 物流抽佣比率"""
        pass

    @property
    def deliver_base_price(self):
        """#decimal -- 物流抽佣保底价"""
        return Default.Number

    @property
    def deliver_due_amount(self):
        """#decimal -- 物流赔付金额"""
        pass

    @property
    def carrier_payable_amount(self):
        """#decimal -- 骑手垫付金额"""
        pass


class SettleClearingChargeEntryConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.detail = ctx.bill_detail

    @property
    def restaurant_id(self):
        """#bigint -- 餐厅id"""
        return self.detail.entity_id

    @property
    def ref_id(self):
        """#varchar -- 业务系统流水号,前四位系统标识：1001(结算系统)"""
        pass

    @property
    def out_fund_amount(self):
        """#decimal -- 外资金额"""
        return 0

    @property
    def in_fund_amount(self):
        """#decimal -- 内资金额"""
        return self.detail.amount

    @property
    def trans_date(self):
        """#timestamp -- 业务日期"""
        pass

    @property
    def closing_date(self):
        """#date -- 入账日期"""
        pass

    @property
    def payment_date(self):
        """#date -- 出账日期"""
        pass

    @property
    def settlement_type(self):
        """#varchar -- 结算类型，1:应收, 2:应付"""
        return 2


class SettleClearingPayableConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.bill = ctx.bill

    @property
    def restaurant_id(self):
        """#bigint -- 餐厅id"""
        return self.bill.entity_id

    @property
    def in_fund_amount(self):
        """#decimal -- 内资金额"""
        return

    @property
    def out_fund_amount(self):
        """#decimal -- 外资金额"""
        pass

    @property
    def closing_date(self):
        """#date -- 入账日期"""
        pass

    @property
    def payment_date(self):
        """#date -- 出账日期"""
        pass

    @property
    def pay_plan_no(self):
        """#varchar -- 付款计划流水号"""
        pass

    @property
    def status(self):
        """#tinyint -- 处理状态,1:初始化 2:已生成付款计划"""
        return 2


class SettleClearingPayPlanConverter(object):
    def __init__(self, ctx):
        self.ctx = ctx
        self.bill = self.ctx.bill

    @property
    def restaurant_id(self):
        """#bigint -- 餐厅id"""
        return self.bill.entity_id

    @property
    def pay_plan_no(self):
        """#varchar -- 付款计划ID"""
        pass

    @property
    def head_restaurant_id(self):
        """#bigint -- 总店ID"""
        return Default.Number

    @property
    def pay_in_amount(self):
        """#decimal -- 实付内资金额"""
        return self.bill.amount

    @property
    def pay_out_amount(self):
        """#decimal -- 实付外资金额"""
        return 0

    @property
    def pay_amount(self):
        """#decimal -- 实付总金额"""
        return self.bill.amount

    @property
    def closing_date(self):
        """#date -- 入账日期"""
        return self.bill.date

    @property
    def payment_date(self):
        """#date -- 出账日期"""
        return self.bill.issue_date

    @property
    def into_balance_date(self):
        """#timestamp -- 入余额时间"""
        return self.bill.created_at

    @property
    def into_balance_status(self):
        """#tinyint -- 入余额状态，1:入余额初始，2:入余额完成，3:无需入余额(实付0)"""
        return 2

    @property
    def withdraw_date(self):
        """#timestamp -- 提现时间"""
        return self.bill.updated_at

    @property
    def withdraw_status(self):
        """#tinyint -- 提现状态，1. 初始，2:已提现，3:无需提现"""
        return 2

    @property
    def pay_type(self):
        """#tinyint -- 付款类型，1. 单店计算，2:总店结算"""
        return Default.Number
