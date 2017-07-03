//
//  Change_Info_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Change_Info_TableViewCell.h"

@interface Change_Info_TableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField *info_textField;
@property (weak, nonatomic) IBOutlet UILabel *tips_label;

@end

@implementation Change_Info_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.info_textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
}

- (void)changeText:(UITextField *)textField{
    if (self.change_name_Block) {
        self.change_name_Block(textField.text);
    }
}


@end
