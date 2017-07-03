//
//  Book_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Book_TableViewCell.h"

@interface Book_TableViewCell (){
    NSString *type;
}
@property (weak, nonatomic) IBOutlet UITextField *name_textField;
@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UIView *select_view;
@property (weak, nonatomic) IBOutlet UILabel *zhaoBiao_label;
@property (weak, nonatomic) IBOutlet UILabel *qiuBiao_label;
@property (weak, nonatomic) IBOutlet UITextView *content_textView;
@property (weak, nonatomic) IBOutlet UITextField *person_textField;
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *select_height;

@end

@implementation Book_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.select_view.hidden = YES;
    self.select_height.constant = 0;
    
    self.type_label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addSelectView)];
    [self.type_label addGestureRecognizer:tap];
    
    type = @"1";
    
}

- (void)addSelectView {
    self.select_view.hidden = NO;
    self.select_height.constant = 81;
    
    self.zhaoBiao_label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhaoBiao)];
    [self.zhaoBiao_label addGestureRecognizer:tap1];
    
    self.qiuBiao_label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qiuBiao)];
    [self.qiuBiao_label addGestureRecognizer:tap2];
}

- (void)zhaoBiao {
    self.type_label.text = @"招标";
    self.select_view.hidden = YES;
    self.select_height.constant = 0;
    type = @"1";
}

- (void)qiuBiao {
    self.type_label.text = @"求标";
    self.select_view.hidden = YES;
    self.select_height.constant = 0;
    type = @"2";
}

- (IBAction)add_button:(id)sender {
    if (self.addPicture_Block) {
        self.addPicture_Block();
    }
}

- (IBAction)send_button:(id)sender {
    if (self.name_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入标书名称"];
        return;
    }
    if (self.content_textView.text.length == 0) {
        [NSObject showHudTipStr:@"请输入标书内容"];
        return;
    }
    if (self.person_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入联系人"];
        return;
    }
    if (self.phone_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入联系方式"];
        return;
    }
    if ([NSString valiMobile:self.phone_textField.text] == NO) {
        [NSObject showHudTipStr:@"请输入正确的联系方式"];
        return;
    }
    if (self.SendBook_Block) {
        self.SendBook_Block(self.name_textField.text, self.content_textView.text, type, self.person_textField.text, self.phone_textField.text);
    }
}

@end
