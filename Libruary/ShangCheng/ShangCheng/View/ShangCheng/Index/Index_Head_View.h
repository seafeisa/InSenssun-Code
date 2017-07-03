//
//  Index_Head_View.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index_Head_View : UIView
@property (nonatomic,copy)void(^nextPage_Block)();
@property (nonatomic,copy)void(^url_Block)(NSInteger index);
@property (weak, nonatomic) IBOutlet UIView *my_head_view;
@property (nonatomic,strong)NSMutableArray *img_arr;
@property (nonatomic,copy)void(^shopCart_Block)();
@end
