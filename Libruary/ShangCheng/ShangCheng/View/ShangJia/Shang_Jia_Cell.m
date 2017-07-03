//
//  Shang_Jia_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Shang_Jia_Cell.h"

@interface Shang_Jia_Cell ()
@property (weak, nonatomic) IBOutlet UIView *main_view;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *review_label;
@property (weak, nonatomic) IBOutlet UIButton *details_button;

@end

@implementation Shang_Jia_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.main_view.layer.cornerRadius = 6;
    self.main_view.layer.masksToBounds = YES;
}

- (void)setOwner:(Shop_Owner *)owner {
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:owner.shop_logo] placeholderImage:[UIImage imageNamed:@"shangjia_col_img"]];
    self.name_label.text = owner.shop_name;
    self.review_label.text = [NSString stringWithFormat:@"%@人浏览过",owner.viewer];
}

@end
