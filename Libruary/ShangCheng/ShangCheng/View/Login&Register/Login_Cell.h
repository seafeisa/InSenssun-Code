//
//  Login_Cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login_Cell : UITableViewCell
@property (nonatomic,copy)void(^register_Block)();
@property (nonatomic,copy)void(^forget_Block)();
@property (nonatomic,copy)void(^login_Block)(NSString *phone, NSString *pwd);
@end
