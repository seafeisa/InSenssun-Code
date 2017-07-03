//
//  UIView+Common.m
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/10.
//  Copyright © 2016年 youde. All rights reserved.
//

#import "UIView+Common.h"
#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007
#import <objc/runtime.h>
#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>
#define kShoppingCart @"ShoppingCart"
#define kSearchResult @"SearchResult"
//#import "Login.h"

@implementation UIView (Common)

static char LoadingViewKey;

@dynamic borderColor,borderWidth,cornerRadius, masksToBounds;

-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    [self.layer setMasksToBounds:masksToBounds];
}

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor hexStringToColor:@"0xdddddd"].CGColor;
}

- (void)doNotCircleFrame{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if (!color) {
        self.layer.borderColor = [UIColor hexStringToColor:@"0xdddddd"].CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}

- (UIViewController *)findViewController
{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type {
    if(pointRadius < 1) {
        return;
    }
    
    [self removeBadgePoint];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor redColor];
    
    switch (type) {
        case BadgePositionTypeMiddle:
        {
            badgeView.frame = CGRectMake(0, self.frame.size.height / 2 - pointRadius, 2 * pointRadius, 2 * pointRadius);
        }
            break;
            
        default:
        {
            badgeView.frame = CGRectMake(self.frame.size.width - 2 * pointRadius, 0, 2 * pointRadius, 2 * pointRadius);
        }
            break;
    }
    
    [self addSubview:badgeView];
}

- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point {
    if(pointRadius < 1) {
        return;
    }
    
    [self removeBadgePoint];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor hexStringToColor:@"0xff0000"];
    badgeView.frame = CGRectMake(0, 0, 2 * pointRadius, 2 * pointRadius);
    badgeView.center = point;
    [self addSubview:badgeView];
}

- (void)removeBadgePoint {
    for (UIView *subView in self.subviews) {
        if(subView.tag == kTagBadgePointView) {
            [subView removeFromSuperview];
        }
    }
}

//- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
//    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
//        [self removeBadgeTips];
//    } else {
//        UIView *badgeV = [self viewWithTag:kTagBadgeView];
//        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
//            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
//            badgeV.hidden = NO;
//        } else {
//            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
//            badgeV.tag = kTagBadgeView;
//            [self addSubview:badgeV];
//        }
//        [badgeV setCenter:center];
//    }
//}

//- (void)addBadgeTip:(NSString *)badgeValue{
//    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
//        [self removeBadgeTips];
//    } else {
//        UIView *badgeV = [self viewWithTag:kTagBadgeView];
//        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
//            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
//        }else{
//            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
//            badgeV.tag = kTagBadgeView;
//            [self addSubview:badgeV];
//        }
//        CGSize badgeSize = badgeV.frame.size;
//        CGSize selfSize = self.frame.size;
//        CGFloat offset = 2.0;
//        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
//                                      (offset +badgeSize.height/2))];
//    }
//}

//- (void)removeBadgeTips{
//    NSArray *subViews =[self subviews];
//    if (subViews && [subViews count] > 0) {
//        for (UIView *aView in subViews) {
//            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
//                aView.hidden = YES;
//            }
//        }
//    }
//}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGFloat)maxXOfFrame{
    return CGRectGetMaxX(self.frame);
}

- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

// 处理颜色渐变
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) { // locations 渐变颜色的区间分布，locations的数组长度和colors一致，这个值一般不用管它，默认是nil，会平均分布
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint; // 映射locations中第一个位置，用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)
    layer.endPoint = endPoint; // 映射locations中最后一个位置，用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0) type 默认值是kCAGradientLayerAxial，表示按像素均匀变化。除了默认值也无其它选项
    [self.layer addSublayer:layer];
}

//+ (CGRect)frameWithOutNav{
//    CGRect frame = kScreen_Bounds;
//    frame.size.height -= (20+44);//减去状态栏、导航栏的高度
//    return frame;
//}

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY{
    return [self lineViewWithPointYY:pointY andColor:[UIColor hexStringToColor:@"0xc8c7cc"]];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, kScreen_Width - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);
    
    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}

- (void)outputSubviewTree{
    [UIView outputTreeInView:self withSeparatorCount:0];
}

- (void)addBorder {
    self.borderColor = [UIColor hexStringToColor:@"0xf6f6f6"];
    self.borderWidth = 0.5f;
}

- (void)addBorderWithColor:(NSString *)colorStr {
    self.borderColor = [UIColor hexStringToColor:colorStr];
    self.borderWidth = 0.5f;
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:[UIColor hexStringToColor:@"0xc8c7cc"]];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

// 添加圆角 UIRectCorner 顶左 顶右 底左 底右 所有的角
- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CGSize)doubleSizeOfFrame{
    CGSize size = self.frame.size;
    return CGSizeMake(size.width*2, size.height*2);
}

#pragma mark LoadingView
- (void)setLoadingView:(EaseLoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (EaseLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading{
//    for (UIView *aView in [self.blankPageContainer subviews]) {
//        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
//            return;
//        }
//    }
    if (!self.loadingView) {
        self.loadingView = [[EaseLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    if ([self isMemberOfClass:[UITableView class]]) {
        
    }
    else if ([self isMemberOfClass:[UICollectionView class]]) {
        
    }
    else if ([self isMemberOfClass:[TPKeyboardAvoidingTableView class]]) {
        
    }
    else {
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.self.edges.equalTo(self);
        }];
    }
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
}

#pragma mark BlankPageView
//- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
//    [self willChangeValueForKey:@"BlankPageViewKey"];
//    objc_setAssociatedObject(self, &BlankPageViewKey,
//                             blankPageView,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self didChangeValueForKey:@"BlankPageViewKey"];
//}

//- (EaseBlankPageView *)blankPageView{
//    return objc_getAssociatedObject(self, &BlankPageViewKey);
//}

//- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
//    if (hasData) {
//        if (self.blankPageView) {
//            self.blankPageView.hidden = YES;
//            [self.blankPageView removeFromSuperview];
//        }
//    }else{
//        if (!self.blankPageView) {
//            self.blankPageView = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
//        }
//        self.blankPageView.hidden = NO;
//        [self.blankPageContainer addSubview:self.blankPageView];
//        
////        if ([self isMemberOfClass:[UITableView class]] || [self isMemberOfClass:[TPKeyboardAvoidingTableView class]] || [self isMemberOfClass:[UICollectionView class]]) {
////            @weakify(self);
////            [self.blankPageView mas_makeConstraints:^(MASConstraintMaker *make) {
////                @strongify(self);
////                make.bottom.left.right.equalTo(self.blankPageContainer);
////                make.top.equalTo(self.blankPageContainer).offset(64.f);
////            }];
////        }
//        
//        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
//    }
//}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
        if ([aView isKindOfClass:[TPKeyboardAvoidingTableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end
