//
//  ShopCart_MTL.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/22.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopCart_MTL : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *id, *out_trade_no, *pay_status, *total_num, *total_price, *addtime;

@property (nonatomic,strong)NSArray *goodsInfo;

@end
