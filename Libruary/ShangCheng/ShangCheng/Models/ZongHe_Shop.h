//
//  ZongHe_Shop.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ZongHe_Shop : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *id, *goods_name, *market_price, *shop_price, *plnum, *logo, *goods_sales_num, *member_id, *mid_logo;

@property (nonatomic,strong)NSString *goods_yfprice;
@property (nonatomic,strong)NSArray *gaData;

@end
