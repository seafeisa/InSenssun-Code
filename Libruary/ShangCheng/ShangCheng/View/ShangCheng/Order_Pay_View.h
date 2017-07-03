//
//  Order_Pay_View.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Order_Pay_View : UIView
@property (nonatomic,strong)NSDictionary *contentDic;
@property (nonatomic,copy)void(^pay_Block)(NSString *totalPrice);
@end
