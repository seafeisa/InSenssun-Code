//
//  Zhao_Qiu_Select_Cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Zhao_Qiu_Select_Cell : UITableViewCell

@property (nonatomic,copy)void(^zhaoBiao_Block)();

@property (nonatomic,copy)void(^qiuBiao_Block)();

@end
