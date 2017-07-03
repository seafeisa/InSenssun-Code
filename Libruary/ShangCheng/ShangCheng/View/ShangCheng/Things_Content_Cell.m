//
//  Things_Content_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Things_Content_Cell.h"

@interface Things_Content_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *red_price_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_price_label;
@property (weak, nonatomic) IBOutlet UILabel *sales_num_label;

@end

@implementation Things_Content_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    self.name_label.text = contentDic[@"goods_name"];
    self.red_price_label.text = [NSString stringWithFormat:@"¥ %@",contentDic[@"shop_price"]];
    self.gray_price_label.text = [NSString stringWithFormat:@"¥ %@",contentDic[@"market_price"]];
    self.sales_num_label.text = [NSString stringWithFormat:@"销量%@",contentDic[@"goods_sales_num"]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.gray_price_label.text attributes:attribtDic];
    self.gray_price_label.attributedText = attribtStr;
}

@end
