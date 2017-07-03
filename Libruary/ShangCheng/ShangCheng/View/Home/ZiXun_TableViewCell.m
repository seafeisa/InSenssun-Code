//
//  ZiXun_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ZiXun_TableViewCell.h"
#import "CCPScrollView.h"

@interface ZiXun_TableViewCell (){
    CCPScrollView *ccpView;
}
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIView *bg_view;

@end

@implementation ZiXun_TableViewCell

- (void)setNameArr:(NSArray *)nameArr {
    _nameArr = nameArr;
    
    for (id sub in [self.bg_view subviews]) {
        if ([sub isKindOfClass:[CCPScrollView class]]) {
            [sub removeFromSuperview];
        }
    }
    
    ccpView = [[CCPScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width - 89 - 55, 44)];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < nameArr.count; i ++) {
        NSDictionary *dic = nameArr[i];
        [array addObject:dic[@"content"]];
    }
    ccpView.titleArray = [NSArray arrayWithArray:array];
    
    ccpView.titleFont = 14;
    ccpView.titleColor = [UIColor blackColor];
    [ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        NSDictionary *dic = nameArr[index];
        if (self.getID_Block) {
            self.getID_Block(dic[@"url"]);
        }
    }];
    [self.bg_view addSubview:ccpView];
}
- (IBAction)more_button:(id)sender {
    if (self.moreButton_Block) {
        self.moreButton_Block();
    }
}


@end
