//
//  APPNetAPIManager.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "APPNetAPIManager.h"
#import "Seller_HotShop.h"
#import "Home_ZhaoBiao.h"
#import "Youzhi_Shop.h"
#import "Zhao_Qiu_Biao.h"
#import "Shop_Owner.h"
#import "ZongHe_Shop.h"
#import "ShopCart_MTL.h"
#import "PingLun_MTL.h"
#import "Shop_Details_MTL.h"
#import "Login_User.h"

@implementation APPNetAPIManager

+ (instancetype)sharedManager {
    static APPNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (id)jsonBackDic:(NSString *)str {
    id responseObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    return responseObject;
}

/// 注册
- (void)request_Regist_WithPhone:(NSString *)phone WithPwd:(NSString *)pwd WithCheckcode:(NSString *)checkcode andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"phone":phone,
                          @"pwd":pwd,
                          @"checkcode":checkcode
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"regist" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block(data,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

///短信接口
- (void)request_Duanxin_WithPhone:(NSString *)phone andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"phone":phone
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"duanxin" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block(data,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

///登录
- (void)request_Login_WithPhone:(NSString *)phone WithPwd:(NSString *)pwd andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"phone":phone,
                          @"pwd":pwd
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"login" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSError *oneError = nil;
                Login_Total *login_Total = [[Login_Total alloc] init];
                login_Total.user = [MTLJSONAdapter modelOfClass:[Login_User class] fromJSONDictionary:[self jsonBackDic:[data valueForKeyPath:@"Content"]][0] error:&oneError];
                if (oneError == nil) {
                    if ([self jsonBackDic:[data valueForKeyPath:@"Content"]][0]) {
                        [Login_Total doLogin:[self jsonBackDic:[data valueForKeyPath:@"Content"]][0]];
                    }
                }
                block(login_Total,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

///首页banner图
- (void)request_Syshowimg_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"syshowing" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 热销商品
- (void)request_Gethot_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"gethot" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Seller_HotShop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 招标求标
- (void)request_Getbiao_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"getbiao" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Home_ZhaoBiao class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 优质商家
- (void)request_Getshop_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"getshop" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Youzhi_Shop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 本地推荐
- (void)request_Getad_WithAd_weizhi:(NSString *)ad_weizhi andBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"getadshop" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 头条资讯
- (void)request_Gettitle_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"gettitle" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商城banner图
- (void)request_Sjshowimg_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"sjshowimg" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 限时抢购
- (void)request_Xsbuy_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"xsbuy" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Seller_HotShop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 精选特色
- (void)request_Tsproduct_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"tsproduct" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Seller_HotShop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 招标列表
- (void)request_Zblist_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"zblist" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Zhao_Qiu_Biao class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 求标列表
- (void)request_Qblist_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"qblist" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Zhao_Qiu_Biao class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商家列表
- (void)request_Shoplist_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"shoplist" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Shop_Owner class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商品列表
- (void)request_goodslist_WithOrder:(NSString *)order cat_id:(NSString *)cat_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"order":order,
                          @"cat_id":cat_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"goodslist" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[ZongHe_Shop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商品页详情
- (void)request_Xqshop_WithGoods_id:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"goods_id":goods_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"zfshop" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 首页通讯设备商品展示
- (void)request_Showgoods_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"showgoods" withParams:nil withMethodType:Post andBlock:^(NSDictionary *data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 首页通信缆线
- (void)request_Showgood_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"showgood" withParams:nil withMethodType:Post andBlock:^(NSDictionary *data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[ZongHe_Shop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 首页推荐
- (void)request_Tuijian_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"tuijian" withParams:nil withMethodType:Post andBlock:^(NSDictionary *data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[ZongHe_Shop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 购物车列表
- (void)request_Cart_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"cart" withParams:@{@"member_id":member_id} withMethodType:Post andBlock:^(NSDictionary *data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                arr = [[self jsonBackDic:[data valueForKeyPath:@"Content"]] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 订单列表
- (void)request_Orderlist_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"orderlist" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 待付款
- (void)request_Waitmoney_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"waitmoney" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 待收货
- (void)request_Waitgot_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"waitgot" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 招标详情
- (void)request_zb_detail_WithId:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"zb_detail" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商品评论
- (void)request_plshop_WithGoods_id:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"goods_id":goods_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"plshop" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[PingLun_MTL class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商家详情
- (void)request_shop_detail_WithId:(NSString *)goods_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":goods_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"shop_detail" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Shop_Details_MTL class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block(arr,nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 去结算
- (void)request_addorder_WithGoods_id:(NSString *)goods_id member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"goodslist":goods_id,
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"addorder" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"+++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 加入购物车
- (void)request_addcart_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id goods_number:(NSString *)goods_number andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"goods_id":goods_id,
                          @"member_id":member_id,
                          @"goods_number":goods_number
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"addcart" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:@"已加入购物车"];
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 立即购买接口
- (void)request_buy_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id goods_number:(NSString *)goods_number andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"goods_id":goods_id,
                          @"member_id":member_id,
                          @"goods_number":goods_number
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"buy" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 收货地址查询接口
- (void)request_cxaddress_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"cxaddress" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 修改昵称
- (void)request_changename_WithId:(NSString *)member_id name:(NSString *)name andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id,
                          @"name":name
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"changename" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 头条列表
- (void)request_titlelist_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"titlelist" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 获取分类信息接口
- (void)request_getcat_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"getcat" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 猜你喜欢信息
- (void)request_lovegoods_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"lovegoods" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 我的评价接口
- (void)request_mypj_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"mypj" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 修改头像
- (void)request_updatetx_Withid:(NSString *)member_id photo:(NSString *)photo andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":member_id,
                          @"photo":photo
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"updatetx" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 支付宝接口
- (void)request_alipaySign_WithTotal_price:(NSString *)total_price out_trade_no:(NSString *)out_trade_no sj_money:(NSString *)sj_money andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic;
    if (sj_money.length == 0 || !sj_money) {
        dic = @{
                @"total_price":total_price,
                @"out_trade_no":out_trade_no
                };
    }else{
        dic = @{
                @"sj_money":sj_money
                };
    }
    [[APPNetAPIClient sharedJsonClient]requestAliJsonDataWithPath:@"alipaySign" withParams:dic withMethodType:Post autoShowError:YES andBlock:^(id data, NSError *error) {
        block(data,nil);
    }];
}

/// 微信接口
- (void)request_wxPay_WithTotal_price:(NSString *)total_price out_trade_no:(NSString *)out_trade_no sj_money:(NSString *)sj_money andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic;
    if (sj_money.length == 0 || !sj_money) {
        dic = @{
                @"total_price":total_price,
                @"out_trade_no":out_trade_no
                };
    }else{
        dic = @{
                @"sj_money":sj_money
                };
    }
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"wxPay" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"errorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"responseData"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 用户协议接口
- (void)request_user_xy_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"user_xy" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}



/// 删除订单接口
- (void)request_delorder_WithMember_id:(NSString *)member_id order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"order_id":order_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"delorder" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 去评价获取商品信息
- (void)request_gopj_WithOrder_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"order_id":order_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"gopj" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++%@",[self jsonBackDic:[data valueForKeyPath:@"Content"]]);
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 点击商品评价接口
- (void)request_pjgoods_WithMember_id:(NSString *)member_id goods_id:(NSString *)goods_id content:(NSString *)content order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"goods_id":goods_id,
                          @"content":content,
                          @"order_id":order_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"pjgoods" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(data[@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 忘记密码接口
- (void)request_xgpwd_WithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"phone":phone,
                          @"pwd":pwd,
                          @"code":code
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"xgpwd" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                DebugLog(@"++++++%@",[data valueForKeyPath:@"ErrorContent"]);
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 确认收货接口
- (void)request_qrsh_WithMember_id:(NSString *)member_id order_id:(NSString *)order_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"id":order_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"qrsh" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:data[@"Content"]];
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 添加收货地址接口
- (void)request_addaddress_WithAddress:(NSString *)address member_id:(NSString *)member_id name:(NSString *)name tel:(NSString *)tel andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"address":address,
                          @"name":name,
                          @"tel":tel
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"addaddress" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 查看物流接口
- (void)request_ckwl_WithMember_id:(NSString *)member_id out_trade_no:(NSString *)out_trade_no andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"out_trade_no":out_trade_no
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"ckwl" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 搜索商品接口
- (void)request_searchgoods_WithContent:(NSString *)content andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"content":content
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"search" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[ZongHe_Shop class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 搜索商家接口
- (void)request_searchshop_WithContent:(NSString *)content andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"content":content
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"search" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                NSMutableArray *arr = [NSMutableArray array];
                NSError *oneError = nil;
                arr = [[MTLJSONAdapter modelsOfClass:[Shop_Owner class] fromJSONArray:[self jsonBackDic:[data valueForKeyPath:@"Content"]] error:&oneError] mutableCopy];
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 发布招求标接口
- (void)request_releasebiao_WithTitle:(NSString *)title content:(NSString *)content is_zhao:(NSString *)is_zhao fbz:(NSString *)fbz link_tel:(NSString *)link_tel photo:(NSString *)photo id:(NSString *)memberId andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"title":title,
                          @"content":content,
                          @"is_zhao":is_zhao,
                          @"fbz":fbz,
                          @"link_tel":link_tel,
                          @"photo":photo,
                          @"id":memberId
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"releasebiao" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商家入驻
- (void)request_shopRz_WithShop_name:(NSString *)shop_name shop_logo:(NSString *)shop_logo shop_zhizhao:(NSString *)shop_zhizhao shop_desc:(NSString *)shop_desc shop_linkman:(NSString *)shop_linkman shop_tel:(NSString *)shop_tel id:(NSString *)memberID jgdaima:(NSString *)jgdaima xukezheng:(NSString *)xukezheng andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"shop_name":shop_name,
                          @"shop_logo":shop_logo,
                          @"shop_zhizhao":shop_zhizhao,
                          @"shop_desc":shop_desc,
                          @"shop_linkman":shop_linkman,
                          @"shop_tel":shop_tel,
                          @"id":memberID,
                          @"jgdaima":jgdaima,
                          @"xukezheng":xukezheng
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"shopRz" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 审核通过文字
- (void)request_getcont_WithId:(NSString *)memberID andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":memberID
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"icont" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 苹果分享接口
- (void)request_ishare_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"ishare" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 购物车删除商品
- (void)request_delgoods_WithMember_id:(NSString *)member_id cart_id:(NSString *)cart_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id,
                          @"cart_id":cart_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"delgoods" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 发布招标记录
- (void)request_record_WithMember_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"record" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 分享二维码接口
- (void)request_erweima_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"erweima" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([self jsonBackDic:[data valueForKeyPath:@"Content"]],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 更改手机号 验证旧手机号验证码
- (void)request_changephone_WithCode:(NSString *)code andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"code":code
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"changephone" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 更改手机号 验证新手机号验证码
- (void)request_changenew_WithCode:(NSString *)code phone:(NSString *)phone member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"code":code,
                          @"phone":phone,
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"changenew" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 商家入驻押金金额接口
- (void)request_shop_money_WithBlock:(void(^)(id data, NSError *error))block{
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"shop_money" withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"Content"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 删除招求标接口
- (void)request_delbiao_WithId:(NSString *)biao_id member_id:(NSString *)member_id andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"id":biao_id,
                          @"member_id":member_id
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"delbiao" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

/// 客户反馈接口
- (void)request_userfk_WithContent:(NSString *)content member_id:(NSString *)member_id name:(NSString *)name tel:(NSString *)tel andBlock:(void(^)(id data, NSError *error))block{
    NSDictionary *dic = @{
                          @"content":content,
                          @"member_id":member_id,
                          @"name":name,
                          @"tel":tel
                          };
    [[APPNetAPIClient sharedJsonClient]requestJsonDataWithPath:@"userfk" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"ErrorCode"] isEqualToString:@"0000"]) {
                block([data valueForKeyPath:@"ErrorContent"],nil);
            }else{
                [NSObject showHudTipStr:data[@"ErrorContent"]];
                block(nil,error);
            }
        }else{
            block(nil,error);
        }
    }];
}

@end
