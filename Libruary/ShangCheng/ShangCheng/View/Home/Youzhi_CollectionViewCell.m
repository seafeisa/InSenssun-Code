//
//  Youzhi_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Youzhi_CollectionViewCell.h"

@interface Youzhi_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *info_label;

@end

@implementation Youzhi_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
}

- (void)setYouzhishop:(Youzhi_Shop *)youzhishop {
    _youzhishop = youzhishop;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:youzhishop.shop_logo] placeholderImage:[UIImage imageNamed:@"shangjia_col_img"]];
    self.name_label.text = youzhishop.shop_name;
    self.info_label.text = youzhishop.shop_desc;
}

@end
