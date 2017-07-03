//
//  Reback_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Reback_TableViewCell.h"

@interface Reback_TableViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *myText_view;
@property (weak, nonatomic) IBOutlet UILabel *tips_label;
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *name_textField;

@end

@implementation Reback_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (IBAction)submit_button:(id)sender {
    
    if (self.name_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入您的真实姓名"];
        return;
    }
    
    if (self.phone_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入您的联系方式"];
        return;
    }
    
    if ([NSString valiMobile:self.phone_textField.text] == NO) {
        [NSObject showHudTipStr:@"请输入正确的联系方式"];
        return;
    }
    
    if (self.myText_view.text.length == 0) {
        [NSObject showHudTipStr:@"请填写您的建议或意见"];
        return;
    }
    
    if (self.reback_blcok) {
        self.reback_blcok(self.myText_view.text,self.phone_textField.text,self.name_textField.text);
    }
    
}


@end
