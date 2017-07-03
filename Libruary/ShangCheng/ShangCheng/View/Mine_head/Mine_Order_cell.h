//
//  Mine_Order_cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_Order_cell : UITableViewCell

@property (nonatomic,strong)NSDictionary *order;
@property (nonatomic,assign)CGFloat rowHeight;
@property (nonatomic,copy)void(^PingJia_Block)();
@property (nonatomic,copy)void(^pay_Block)();
@property (nonatomic,copy)void(^delete_Block)();
@property (nonatomic,copy)void(^GetGoos_Block)();
@property (nonatomic,copy)void(^CheckWuLiu_Block)();

- (void)cellForOrder;

- (void)cellForThings;

- (void)cellForWaitMoney;

@end
