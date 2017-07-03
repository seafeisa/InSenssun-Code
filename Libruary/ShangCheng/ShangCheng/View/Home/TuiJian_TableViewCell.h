//
//  TuiJian_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiJian_TableViewCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *center_arr;
@property (nonatomic,strong)NSString *top_imageName;
@property (nonatomic,strong)NSString *bottom_imageName;
@property (nonatomic,copy)void(^details_Block)(NSString *ID,NSString *type);
@property (nonatomic,copy)void(^TopDetails_Block)();
@property (nonatomic,copy)void(^BottomDetails_Block)();
@end
