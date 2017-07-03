//
//  Index_Like_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Index_Like_Cell.h"
#import "Like_View.h"

@interface Index_Like_Cell ()

@property (weak, nonatomic) IBOutlet UIView *collect_view;

@end

@implementation Index_Like_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Like_View
    
    Like_View *small_view = [[[NSBundle mainBundle]loadNibNamed:@"Like_View" owner:nil options:nil]firstObject];
    [self.collect_view addSubview:small_view];
    [small_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}


@end
