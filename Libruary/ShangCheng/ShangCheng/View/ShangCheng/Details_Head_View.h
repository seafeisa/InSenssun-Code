//
//  Details_Head_View.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Details_Head_View : UIView
@property (nonatomic,copy)void(^return_block)();
@property (nonatomic,copy)void(^shangPin_block)();
@property (nonatomic,copy)void(^xiangQing_block)();
@property (nonatomic,copy)void(^pingJia_block)();
@property (nonatomic,copy)void(^share_block)();
@end
