//
//  Mine_PingJia_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCart_MTL.h"

@interface Mine_PingJia_TableViewCell : UITableViewCell

@property (nonatomic,copy)void(^pingJia_Block)(NSString *str);

@property (nonatomic,strong)NSDictionary *contentDic;

@end
