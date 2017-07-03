//
//  ZiXun_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiXun_TableViewCell : UITableViewCell
@property (nonatomic,strong)NSArray *nameArr;
@property (nonatomic,copy)void(^moreButton_Block)();
@property (nonatomic,copy)void(^getID_Block)(NSString *url);
@end
