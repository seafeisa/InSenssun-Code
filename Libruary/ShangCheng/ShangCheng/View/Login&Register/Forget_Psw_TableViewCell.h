//
//  Forget_Psw_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forget_Psw_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^code_Block)(NSString *phone);
@property (nonatomic,copy)void(^complete_Block)(NSString *phone,NSString *code,NSString *psw);
@property (weak, nonatomic) IBOutlet UIButton *code_button;
@end
