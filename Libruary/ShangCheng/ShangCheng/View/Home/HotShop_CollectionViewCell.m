//
//  HotShop_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "HotShop_CollectionViewCell.h"


@interface HotShop_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *red_price_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_price_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;

@end

@implementation HotShop_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellWithHotShop:(Seller_HotShop *)hotShop {
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:hotShop.mid_logo] placeholderImage:[UIImage imageNamed:@"img_fenlei"]];
    self.name_label.text = hotShop.goods_name;
    self.red_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.shop_price];
    self.gray_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.market_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.gray_price_label.text attributes:attribtDic];
    self.gray_price_label.attributedText = attribtStr;
}

@end
