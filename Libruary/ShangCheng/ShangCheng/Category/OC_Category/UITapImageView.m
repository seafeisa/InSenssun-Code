//
//  UITapImageView.m
//  YoudeiOS2.0.0
//
//  Created by HML on 16/8/13.
//  Copyright © 2016年 youde. All rights reserved.
//

#import "UITapImageView.h"

@interface  UITapImageView ()

@property (nonatomic, copy) void(^tapAction)(id);

@end

@implementation UITapImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}


- (void)addTapBlock:(void(^)(id obj))tapAction{
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tap{
    if (self.tapAction) {
        self.tapAction(self);
    }
}

-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void(^)(id obj))tapAction{
    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
    [self addTapBlock:tapAction];
}

- (void)setImageWinthImageName:(NSString *)imageName tapBlock:(void (^)(id))tapAction {
    self.image = [UIImage imageNamed:imageName];
    self.contentMode = UIViewContentModeScaleAspectFit;
    [self addTapBlock:tapAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
