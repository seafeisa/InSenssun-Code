//
//  SC_Login_ViewController.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SC_Login_ViewController : UIViewController
@property (nonatomic,copy)void(^login_Block)();
@property (nonatomic,assign)BOOL IsQuitLogin;
@end
