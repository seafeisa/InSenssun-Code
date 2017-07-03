//
//  Home_Shop_Cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_Shop_Cell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *hotArr;
@property (nonatomic,copy)void(^more_button_block)();
@property (nonatomic,copy)void(^shop_details_Block)(NSString *goos_id);
@end
