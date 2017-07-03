//
//  Order_pay_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Order_pay_TableViewCell.h"

@interface Order_pay_TableViewCell (){
    BOOL isWechat;
}
@property (weak, nonatomic) IBOutlet UIButton *wechat_button;
@property (weak, nonatomic) IBOutlet UIButton *ali_button;
@property (weak, nonatomic) IBOutlet UIView *yaJin_View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yaJin_Height;
@property (weak, nonatomic) IBOutlet UILabel *info_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (weak, nonatomic) IBOutlet UILabel *yaJin_label;
@end

@implementation Order_pay_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.wechat_button.selected = YES;
    self.wechat_button.layer.borderColor = MainColor.CGColor;
    self.ali_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    isWechat = YES;
}

- (void)cellForYaJinWithString:(NSString *)yajin{
    self.yaJin_View.hidden = NO;
    
    self.info_label.text = @"为何缴纳押金？1.押金为使用通信家园的商家缴纳的保证金。2.押金的主要用途为协议的一部分，为了更好的保障消费者，提升经营以下类目商品卖家的服务水平和商品质量。3.押金可原路退回。";
    
    CGRect rect = [self.info_label.text boundingRectWithSize:CGSizeMake(kScreen_Width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.yaJin_Height.constant = rect.size.height + 40;
    
    self.top.constant = rect.size.height + 40 + 30 + 30;
    
    self.yaJin_label.text = [NSString stringWithFormat:@"%@ 元",yajin];
}

- (void)cellForPay{
    self.yaJin_View.hidden = YES;
    self.top.constant = 30;
}


- (IBAction)wechat_button:(id)sender {
    isWechat = YES;
    self.wechat_button.selected = YES;
    self.ali_button.selected = NO;
    self.wechat_button.layer.borderColor = MainColor.CGColor;
    self.ali_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (IBAction)aliButton:(id)sender {
    isWechat = NO;
    self.wechat_button.selected = NO;
    self.ali_button.selected = YES;
    self.ali_button.layer.borderColor = MainColor.CGColor;
    self.wechat_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (IBAction)sure_pay_button:(id)sender {
    if (self.sure_pay_Block) {
        self.sure_pay_Block(isWechat);
    }
}

@end
