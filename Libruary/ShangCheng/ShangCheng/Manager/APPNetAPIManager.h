//
//  APPNetAPIManager.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPNetAPIManager : NSObject

+ (instancetype)sharedManager;

/// 注册
- (void)request_Regist_WithPhone:(NSString *)phone WithPwd:(NSString *)pwd WithCheckcode:(NSString *)checkcode andBlock:(void(^)(id data, NSError *error))block;

/// 短信接口
- (void)request_Duanxin_WithPhone:(NSString *)phone andBlock:(void(^)(id data, NSError *error))block;

/// 登录
- (void)request_Login_WithPhone:(NSString *)phone WithPwd:(NSString *)pwd andBlock:(void(^)(id data, NSError *error))block;

/// 首页banner图
- (void)request_Syshowimg_WithBlock:(void(^)(id data, NSError *error))block;

/// 热销商品
- (void)request_Gethot_WithBlock:(void(^)(id data, NSError *error))block;

/// 招标求标
- (void)request_Getbiao_WithBlock:(void(^)(id data, NSError *error))block;

/// 优质商家
- (void)request_Getshop_WithBlock:(void(^)(id data, NSError *error))block;

/// 本地推荐
- (void)request_Getad_WithAd_weizhi:(NSString *)ad_weizhi andBlock:(void(^)(id data, NSError *error))block;

/// 头条资讯
- (void)request_Gettitle_WithBlock:(void(^)(id data, NSError *error))block;

/// 商城banner图
- (void)request_Sjshowimg_WithBlock:(void(^)(id data, NSError *error))block;

/// 限时抢购
- (void)request_Xsbuy_WithBlock:(void(^)(id data, NSError *error))block;

/// 精选特色
- (void)request_Tsproduct_WithBlock:(void(^)(id data, NSError *error))block;

/// 招标列表
- (void)request_Zblist_WithBlock:(void(^)(id data, NSError *error))block;

/// 求标列表
- (void)request_Qblist_WithBlock:(void(^)(id data, NSError *error))block;

/// 商家列表
- (void)request_Shoplist_WithBlock:(void(^)(id data, NSError *error))block;

/// 商品列表
- (void)request_goodslist_WithOrder:(NSString *)order cat_id:(NSString *)cat_id andBlock:(void(^)(id data, NSError *error))block;

/// 商品页详情
- (void)request_Xqshop_WithGoods_id:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block;

/// 首页通讯设备商品展示
- (void)request_Showgoods_WithBlock:(void(^)(id data, NSError *error))block;

/// 首页通信缆线
- (void)request_Showgood_WithBlock:(void(^)(id data, NSError *error))block;

/// 首页推荐
- (void)request_Tuijian_WithBlock:(void(^)(id data, NSError *error))block;

/// 购物车列表
- (void)request_Cart_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 订单列表
- (void)request_Orderlist_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 待付款
- (void)request_Waitmoney_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 待收货
- (void)request_Waitgot_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 招标详情
- (void)request_zb_detail_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 商品评论
- (void)request_plshop_WithGoods_id:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block;

/// 商家详情
- (void)request_shop_detail_WithId:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block;

/// 去结算
- (void)request_addorder_WithGoods_id:(NSString *)goods_id member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 加入购物车
- (void)request_addcart_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id goods_number:(NSString *)goods_number andBlock:(void(^)(id data, NSError *error))block;

/// 立即购买接口
- (void)request_buy_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id goods_number:(NSString *)goods_number andBlock:(void(^)(id data, NSError *error))block;

/// 收货地址查询接口
- (void)request_cxaddress_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 修改昵称
- (void)request_changename_WithId:(NSString *)member_id name:(NSString *)name andBlock:(void(^)(id data, NSError *error))block;

/// 头条列表
- (void)request_titlelist_WithBlock:(void(^)(id data, NSError *error))block;

/// 获取分类信息接口
- (void)request_getcat_WithBlock:(void(^)(id data, NSError *error))block;

/// 猜你喜欢信息
- (void)request_lovegoods_WithBlock:(void(^)(id data, NSError *error))block;

