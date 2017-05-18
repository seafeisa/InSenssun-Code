//
//  CutPicetureView.h
//  Picture
//
//  Created by yang kong on 12-6-25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CutPicetureView : UIView {
	UIImage *image;
	
	CGRect  leftUp ;
	CGRect  leftDown ;
	CGRect  rightUp;
	CGRect  rightDown;
	

}
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, readonly) CGRect CutRect;
@property (nonatomic, readonly) CGRect imageRect;

- (UIImage *)getCutPiceture;
- (void)setBgImage:(UIImage*)theImage andtheRect:(CGRect)theRect;
- (CGRect)getCutPicetureRect;
@end
