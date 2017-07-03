//
//  Zhao_Qiu_Content_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Zhao_Qiu_Content_Cell.h"

@interface Zhao_Qiu_Content_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *desc_labelk;

@end

@implementation Zhao_Qiu_Content_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setZhaobiao:(Zhao_Qiu_Biao *)zhaobiao {
    _zhaobiao = zhaobiao;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:zhaobiao.img] placeholderImage:[UIImage imageNamed:@"img_zhaobiao"]];
    self.title_label.text = zhaobiao.title;
    self.desc_labelk.text = zhaobiao.content;
    self.time_label.text = zhaobiao.addtime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
