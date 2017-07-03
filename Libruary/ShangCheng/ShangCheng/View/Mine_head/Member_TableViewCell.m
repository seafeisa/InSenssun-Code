//
//  Member_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/27.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Member_TableViewCell.h"

@interface Member_TableViewCell (){
    BOOL isWechat;
}
@property (weak, nonatomic) IBOutlet UIButton *wechat_button;
@property (weak, nonatomic) IBOutlet UIButton *ali_button;

@end

@implementation Member_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.wechat_button.selected = YES;
    self.wechat_button.layer.borderColor = MainColor.CGColor;
    self.ali_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    isWechat = YES;
    
}
- (IBAction)wechat_button:(id)sender {
    
    isWechat = YES;
    self.wechat_button.selected = YES;
    self.ali_button.selected = NO;
    self.wechat_button.layer.borderColor = MainColor.CGColor;
    self.ali_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (IBAction)ali_button:(id)sender {
    
    isWechat = NO;
    self.wechat_button.selected = NO;
    self.ali_button.selected = YES;
    self.ali_button.layer.borderColor = MainColor.CGColor;
    self.wechat_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (IBAction)sure_pay:(id)sender {
    if (self.sure_pay_Block) {
        self.sure_pay_Block(isWechat);
    }
}


@end
