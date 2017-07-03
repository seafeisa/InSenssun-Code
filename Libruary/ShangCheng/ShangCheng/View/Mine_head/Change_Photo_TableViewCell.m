//
//  Change_Photo_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Change_Photo_TableViewCell.h"

@interface Change_Photo_TableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField *phonet_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UIButton *sure_button;

@end

@implementation Change_Photo_TableViewCell
- (IBAction)code_button:(id)sender {
    if (self.code_Block) {
        self.code_Block(self.phonet_tf.text);
    }
}
- (IBAction)make_sure_button:(id)sender {
    if (self.phonet_tf.text.length == 0) {
        [NSObject showHudTipStr:@"手机号码不能为空!"];
        return;
    }
    if ([NSString valiMobile:self.phonet_tf.text] == NO) {
        [NSObject showHudTipStr:@"请输入正确的手机号码"];
        return;
    }
    if (self.code_tf.text.length == 0) {
        [NSObject showHudTipStr:@"验证码不能为空!"];
        return;
    }
    if (self.nextStep_Block) {
        self.nextStep_Block(self.phonet_tf.text, self.code_tf.text);
    }
}

- (void)cellForNewPhone {
    self.phonet_tf.enabled = YES;
    [self.sure_button setTitle:@"确定" forState:0];
}

- (void)cellForOldPhone {
    self.phonet_tf.enabled = NO;
    self.phonet_tf.text = [Login_Total curLoginUser].phone;
    [self.sure_button setTitle:@"下一步" forState:0];
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
