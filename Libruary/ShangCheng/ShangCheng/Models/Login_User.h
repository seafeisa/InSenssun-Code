//
//  Login_User.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle/Mantle.h"

@interface Login_User : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong)NSString *id, *is_money, *memberid, *name, *nicheng, *password, *phone, *regtime, *sh_address, *touxiang, *username, *is_ok, *sf_money;


//- (id)initWithDictionary:(NSDictionary *)dic;
//+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;

@end
