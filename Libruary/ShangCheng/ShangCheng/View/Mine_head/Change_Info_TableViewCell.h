//
//  Change_Info_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Change_Info_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^change_name_Block)(NSString *info);
@end
