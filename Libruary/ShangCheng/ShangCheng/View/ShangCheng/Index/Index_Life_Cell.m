//
//  Index_Life_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Index_Life_Cell.h"
#import "Life_view.h"

@interface Index_Life_Cell ()
@property (weak, nonatomic) IBOutlet UIView *content_view;

@end

@implementation Index_Life_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    Life_view *small_view = [[[NSBundle mainBundle]loadNibNamed:@"Life_view" owner:nil options:nil]firstObject];
    [self.content_view addSubview:small_view];
    [small_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
