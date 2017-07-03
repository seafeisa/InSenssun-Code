//
//  Goods_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Goods_CollectionViewCell.h"

@interface Goods_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *desc_label;
@property (weak, nonatomic) IBOutlet UILabel *count_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;

@end

@implementation Goods_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDic:(NSDictionary *)dic {
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:dic[@"mid_logo"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = dic[@"goods_name"];
    self.desc_label.text = [NSString stringWithFormat:@"%@",dic[@"goods_desc"]];
    self.count_label.text = [NSString stringWithFormat:@"* %@",dic[@"goods_number"]];
    self.price_label.text = [NSString stringWithFormat:@"¥ %@",dic[@"shop_price"]];
}

@end