/// 我的评价接口
- (void)request_mypj_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 修改头像
- (void)request_updatetx_Withid:(NSString *)member_id photo:(NSString *)photo andBlock:(void(^)(id data, NSError *error))block;

/// 支付宝接口
- (void)request_alipaySign_WithTotal_price:(NSString *)total_price out_trade_no:(NSString *)out_trade_no sj_money:(NSString *)sj_money andBlock:(void(^)(id data, NSError *error))block;

/// 微信接口
- (void)request_wxPay_WithTotal_price:(NSString *)total_price out_trade_no:(NSString *)out_trade_no sj_money:(NSString *)sj_money andBlock:(void(^)(id data, NSError *error))block;

/// 删除订单接口
- (void)request_delorder_WithMember_id:(NSString *)member_id order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block;

/// 去评价获取商品信息
- (void)request_gopj_WithOrder_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block;

/// 点击商品评价接口
- (void)request_pjgoods_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id content:(NSString *)content order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block;

/// 忘记密码接口
- (void)request_xgpwd_WithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code andBlock:(void(^)(id data, NSError *error))block;

/// 确认收货接口
- (void)request_qrsh_WithMember_id:(NSString *)member_id order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block;

/// 添加收货地址接口
- (void)request_addaddress_WithAddress:(NSString *)address member_id:(NSString *)member_id name:(NSString *)name tel:(NSString *)tel andBlock:(void(^)(id data, NSError *error))block;

/// 查看物流接口
- (void)request_ckwl_WithMember_id:(NSString *)member_id out_trade_no:(NSString *)out_trade_no andBlock:(void(^)(id data, NSError *error))block;

/// 搜索商品接口
- (void)request_searchgoods_WithContent:(NSString *)content andBlock:(void(^)(id data, NSError *error))block;

/// 搜索商家接口
- (void)request_searchshop_WithContent:(NSString *)content andBlock:(void(^)(id data, NSError *error))block;

/// 发布招求标接口
- (void)request_releasebiao_WithTitle:(NSString *)title content:(NSString *)content is_zhao:(NSString *)is_zhao fbz:(NSString *)fbz link_tel:(NSString *)link_tel photo:(NSString *)photo id:(NSString *)memberId andBlock:(void(^)(id data, NSError *error))block;

/// 商家入驻
- (void)request_shopRz_WithShop_name:(NSString *)shop_name shop_logo:(NSString *)shop_logo shop_zhizhao:(NSString *)shop_zhizhao shop_desc:(NSString *)shop_desc shop_linkman:(NSString *)shop_linkman shop_tel:(NSString *)shop_tel id:(NSString *)memberID jgdaima:(NSString *)jgdaima xukezheng:(NSString *)xukezheng andBlock:(void(^)(id data, NSError *error))block;

/// 审核通过文字
- (void)request_getcont_WithId:(NSString *)memberID andBlock:(void(^)(id data, NSError *error))block;

/// 用户协议接口
- (void)request_user_xy_WithBlock:(void(^)(id data, NSError *error))block;

/// 苹果分享接口
- (void)request_ishare_WithBlock:(void(^)(id data, NSError *error))block;

/// 购物车删除商品
- (void)request_delgoods_WithMember_id:(NSString *)member_id cart_id:(NSString *)cart_id andBlock:(void(^)(id data, NSError *error))block;

/// 发布招标记录
- (void)request_record_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 分享二维码接口
- (void)request_erweima_WithBlock:(void(^)(id data, NSError *error))block;

/// 更改手机号 验证旧手机号验证码
- (void)request_changephone_WithCode:(NSString *)code andBlock:(void(^)(id data, NSError *error))block;

/// 更改手机号 验证新手机号验证码
- (void)request_changenew_WithCode:(NSString *)code phone:(NSString *)phone member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 商家入驻押金金额接口
- (void)request_shop_money_WithBlock:(void(^)(id data, NSError *error))block;

/// 删除招求标接口
- (void)request_delbiao_WithId:(NSString *)biao_id member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block;

/// 客户反馈接口
- (void)request_userfk_WithContent:(NSString *)content member_id:(NSString *)member_id name:(NSString *)name tel:(NSString *)tel andBlock:(void(^)(id data, NSError *error))block;

@end
