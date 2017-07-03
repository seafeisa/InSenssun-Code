//
//  Register_cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Register_cell.h"

@interface Register_cell ()

@property (weak, nonatomic) IBOutlet UIButton *register_button;
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *code_textField;
@property (weak, nonatomic) IBOutlet UITextField *pwd_textfield;
@property (weak, nonatomic) IBOutlet UITextField *pwd_again_textField;
@property (weak, nonatomic) IBOutlet UIButton *protocal_button;

@end

@implementation Register_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.code_button bk_addEventHandler:^(id sender) {
        if (self.phone_textField.text.length == 0) {
            [NSObject showHudTipStr:@"手机号码不能为空!"];
            return;
        }
        if (self.code_Block) {
            self.code_Block(self.phone_textField.text);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.register_button bk_addEventHandler:^(id sender) {
        if (self.phone_textField.text.length == 0) {
            [NSObject showHudTipStr:@"手机号码不能为空!"];
            return;
        }
        if ([NSString valiMobile:self.phone_textField.text] == NO) {
            [NSObject showHudTipStr:@"请输入正确的手机号码"];
            return;
        }
        if (self.code_textField.text.length == 0) {
            [NSObject showHudTipStr:@"验证码不能为空!"];
            return;
        }
        if (self.pwd_textfield.text.length == 0) {
            [NSObject showHudTipStr:@"密码不能为空!"];
            return;
        }
        if (self.pwd_again_textField.text.length == 0) {
            [NSObject showHudTipStr:@"请再次输入密码!"];
            return;
        }
        if (![self.pwd_textfield.text isEqualToString:self.pwd_again_textField.text]) {
            [NSObject showHudTipStr:@"两次密码不一致!"];
            return;
        }
        if (self.register_Block) {
            self.register_Block(self.phone_textField.text,self.code_textField.text,self.pwd_textfield.text);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.protocal_button.currentTitle];
    
    NSRange range = [self.protocal_button.currentTitle rangeOfString:@"注册协议"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.protocal_button.titleLabel.attributedText = AttributedStr;
    
}

- (IBAction)protocal_button:(id)sender {
    if (self.protocal_Block) {
        self.protocal_Block();
    }
}

@end
