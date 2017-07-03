//
//  PingJia_Content_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "PingJia_Content_TableViewCell.h"

@interface PingJia_Content_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *sales_label;

@end

@implementation PingJia_Content_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"mid_logo"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = contentDic[@"goods_name"];
    self.sales_label.text = [NSString stringWithFormat:@"%@",contentDic[@"goods_desc"]];
}


@end
