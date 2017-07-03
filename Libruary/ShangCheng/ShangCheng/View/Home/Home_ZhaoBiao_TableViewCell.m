//
//  Home_ZhaoBiao_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Home_ZhaoBiao_TableViewCell.h"

@interface Home_ZhaoBiao_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *more_button;

@end

@implementation Home_ZhaoBiao_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.more_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}
- (IBAction)more_button:(id)sender {
    if (self.more_Block) {
        self.more_Block();
    }
}

@end
