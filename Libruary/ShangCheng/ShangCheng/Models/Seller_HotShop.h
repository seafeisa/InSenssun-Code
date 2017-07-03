//
//  Seller_HotShop.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Seller_HotShop : MTLModel <MTLJSONSerializing>
@property (nonatomic,strong)NSString *goods_name, *id, *market_price, *mid_logo, *shop_price;
@property (nonatomic,strong)NSString *reg_time, *addtime, *promote_start_date, *promote_end_date;
@property (nonatomic,strong)NSString *goods_sales_num;
@property (nonatomic,strong)NSString *goods_number;
@property (nonatomic,strong)NSArray *gaData;
@end
