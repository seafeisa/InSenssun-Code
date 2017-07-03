//
//  List_Head_ReusableView.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "List_Head_ReusableView.h"

@interface List_Head_ReusableView ()
@property (weak, nonatomic) IBOutlet UIButton *zong_he_button;
@property (weak, nonatomic) IBOutlet UIButton *xiao_liang_button;
@property (weak, nonatomic) IBOutlet UIButton *price_button;

@end

@implementation List_Head_ReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.zong_he_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self.xiao_liang_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self.price_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    
    self.zong_he_button.selected = YES;
    [self.zong_he_button bk_addEventHandler:^(id sender) {
        self.zong_he_button.selected = YES;
        self.xiao_liang_button.selected = NO;
        self.price_button.selected = NO;
        if (self.zonghe_Block) {
            self.zonghe_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.xiao_liang_button bk_addEventHandler:^(id sender) {
        self.zong_he_button.selected = NO;
        self.xiao_liang_button.selected = YES;
        self.price_button.selected = NO;
        if (self.xiaoliang_Block) {
            self.xiaoliang_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.price_button bk_addEventHandler:^(id sender) {
        self.zong_he_button.selected = NO;
        self.xiao_liang_button.selected = NO;
        self.price_button.selected = YES;
        if (self.jiage_Block) {
            self.jiage_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
