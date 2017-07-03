//
//  Order_pay_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Order_pay_TableViewCell : UITableViewCell
@property (nonatomic,copy)void(^sure_pay_Block)(BOOL isWechat);

- (void)cellForYaJinWithString:(NSString *)yajin;

- (void)cellForPay;

@end
