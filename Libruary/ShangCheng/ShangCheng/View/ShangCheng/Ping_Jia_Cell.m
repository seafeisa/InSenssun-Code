//
//  Ping_Jia_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Ping_Jia_Cell.h"

@interface Ping_Jia_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

@end

@implementation Ping_Jia_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPinglun:(PingLun_MTL *)pinglun {
    _pinglun = pinglun;
    self.icon_image.layer.cornerRadius = CGRectGetHeight(self.icon_image.frame) / 2;
    self.icon_image.layer.masksToBounds = YES;
    if (pinglun.touxiang) {
        [self.icon_image sd_setImageWithURL:[NSURL URLWithString:pinglun.touxiang] placeholderImage:[UIImage imageNamed:@"head_img_pingjia.png"]];
    }else{
        [self.icon_image sd_setImageWithURL:[NSURL URLWithString:pinglun.member_info[0][@"touxiang"]] placeholderImage:[UIImage imageNamed:@"head_img_pingjia.png"]];
    }
    if (pinglun.nicheng) {
        self.name_label.text = pinglun.nicheng;
    }else{
        self.name_label.text = pinglun.member_info[0][@"nicheng"];
    }
    self.time_label.text = pinglun.addtime;
    self.content_label.text = pinglun.content;
}

@end
