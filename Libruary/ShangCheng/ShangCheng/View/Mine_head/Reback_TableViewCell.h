//
//  Reback_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Reback_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^reback_blcok)(NSString *tips,NSString *phone,NSString *name);
@end
