//
//  UITapImageView.h
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/13.
//  Copyright © 2016年 youde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;
- (void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void(^)(id obj))tapAction;
- (void)setImageWinthImageName:(NSString *)imageName tapBlock:(void(^)(id obj))tapAction;

@end

