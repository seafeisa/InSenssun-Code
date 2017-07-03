//
//  Change_Photo_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Change_Photo_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *code_button;
@property (nonatomic,copy)void(^code_Block)(NSString *phone);
@property (nonatomic,copy)void(^nextStep_Block)(NSString *phone, NSString *code);

- (void)cellForOldPhone;


- (void)cellForNewPhone;

@end
