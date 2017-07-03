//
//  NSObject+Common.h
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/10.
//  Copyright © 2016年 youde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

#pragma mark - Tip M
+ (NSString *)tipFromError:(NSError *)error;
+ (BOOL)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString *)tipStr;
+ (instancetype)showHUDQueryStr:(NSString *)titleStr;
+ (NSUInteger)hideHUDQuery;

#pragma mark - BaseURL
+ (NSString *)baseURLStr;

#pragma mark - NetError
+ (void)handleResponse:(id)responseJSON;

@end
