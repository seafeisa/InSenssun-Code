//
//  More_Zixun_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "More_Zixun_TableViewCell.h"

@interface More_Zixun_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *last_label;

@end

@implementation More_Zixun_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"pic"]] placeholderImage:[UIImage imageNamed:@"img_zhaobiao"]];
    self.title_label.text = contentDic[@"title"];
    self.time_label.text = contentDic[@"content"];
    self.last_label.text = contentDic[@"addtime"];
}

@end
