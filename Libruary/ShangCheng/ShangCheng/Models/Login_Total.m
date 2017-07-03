//
//  Login_Total.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Login_Total.h"
#import <PINCache/PINCache-umbrella.h>

#define kLoginPreUserName @"pre_user_name"
#define kLogin_Total_User_MTL @"com.cs.user"

@implementation Login_Total

- (Login_User *)user {
    if (!_user) {
        _user = [[Login_User alloc] init];
    }
    return _user;
}

+ (void)doLogin:(NSDictionary *)loginData{
    if (loginData) {
        [[PINCache sharedCache] setObject:loginData forKey:kLogin_Total_User_MTL];
    }
}

+ (void)changeNickname:(NSString *)str {
    if (str.length > 0) {
        NSDictionary *loginData = [[PINCache sharedCache] objectForKey:kLogin_Total_User_MTL];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:loginData];
        [dic setObject:str forKey:@"nicheng"];
        [[PINCache sharedCache] setObject:dic forKey:kLogin_Total_User_MTL];
    }
}

+ (void)changeTouXiang:(NSString *)str{
    if (str.length > 0) {
        NSDictionary *loginData = [[PINCache sharedCache] objectForKey:kLogin_Total_User_MTL];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:loginData];
        [dic setObject:str forKey:@"touxiang"];
        [[PINCache sharedCache] setObject:dic forKey:kLogin_Total_User_MTL];
    }
}

+ (void)delete_LoginDta{
    NSDictionary *dic = [NSDictionary dictionary];
    [[PINCache sharedCache] setObject:dic forKey:kLogin_Total_User_MTL];
}

+ (Login_User *)curLoginUser{
    NSDictionary *loginData = [[PINCache sharedCache] objectForKey:kLogin_Total_User_MTL];
    NSError *oneError = nil;
    Login_User *curLoginUser = loginData? [MTLJSONAdapter modelOfClass:Login_User.class fromJSONDictionary:loginData error:&oneError] : nil;
    if (loginData) {
        if (oneError) {
            [NSObject showHudTipStr:@"User_MTL is error"];
        }
    }
    return curLoginUser;
}
@end
