//
//  Love_Goods_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Love_Goods_CollectionViewCell.h"

@interface Love_Goods_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UITapImageView *icon_image;

@end

@implementation Love_Goods_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(NSString *)image {
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
}

@end
