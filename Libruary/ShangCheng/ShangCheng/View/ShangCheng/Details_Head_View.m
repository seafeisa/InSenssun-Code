//
//  Details_Head_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Details_Head_View.h"

@interface Details_Head_View (){
    UIButton *agoBtn;
    UILabel *agoLabel;
}
@property (weak, nonatomic) IBOutlet UIButton *shang_pin_button;
@property (weak, nonatomic) IBOutlet UIButton *details_button;
@property (weak, nonatomic) IBOutlet UIButton *ping_jia_button;
@property (weak, nonatomic) IBOutlet UILabel *shang_pin_label;
@property (weak, nonatomic) IBOutlet UILabel *xiang_qing_label;
@property (weak, nonatomic) IBOutlet UILabel *ping_jia_label;
@property (weak, nonatomic) IBOutlet UIView *button_view;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xiang_qing_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ping_jia_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shang_pin_width;


@end

@implementation Details_Head_View

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect rect = [@"商品" boundingRectWithSize:CGSizeMake(MAXFLOAT, 2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    NSArray *name = @[@"商品",@"详情",@"评价",@"分享"];
    CGFloat width = (kScreen_Width - (kScreen_Width / 8)) / name.count;
    for (int i = 0; i < name.count; i ++) {
        UIView *view = [[UIView alloc]init];
        [self.button_view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(width * i);
            make.width.mas_equalTo(width);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.tag = i;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(rect.size.width);
        }];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(buttonIndex:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:MainColor forState:UIControlStateSelected];
        [btn setTitle:name[i] forState:0];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        if (i == 0) {
            label.backgroundColor = MainColor;
            btn.selected = YES;
            agoBtn = btn;
            agoLabel = label;
        }
    }
}

- (void)buttonIndex:(UIButton *)btn {
    agoBtn.selected = NO;
    btn.selected = YES;
    agoBtn = btn;
    
    agoLabel.backgroundColor = [UIColor clearColor];
    for (id sub in [btn.superview subviews]) {
        if ([sub isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)sub;
            if (label.tag == btn.tag) {
                label.backgroundColor = MainColor;
                agoLabel = label;
            }
        }
    }
    
    if (btn.tag == 0) {
        if (self.shangPin_block) {
            self.shangPin_block();
        }
    }else if (btn.tag == 1) {
        if (self.xiangQing_block) {
            self.xiangQing_block();
        }
    }else if (btn.tag == 2) {
        if (self.pingJia_block) {
            self.pingJia_block();
        }
    }else {
        if (self.share_block) {
            self.share_block();
        }
    }
}

- (IBAction)return_button:(id)sender {
    if (self.return_block) {
        self.return_block();
    }
}


@end
