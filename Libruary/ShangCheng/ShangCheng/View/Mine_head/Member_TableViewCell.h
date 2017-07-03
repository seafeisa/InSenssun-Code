//
//  Member_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/27.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Member_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^sure_pay_Block)(BOOL isWechat);
@end
