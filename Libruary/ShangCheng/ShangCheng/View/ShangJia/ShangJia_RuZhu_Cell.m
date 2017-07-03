//
//  ShangJia_RuZhu_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ShangJia_RuZhu_Cell.h"

@interface ShangJia_RuZhu_Cell ()
@property (weak, nonatomic) IBOutlet UIButton *photo_button;
@property (weak, nonatomic) IBOutlet UITextField *name_textField;
@property (weak, nonatomic) IBOutlet UITextField *tel_textField;
@property (weak, nonatomic) IBOutlet UITextField *link_textField;
@property (weak, nonatomic) IBOutlet UITextView *intro_textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photo_height;

@property (weak, nonatomic) IBOutlet UIButton *protocal_button;

@end

@implementation ShangJia_RuZhu_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.protocal_button.currentTitle];
    
    NSRange range = [self.protocal_button.currentTitle rangeOfString:@"商家入驻协议"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.protocal_button.titleLabel.attributedText = AttributedStr;
    
}
- (IBAction)shangjia_photo_Button:(id)sender {
    if (self.photo_shop_Block) {
        self.photo_shop_Block();
    }
}
- (IBAction)yingYe_picture_button:(id)sender {
    if (self.picture_Block) {
        self.picture_Block();
    }
}


- (IBAction)xinyong_button:(id)sender {
    if (self.xinyong_Block) {
        self.xinyong_Block();
    }
}


- (IBAction)kaihuxuke_button:(id)sender {
    if (self.kaihuxuke_Block) {
        self.kaihuxuke_Block();
    }
}



- (IBAction)join_button:(id)sender {
    if (self.name_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入商家名称"];
        return;
    }
    if (self.intro_textView.text.length == 0) {
        [NSObject showHudTipStr:@"请输入商家介绍"];
        return;
    }
    if (self.link_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入联系人"];
        return;
    }
    if (self.tel_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入联系方式"];
        return;
    }
    if ([NSString valiMobile:self.tel_textField.text] == NO) {
        [NSObject showHudTipStr:@"请输入正确的联系方式"];
        return;
    }
    if (self.joinShop_Block) {
        self.joinShop_Block(self.name_textField.text, self.intro_textView.text, self.link_textField.text, self.tel_textField.text);
    }
}

- (IBAction)protocal_button:(id)sender {
    if (self.protocal_Block) {
        self.protocal_Block();
    }
}

@end
