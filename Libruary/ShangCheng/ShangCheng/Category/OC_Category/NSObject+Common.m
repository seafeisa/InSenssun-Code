//
//  NSObject+Common.m
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/10.
//  Copyright © 2016年 youde. All rights reserved.
//

#import "NSObject+Common.h"
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD-umbrella.h>

#define kHUDQueryViewTag 101

@implementation NSObject (Common)

#define kErrorCode @"ErrorCode"
#define k0000 @"0000"

#pragma mark - Tip M
+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                DebugLog(@"+++++++++++%@",msgStr);
//                HtmlMedia *media = [HtmlMedia htmlMediaWithString:msgStr showType:MediaShowTypeAll];
//                msgStr = media.contentDisplay;
//                
//                if (i+1 < num) {
//                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
//                }else{
//                    [tipStr appendString:msgStr];
//                }
            }
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}

+ (BOOL)showError:(NSError *)error{
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
    return YES;
}

+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.color = [UIColor blackColor];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = tipStr;
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1];
    }
}

+ (instancetype)showHUDQueryStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在获取数据...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.label.text = titleStr;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}

+ (NSUInteger)hideHUDQuery{
    __block NSUInteger count = 0;
//    NSArray *huds = [MBProgressHUD ]
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}

#pragma mark - BaseURL
+ (NSString *)baseURLStr{
    NSString *baseURLStr = @"";
    baseURLStr = @"http://tx.sebon.com.cn/index.php/home/index/";
    return baseURLStr;
}

#pragma mark - NetError
+ (void)handleResponse:(id)responseJSON{
    [self handleResponse:responseJSON autoShowError:YES];
}

- (void)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    if (responseJSON) {
        if (autoShowError) {
            if (![[responseJSON valueForKeyPath:kErrorCode] isEqualToString:k0000]) {
                [NSObject showHudTipStr:[responseJSON valueForKeyPath:@""]];
            }
        }
    }
}

@end
