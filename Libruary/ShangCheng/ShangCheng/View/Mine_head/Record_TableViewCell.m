//
//  Record_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/5/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Record_TableViewCell.h"

@interface Record_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *read_label;
@property (weak, nonatomic) IBOutlet UILabel *state_label;

@end

@implementation Record_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"img"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.title_label.text = contentDic[@"title"];
    self.time_label.text = contentDic[@"addtime"];
    self.read_label.text = [NSString stringWithFormat:@"%@人浏览过",contentDic[@"browse_num"]];
    self.state_label.text = contentDic[@"status"];
}

@end
