//
//  Zhao_Qiu_Select_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Zhao_Qiu_Select_Cell.h"

@interface Zhao_Qiu_Select_Cell ()
@property (weak, nonatomic) IBOutlet UIButton *zhao_button;
@property (weak, nonatomic) IBOutlet UIButton *qiu_button;
@property (weak, nonatomic) IBOutlet UILabel *zhao_label;
@property (weak, nonatomic) IBOutlet UILabel *qiu_label;

@end

@implementation Zhao_Qiu_Select_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zhao_button.selected = YES;
    self.zhao_label.backgroundColor = MainColor;
    [self.zhao_button bk_addEventHandler:^(id sender) {
        self.zhao_button.selected = YES;
        self.zhao_label.backgroundColor = MainColor;
        self.qiu_button.selected = NO;
        self.qiu_label.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
        if (self.zhaoBiao_Block) {
            self.zhaoBiao_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.qiu_button bk_addEventHandler:^(id sender) {
        self.zhao_button.selected = NO;
        self.zhao_label.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
        self.qiu_button.selected = YES;
        self.qiu_label.backgroundColor = MainColor;
        if (self.qiuBiao_Block) {
            self.qiuBiao_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
}



@end
