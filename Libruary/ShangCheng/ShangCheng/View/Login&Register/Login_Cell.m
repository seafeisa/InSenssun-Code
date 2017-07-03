//
//  Login_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Login_Cell.h"

@interface Login_Cell ()
@property (weak, nonatomic) IBOutlet UIButton *register_button;
@property (weak, nonatomic) IBOutlet UIButton *login_button;
@property (weak, nonatomic) IBOutlet UIButton *forget_pwd_button;
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *pwd_textField;

@end

@implementation Login_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.register_button bk_addEventHandler:^(id sender) {
        if (self.register_Block) {
            self.register_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.login_button bk_addEventHandler:^(id sender) {
        if (self.phone_textField.text.length == 0) {
            [NSObject showHudTipStr:@"手机号码不能为空!"];
            return;
        }
        if (self.pwd_textField.text.length == 0) {
            [NSObject showHudTipStr:@"密码不能为空!"];
            return;
        }
        if (self.login_Block) {
            self.login_Block(self.phone_textField.text,self.pwd_textField.text);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)forgetBtn:(id)sender {
    if (self.forget_Block) {
        self.forget_Block();
    }
}


@end
