//
//  Home_ZhaoBiao.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home_ZhaoBiao : MTLModel <MTLJSONSerializing>
@property (nonatomic,strong)NSString *title, *content, *img, *addtime, *id, *url;

@end
