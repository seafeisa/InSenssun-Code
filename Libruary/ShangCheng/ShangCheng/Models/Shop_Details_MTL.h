//
//  Shop_Details_MTL.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Shop_Details_MTL : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *addtime, *id, *is_good, *is_ok, *member_id, *shop_desc, *shop_linkman, *shop_logo, *shop_name, *shop_pic, *shop_tel, *shop_type, *shop_zhizhao, *viewer;

@end
