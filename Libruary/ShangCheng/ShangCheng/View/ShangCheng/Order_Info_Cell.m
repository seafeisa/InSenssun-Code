//
//  Order_Info_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Order_Info_Cell.h"

@interface Order_Info_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *address_label;
@property (weak, nonatomic) IBOutlet UILabel *tel_label;

@end

@implementation Order_Info_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    self.name_label.text = contentDic[@"shr_name"];
    self.address_label.text = contentDic[@"shr_address"];
    self.tel_label.text = contentDic[@"shr_tel"];
}

@end
