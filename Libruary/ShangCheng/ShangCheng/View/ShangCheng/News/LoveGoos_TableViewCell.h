//
//  LoveGoos_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoveGoos_TableViewCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *contentArray;
@property (nonatomic,copy)void(^details_Block)(NSString *ID,NSString *type);
@end
