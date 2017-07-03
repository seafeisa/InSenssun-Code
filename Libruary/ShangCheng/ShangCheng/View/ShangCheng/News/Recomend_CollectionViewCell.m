//
//  Recomend_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/22.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Recomend_CollectionViewCell.h"

@interface Recomend_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_price_label;
@property (weak, nonatomic) IBOutlet UILabel *sales_num_label;
@property (weak, nonatomic) IBOutlet UILabel *pingjia_label;

@end

@implementation Recomend_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShop:(ZongHe_Shop *)shop {
    _shop = shop;
    
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:shop.logo] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = shop.goods_name;
    
    self.sales_num_label.text = [NSString stringWithFormat:@"销量%@",shop.goods_sales_num];
    self.pingjia_label.text = [NSString stringWithFormat:@"%@条评价",shop.plnum];

    self.price_label.text = [NSString stringWithFormat:@"¥%@",shop.shop_price];
    self.gray_price_label.text = [NSString stringWithFormat:@"¥%@",shop.market_price];
    NSRange range = [self.gray_price_label.text rangeOfString:shop.market_price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.gray_price_label.text];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(range.location - 1, range.length + 1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(range.location - 1, range.length + 1)];
    [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(range.location - 1, range.length + 1)];
    self.gray_price_label.attributedText = AttributedStr;
}

@end
