//
//  List_Content_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "List_Content_Cell.h"

@interface List_Content_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *red_price_label;
@property (weak, nonatomic) IBOutlet UILabel *gary_price_label;
@property (weak, nonatomic) IBOutlet UILabel *xiaoliang_label;
@property (weak, nonatomic) IBOutlet UILabel *pingjia_label;

@end

@implementation List_Content_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShop:(ZongHe_Shop *)shop {
    _shop = shop;
    if (shop.logo) {
        [self.icon_image sd_setImageWithURL:[NSURL URLWithString:shop.logo] placeholderImage:[UIImage imageNamed:@"img_fenlei"]];
    }
    if (shop.mid_logo) {
        [self.icon_image sd_setImageWithURL:[NSURL URLWithString:shop.mid_logo] placeholderImage:[UIImage imageNamed:@"img_fenlei"]];
    }
    self.name_label.text = shop.goods_name;
    self.red_price_label.text = [NSString stringWithFormat:@"¥%@",shop.shop_price];
    self.gary_price_label.text = [NSString stringWithFormat:@"¥%@",shop.market_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.gary_price_label.text attributes:attribtDic];
    self.gary_price_label.attributedText = attribtStr;
    
    self.xiaoliang_label.text = [NSString stringWithFormat:@"销量%@",shop.goods_sales_num];
    self.pingjia_label.text = [NSString stringWithFormat:@"%@条评价",shop.plnum];
}

@end
