//
//  Device_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Device_CollectionViewCell.h"

@interface Device_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *sales_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_label;

@end

@implementation Device_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic{
    _contentDic = contentDic;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"mid_logo"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = contentDic[@"goods_name"];
    
    
    self.sales_label.text = [NSString stringWithFormat:@"销量%@",contentDic[@"goods_sales_num"]];
    
    self.price_label.text = [NSString stringWithFormat:@"¥%@",contentDic[@"shop_price"]];
    
    self.gray_label.text = [NSString stringWithFormat:@"¥%@",contentDic[@"market_price"]];
    
    NSRange range = [self.gray_label.text rangeOfString:@"¥"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.gray_label.text];
    [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(range.location, self.gray_label.text.length)];
    self.gray_label.attributedText = AttributedStr;
    
}

@end
