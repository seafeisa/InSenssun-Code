//
//  Change_Address_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Change_Address_TableViewCell.h"

@interface Change_Address_TableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField *name_textField;
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *address_textField;

@end

@implementation Change_Address_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.name_textField addTarget:self action:@selector(getName) forControlEvents:UIControlEventEditingChanged];
    
    [self.address_textField addTarget:self action:@selector(getAdress) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)getName {
    if (self.name_textField.text.length > 15) {
        self.name_textField.text = [self.name_textField.text substringWithRange:NSMakeRange(0, 15)];
        [NSObject showHudTipStr:@"姓名最多只能15个字"];
    }
}

- (void)getAdress {
    
}

- (IBAction)save_Address_button:(id)sender {
    if (self.name_textField.text.length < 2) {
        [NSObject showHudTipStr:@"姓名最少需要2个字"];
        return;
    }
    if (self.phone_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入您的手机号"];
        return;
    }
    if ([NSString valiMobile:self.phone_textField.text] == NO) {
        [NSObject showHudTipStr:@"请输入正确的手机号"];
        return;
    }
    if (self.address_textField.text.length == 0) {
        [NSObject showHudTipStr:@"请输入详细的收货地址"];
        return;
    }
    if (self.change_Address_Block) {
        self.change_Address_Block(self.name_textField.text, self.phone_textField.text, self.address_textField.text);
    }
}


@end
