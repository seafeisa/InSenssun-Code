//
//  Youzhi_Shop.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Youzhi_Shop : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *id, *shop_name, *shop_desc, *shop_logo;

@end
