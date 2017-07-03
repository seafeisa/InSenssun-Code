//
//  Mine_Account_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_Account_Cell.h"

@interface Mine_Account_Cell ()

@end

@implementation Mine_Account_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setIconImage:(NSString *)iconImage {
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:iconImage] placeholderImage:[UIImage imageNamed:@"head_img_my.png"]];
}

@end
