//
//  Mine_PingJia_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_PingJia_TableViewCell.h"

@interface Mine_PingJia_TableViewCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *red_label;
@property (weak, nonatomic) IBOutlet UILabel *sales_num_label;
@property (weak, nonatomic) IBOutlet UITextView *pingjia_textView;
@property (weak, nonatomic) IBOutlet UIButton *complete_button;


@end

@implementation Mine_PingJia_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.pingjia_textView.delegate = self;
    
//    CGFloat width = 70;
//    CGFloat row = ((kScreen_Width - 20) - 4 * 70) / 3;
//    for (int i = 0; i < 4; i ++) {
//        UITapImageView *image = [[UITapImageView alloc]init];
//        image.image = [UIImage imageNamed:@"takephoto"];
//        [self.bg_view addSubview:image];
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo((width + row) * i);
//            make.centerY.mas_equalTo(0);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(width);
//        }];
//    }
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:contentDic[@"mid_logo"]] placeholderImage:[UIImage imageNamed:@"img_fenlei.png"]];
    self.name_label.text = contentDic[@"goods_name"];
    self.red_label.text = [NSString stringWithFormat:@"¥ %@",contentDic[@"shop_price"]];
    self.sales_num_label.text = [NSString stringWithFormat:@"月销量 %@ 件",contentDic[@"goods_sales_num"]];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 165) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (IBAction)complete_button:(id)sender {
    if (self.pingjia_textView.text.length == 0) {
        [NSObject showHudTipStr:@"请输入评价信息"];
        return;
    }
    if (self.pingJia_Block) {
        self.pingJia_Block(self.pingjia_textView.text);
    }
}


@end
