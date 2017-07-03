//
//  Mine_Head_Cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_Head_Cell : UITableViewCell

@property (nonatomic,copy)void(^accountSet_Block)();

@property (nonatomic,copy)void(^login_Block)();

@property (nonatomic,strong)NSString *iconImage;

@end
