//
//  PingLun_MTL.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/31.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PingLun_MTL : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *content, *addtime, *member_id, *plpic, *touxiang, *nicheng;
@property (nonatomic,strong)NSArray *member_info;

- (id)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;

@end
