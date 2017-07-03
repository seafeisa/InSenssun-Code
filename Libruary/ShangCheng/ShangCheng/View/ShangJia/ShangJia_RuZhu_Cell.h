//
//  ShangJia_RuZhu_Cell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangJia_RuZhu_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo_shop_image;
@property (weak, nonatomic) IBOutlet UIImageView *picture_yingye_image;

@property (weak, nonatomic) IBOutlet UIImageView *xinyong_image;

@property (weak, nonatomic) IBOutlet UIImageView *kaihuxuke_image;



@property (nonatomic,copy)void(^photo_shop_Block)();
@property (nonatomic,copy)void(^picture_Block)();
@property (nonatomic,copy)void(^xinyong_Block)();
@property (nonatomic,copy)void(^kaihuxuke_Block)();


@property (nonatomic,copy)void(^joinShop_Block)(NSString *shop_name,NSString *shop_desc,NSString *shop_linkman,NSString *shop_tel);

@property (nonatomic,copy)void(^protocal_Block)();
@end
