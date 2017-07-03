//
//  Catory_View.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/20.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Catory_View : UIView
@property (nonatomic,copy)void(^getName_Block)(NSString *name,NSString *nameId);
@end
