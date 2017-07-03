//
//  Check_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/5/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Check_TableViewCell.h"

@implementation Check_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.content_textView.editable = NO;
}


@end
