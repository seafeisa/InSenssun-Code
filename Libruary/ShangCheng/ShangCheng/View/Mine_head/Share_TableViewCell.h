//
//  Share_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Share_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^share_block)();

@property (nonatomic,strong)NSString *image;
@end
