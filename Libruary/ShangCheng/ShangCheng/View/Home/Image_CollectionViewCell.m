//
//  Image_CollectionViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Image_CollectionViewCell.h"

@interface Image_CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;

@end

@implementation Image_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.bg_image sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"shangjia_col_img"]];
}

@end
