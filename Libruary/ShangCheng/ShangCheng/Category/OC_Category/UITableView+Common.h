//
//  UITableView+Common.h
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/10.
//  Copyright © 2016年 youde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITapImageView.h"

@interface UITableView (Common)

- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr andBlock:(void(^)(id obj))tapAction;
- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color andBlock:(void(^)(id obj))tapAction;
- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color leftNoticeColor:(UIColor*)noticeColor andBlock:(void(^)(id obj))tapAction;

@end
