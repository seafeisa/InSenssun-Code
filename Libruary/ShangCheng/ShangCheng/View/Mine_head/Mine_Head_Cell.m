//
//  Mine_Head_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_Head_Cell.h"

@interface Mine_Head_Cell ()
@property (weak, nonatomic) IBOutlet UIButton *login_button;
@property (weak, nonatomic) IBOutlet UIButton *account_set_button;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@end

@implementation Mine_Head_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.account_set_button bk_addEventHandler:^(id sender) {
        if (self.accountSet_Block) {
            self.accountSet_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.login_button bk_addEventHandler:^(id sender) {
        if (self.login_Block) {
            self.login_Block();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setIconImage:(NSString *)iconImage {
    
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:iconImage] placeholderImage:[UIImage imageNamed:@"head_img_my.png"]];
    
    if ([Login_Total curLoginUser].id) {
        self.account_set_button.hidden = NO;
    }else{
        self.account_set_button.hidden = YES;
    }
    
    if ([Login_Total curLoginUser].nicheng){
        [self.login_button setTitle:[Login_Total curLoginUser].nicheng forState:0];
        self.login_button.enabled = NO;
    }else{
        [self.login_button setTitle:@"登录/注册" forState:0];
        self.login_button.enabled = YES;
    }

}


@end
