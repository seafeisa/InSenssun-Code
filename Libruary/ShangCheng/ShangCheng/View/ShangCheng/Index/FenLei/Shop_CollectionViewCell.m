//
//  Shop_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Shop_CollectionViewCell.h"

@interface Shop_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *qiang_gou_button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_width;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *red_price_label;
@property (weak, nonatomic) IBOutlet UILabel *gray_price_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;

@end

@implementation Shop_CollectionViewCell

- (void)setHotShop:(Seller_HotShop *)hotShop {
    _hotShop = hotShop;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:hotShop.mid_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xeeeeee"]]];
    self.name_label.text = hotShop.goods_name;
    self.red_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.shop_price];
    self.gray_price_label.text = [NSString stringWithFormat:@"¥%@",hotShop.market_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.gray_price_label.text attributes:attribtDic];
    self.gray_price_label.attributedText = attribtStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.image_width.constant = (kScreen_Width - 30) / 3 - 20;
//    self.image_height.constant = self.image_width.constant / 1.2;
    
}

@end
