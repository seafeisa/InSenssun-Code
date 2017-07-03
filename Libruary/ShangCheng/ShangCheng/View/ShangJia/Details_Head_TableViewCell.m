//
//  Details_Head_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Details_Head_TableViewCell.h"

@interface Details_Head_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@end

@implementation Details_Head_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetails:(Shop_Details_MTL *)details {
    _details = details;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:details.shop_logo] placeholderImage:[UIImage imageNamed:@"shangjia_col_img.png"]];
}

@end
