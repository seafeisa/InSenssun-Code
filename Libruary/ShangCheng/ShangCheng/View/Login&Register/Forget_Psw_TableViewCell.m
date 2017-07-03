//
//  Forget_Psw_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Forget_Psw_TableViewCell.h"

@interface Forget_Psw_TableViewCell ()

@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *code_textField;
@property (weak, nonatomic) IBOutlet UITextField *psw_textField;

@end

@implementation Forget_Psw_TableViewCell
- (IBAction)code_button:(id)sender {
    if (self.phone_textField.text.length == 0) {
        [NSObject showHudTipStr:@"手机号码不能为空!"];
        return;
    }
    if (self.code_Block) {
        self.code_Block(self.phone_textField.text);
    }
}
- (IBAction)complete_button:(id)sender {
    
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
    if (self.psw_textField.text.length == 0) {
        [NSObject showHudTipStr:@"密码不能为空!"];
        return;
    }
    if (self.complete_Block) {
        self.complete_Block(self.phone_textField.text, self.code_textField.text, self.psw_textField.text);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
