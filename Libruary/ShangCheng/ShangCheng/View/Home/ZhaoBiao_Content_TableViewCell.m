//
//  ZhaoBiao_Content_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ZhaoBiao_Content_TableViewCell.h"

@interface ZhaoBiao_Content_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *info_label;

@end

@implementation ZhaoBiao_Content_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setZhaoBiao:(Home_ZhaoBiao *)zhaoBiao {
    _zhaoBiao = zhaoBiao;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:zhaoBiao.img] placeholderImage:[UIImage imageNamed:@"img_zhaobiao"]];
    self.name_label.text = zhaoBiao.title;
    self.info_label.text = zhaoBiao.content;
    self.time_label.text = zhaoBiao.addtime;
}

@end
