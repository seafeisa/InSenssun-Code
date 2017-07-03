//
//  Order_Things_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Order_Things_Cell.h"

@interface Order_Things_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *num_label;

@end

@implementation Order_Things_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"mid_logo"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = contentDic[@"goods_name"];
    self.price_label.text = [NSString stringWithFormat:@"¥ %@",contentDic[@"shop_price"]];
    self.num_label.text = [NSString stringWithFormat:@"* %@",contentDic[@"goods_number"]];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
//    self.num_label.t ext = [NSString stringWithFormat:@"* %@",dataDic[@"goods_number"]];
}

@end
