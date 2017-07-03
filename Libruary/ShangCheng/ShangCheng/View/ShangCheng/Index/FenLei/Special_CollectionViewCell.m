//
//  Special_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Special_CollectionViewCell.h"

@interface Special_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_price_label;
@property (weak, nonatomic) IBOutlet UILabel *red_price_label;
@property (weak, nonatomic) IBOutlet UIButton *shopcart_button;
@property (weak, nonatomic) IBOutlet UILabel *xiaoLiang_label;

@end

@implementation Special_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHotShop:(Seller_HotShop *)hotShop {
    _hotShop = hotShop;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:hotShop.mid_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xeeeeee"]]];
    self.name_label.text = hotShop.goods_name;
    self.red_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.shop_price];
    self.gray_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.market_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.gray_price_label.text attributes:attribtDic];
    self.gray_price_label.attributedText = attribtStr;
    self.xiaoLiang_label.text = [NSString stringWithFormat:@"销量%@",hotShop.goods_sales_num];
}

@end
