//
//  Login_Total.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login_User.h"

@interface Login_Total : NSObject
@property (nonatomic,strong)Login_User *user;

+ (void)doLogin:(NSDictionary *)loginData;

+ (void)delete_LoginDta;
+ (Login_User *)curLoginUser;

+ (void)changeNickname:(NSString *)str;
+ (void)changeTouXiang:(NSString *)str;
@end
