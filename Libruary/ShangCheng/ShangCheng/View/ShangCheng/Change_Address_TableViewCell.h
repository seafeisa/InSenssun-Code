//
//  Change_Address_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Change_Address_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^change_Address_Block)(NSString *name,NSString *phone,NSString *address);
@end
