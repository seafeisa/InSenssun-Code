//
//  List_Head_ReusableView.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface List_Head_ReusableView : UICollectionReusableView
@property (nonatomic,strong)void(^zonghe_Block)();
@property (nonatomic,strong)void(^xiaoliang_Block)();
@property (nonatomic,strong)void(^jiage_Block)();
@end
