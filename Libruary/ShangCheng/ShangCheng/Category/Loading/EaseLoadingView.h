//
//  EaseLoadingView.h
//  YoudeiOS2.0.0
//
//  Created by HML on 16/10/29.
//  Copyright © 2016年 youde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseLoadingView : UIView

@property (strong, nonatomic) UIImageView *loopView, *monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;

- (void)startAnimating;
- (void)stopAnimating;

@end
