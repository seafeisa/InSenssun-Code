//
//  YouZhiShop_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouZhiShop_TableViewCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *youzhiArr;
@property (nonatomic,copy)void(^shop_details_Block)(NSString *shop_id);
@property (nonatomic,copy)void(^more_Block)();
@end
