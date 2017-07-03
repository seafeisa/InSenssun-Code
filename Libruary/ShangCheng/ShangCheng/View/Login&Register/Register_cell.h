//
//  Register_cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register_cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *code_button;

@property (nonatomic,copy)void(^code_Block)(NSString *phone);

@property (nonatomic,copy)void(^register_Block)(NSString *phone, NSString *code, NSString *psw);

@property (nonatomic,copy)void(^protocal_Block)();

@end
