//
//  Device_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Device_TableViewCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *device_arr;
@property (nonatomic,copy)void(^shop_details_Block)(NSString *goos_id);
@property (nonatomic,copy)void (^more_button)();
@property (nonatomic,strong)NSString *name;
@end
