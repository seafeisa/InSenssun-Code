//
//  ShowPicetureView.h
//  CutPicetureDemo
//
//  Created by yang kong on 12-6-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CutPicetureView.h"
@interface ShowPicetureView : UIView
{
}

@property (nonatomic, retain, readonly) UIImageView *showImageView;
@property (nonatomic, retain, readonly) CutPicetureView * CutView;
@property (nonatomic)NSInteger PortraitCount;

- (void)setBgImage:(UIImage*)theImage;
- (UIImage *)getCutPicetureByRect:(CGRect)theRect;
- (void)PortraitImage;
@end
