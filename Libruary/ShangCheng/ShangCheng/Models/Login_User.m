//
//  Login_User.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Login_User.h"

@implementation Login_User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        //KVC间接做法;
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
