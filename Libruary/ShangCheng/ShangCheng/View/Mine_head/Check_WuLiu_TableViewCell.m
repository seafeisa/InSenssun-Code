//
//  Check_WuLiu_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/25.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Check_WuLiu_TableViewCell.h"

@interface Check_WuLiu_TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *compony_label;
@property (weak, nonatomic) IBOutlet UILabel *NO_label;

@end

@implementation Check_WuLiu_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    self.compony_label.text = contentDic[@"logistic_type"];
    self.NO_label.text = contentDic[@"logistic_no"];
}

@end
