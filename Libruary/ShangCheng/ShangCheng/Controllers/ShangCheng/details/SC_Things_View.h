//
//  SC_Things_View.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SC_Things_View : UIView
@property (nonatomic,copy)void(^next_block)(NSDictionary *dic);
@property (nonatomic,strong)NSMutableDictionary *contentDic;
@property (nonatomic,copy)void(^addCart_Block)();
@end
