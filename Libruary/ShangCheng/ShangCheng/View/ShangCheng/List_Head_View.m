//
//  List_Head_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "List_Head_View.h"

@interface List_Head_View ()
@property (weak, nonatomic) IBOutlet UIButton *return_button;

@end

@implementation List_Head_View

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.return_button bk_addEventHandler:^(id sender) {
        if (self.return_block) {
            self.return_block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
