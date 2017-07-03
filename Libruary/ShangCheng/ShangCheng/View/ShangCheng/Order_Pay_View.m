//
//  Order_Pay_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Order_Pay_View.h"

@interface Order_Pay_View ()
@property (weak, nonatomic) IBOutlet UILabel *Pay_label;

@end

@implementation Order_Pay_View

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.Pay_label.layer.borderWidth = 1;
    self.Pay_label.layer.borderColor = [UIColor hexStringToColor:@"#eeeeee"].CGColor;
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    self.Pay_label.text = [NSString stringWithFormat:@"实付款：¥ %@",contentDic[@"data"][@"total_price"]];
}
- (IBAction)pay_button:(id)sender {
    if (self.pay_Block) {
        self.pay_Block(self.contentDic[@"data"][@"total_price"]);
    }
}

@end
