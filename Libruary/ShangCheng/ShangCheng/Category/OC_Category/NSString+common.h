//
//  NSString+common.h
//  yiwei
//
//  Created by 黄单单 on 2017/1/23.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (common)
/// 判断手机号是否合法
+ (BOOL)valiMobile:(NSString *)mobile;
/// 判断银行卡号是否合法
+ (BOOL)isBankCard:(NSString *)cardNumber;
/// 判断身份证号是否合法
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;
@end
