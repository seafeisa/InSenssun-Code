//
//  CutPicetureView.m
//  Picture
//
//  Created by yang kong on 12-6-25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CutPicetureView.h"

#import "UIImage-Extensions.h"


#define CUTVIEW_WIDTH_MAX  (280)
#define CUTVIEW_HEIGHT_MAX (360)

#define CUTIMAGE_WIDTH_MAX (800)
#define CUTIMAGE_HEIGHT_MAX (480)

@implementation CutPicetureView

@synthesize image = _image;
@synthesize CutRect = _CutRect;
@synthesize imageRect;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
		 self.backgroundColor = [UIColor clearColor];
		//_CutRect=CGRectMake(0.0, 100.0, 280, 245-100);
        // Initialization code.

		
    }
    return self;
}

//This method just use in main thread
- (UIImage *) scaleFromImage:(UIImage *) theImage toSize: (CGSize) size
{
	NSLog(@"scaleFromImage.....");
    UIGraphicsBeginImageContext(size);
	//UIGraphicsBeginImageContextWithOptions
    [theImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [newImage retain];
}

- (UIImage *)tileForRect: (CGRect)tileRect image: (UIImage*)inImage
{
    CGImageRef tiledImage = CGImageCreateWithImageInRect([inImage CGImage], tileRect);
    UIImage *tileImage = [UIImage imageWithCGImage: tiledImage];
	CGSize size = CGSizeMake(CUTIMAGE_WIDTH_MAX, CUTIMAGE_HEIGHT_MAX);
    return [self scaleFromImage:tileImage toSize:size];
}
- (UIImage *)getCutPiceture
{
	CGRect rect1 =_CutRect;//self.frame;//[self.CutView CutRect];
	CGImageRef tiledImage  = [self.image CGImage];
	int w = CGImageGetWidth(tiledImage);
	int h = CGImageGetHeight(tiledImage);
	NSLog(@"image w = %d,h = %d",w,h);
	//CGSize size = CGSizeMake(w, h);
	
	int x = rect1.origin.x*w/imageRect.size.width;
	int y = rect1.origin.y*h/imageRect.size.height;
	int w1 = rect1.size.width*w/imageRect.size.width;
	int h1 = rect1.size.height*h/imageRect.size.height;
	NSLog(@"image w = %d,h = %d",w1,h1);
	CGRect rect = CGRectMake(x,y,w1,h1);
	
	return [self tileForRect:rect image:self.image];
	
}
- (CGRect)getCutPicetureRect
{
	return CGRectMake(_CutRect.origin.x-imageRect.origin.x, _CutRect.origin.y-imageRect.origin.y, _CutRect.size.width, _CutRect.size.height);
}
- (CGRect)setCutRectByPoints
{
	_CutRect=CGRectMake(leftUp.origin.x+13, leftUp.origin.y+13, rightDown.origin.x-leftUp.origin.x, rightDown.origin.y-leftUp.origin.y);

	return _CutRect;
}

- (void)setPointsByCutRect
{
	leftUp.origin =CGPointMake(_CutRect.origin.x-13, _CutRect.origin.y-13);
	rightDown.origin = CGPointMake(_CutRect.origin.x+_CutRect.size.width-13, _CutRect.origin.y+_CutRect.size.height-13);
	leftDown.origin=CGPointMake(_CutRect.origin.x-13, _CutRect.origin.y+_CutRect.size.height-13);
	rightUp.origin = CGPointMake(_CutRect.origin.x+_CutRect.size.width-13, _CutRect.origin.y-13);
//
//	_CutRect=CGRectMake(leftUp.origin.x+13, leftUp.origin.y+13, rightDown.origin.x-leftUp.origin.x, rightDown.origin.y-leftUp.origin.y);
	
//	return _CutRect;
}


- (CGSize)setCutPicetureFrameByImage:(UIImage*)theImage
{
	CGSize mySize;
	CGImageRef tiledImage  = [theImage CGImage];
	int w = CGImageGetWidth(tiledImage);
	int h = CGImageGetHeight(tiledImage);
	NSLog(@"theImage SIZE WIDTH = %d,height = %d",w,h);
	if(theImage.size.width > CUTVIEW_WIDTH_MAX)
	{
		mySize = CGSizeMake(CUTVIEW_WIDTH_MAX, theImage.size.height*(CUTVIEW_WIDTH_MAX/theImage.size.width));
		if(mySize.height > CUTVIEW_HEIGHT_MAX)
		{
			mySize = CGSizeMake(mySize.width*(CUTVIEW_HEIGHT_MAX/mySize.height), CUTVIEW_HEIGHT_MAX);
		}
	}
	else if(theImage.size.height > CUTVIEW_HEIGHT_MAX)
	{
		mySize = CGSizeMake(theImage.size.width*(CUTVIEW_HEIGHT_MAX/theImage.size.height), CUTVIEW_HEIGHT_MAX);
		if(mySize.width > CUTVIEW_HEIGHT_MAX)
		{
			mySize = CGSizeMake(CUTVIEW_WIDTH_MAX, mySize.height*(CUTVIEW_WIDTH_MAX/mySize.width));
		}
		
	}
	else {
		mySize = theImage.size;//CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)
	}

	return mySize;
	
}

- (void)setBgImage:(UIImage*)theImage andtheRect:(CGRect)theRect
{
	imageRect = theRect;
	
	int h = imageRect.size.width*CUTIMAGE_HEIGHT_MAX/CUTIMAGE_WIDTH_MAX;
	int w = imageRect.size.width;
	if(h>theRect.size.height)
		h = theRect.size.height;
	_CutRect=CGRectMake(imageRect.origin.x, imageRect.origin.y, w, h);
	self.image = theImage;
	//设置四个点的rect
	
	leftUp = CGRectMake(imageRect.origin.x-13, imageRect.origin.y-13, 26, 26);
	leftDown = CGRectMake(imageRect.origin.x-13, imageRect.origin.y+h-13, 26, 26);
	rightUp = CGRectMake(imageRect.origin.x+w-13, imageRect.origin.y-13, 26, 26);
	rightDown = CGRectMake(imageRect.origin.x+w-13, imageRect.origin.y+h-13, 26, 26);
	[self setCutRectByPoints];
	//_CutRect=CGRectMake(leftUp.origin.x+13, leftUp.origin.y+13, rightDown.origin.x-leftUp.origin.x, rightDown.origin.y-leftUp.origin.y);
	//CGPoint 
	//[leftUp ];

	[self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
	CGContextRef context=UIGraphicsGetCurrentContext();
//	[[UIColor whiteColor] set];
//	UIRectFill([self bounds]);
//	//设置倒立
//	CGContextRotateCTM(context,M_PI);
//	//重新设置坐标 self.bounds获取整个屏幕的区域。
//	CGContextTranslateCTM(context, -self.bounds.size.width,-self.bounds.size.height);
//	CGContextScaleCTM(context, -1.0, 1.0);
	//CGRect imageRect = rect;
	//CGRect imageRect;//=rect;
	//画底图

//	CGImageRef imageRef = [self.image CGImage];
//	CGContextDrawImage(context, rect, imageRef);
	
//	[self.image drawInRect:rect];

//	CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 1.0f); // translucent white
//	CGContextFillRect(context,leftUp);
//	CGContextFillRect(context,leftDown);
//	CGContextFillRect(context,rightUp);
//	CGContextFillRect(context,rightDown);
	
	//画圆圈
	CGContextSetLineWidth(context, 4.0);
	//天蓝色
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.0/255.0f
															  green:255.0/255.0f
															   blue:255.0/255.0f
															  alpha:1.0].CGColor);
	
	//画矩形
	CGContextStrokeRect(context, _CutRect);
	CGContextStrokePath(context);
	
	//画中间四条线
	CGContextSetLineWidth(context, 1.0);
	CGContextMoveToPoint(context, _CutRect.origin.x, _CutRect.origin.y+_CutRect.size.height/3);
	CGContextAddLineToPoint(context, _CutRect.origin.x +_CutRect.size.width, _CutRect.origin.y+_CutRect.size.height/3);
	
	CGContextMoveToPoint(context, _CutRect.origin.x, _CutRect.origin.y+2*_CutRect.size.height/3);
	CGContextAddLineToPoint(context, _CutRect.origin.x +_CutRect.size.width, _CutRect.origin.y + 2*_CutRect.size.height/3);
	
	CGContextMoveToPoint(context, _CutRect.origin.x+_CutRect.size.width/3, _CutRect.origin.y);
	CGContextAddLineToPoint(context, _CutRect.origin.x +_CutRect.size.width/3, _CutRect.origin.y+_CutRect.size.height);
	
	CGContextMoveToPoint(context,_CutRect.origin.x+2*_CutRect.size.width/3, _CutRect.origin.y);
	CGContextAddLineToPoint(context, _CutRect.origin.x +2*_CutRect.size.width/3, _CutRect.origin.y+_CutRect.size.height);
	CGContextStrokePath(context);
	
	
	//填充椭圆颜色
    CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.7f); // translucent white
	CGRect rect1 = CGRectMake(0, 0, rect.size.width, _CutRect.origin.y);
	CGRect rect2 = CGRectMake(0, _CutRect.origin.y+_CutRect.size.height, rect.size.width, rect.size.height-_CutRect.origin.y-_CutRect.size.height);
	CGRect rect3 = CGRectMake(0, _CutRect.origin.y, _CutRect.origin.x, _CutRect.size.height);
	CGRect rect4 = CGRectMake(_CutRect.origin.x+_CutRect.size.width, _CutRect.origin.y, rect.size.width-(_CutRect.origin.x+_CutRect.size.width), _CutRect.size.height);
	CGContextFillRect(context,rect1);
	CGContextFillRect(context,rect2);
	CGContextFillRect(context,rect3);
	CGContextFillRect(context,rect4);
	
	
	[[UIImage imageNamed:@"Navbar_icon_locate_normal.png"] drawInRect:leftUp];
	[[UIImage imageNamed:@"Navbar_icon_locate_normal.png"] drawInRect:leftDown];
	[[UIImage imageNamed:@"Navbar_icon_locate_normal.png"] drawInRect:rightUp];
	[[UIImage imageNamed:@"Navbar_icon_locate_normal.png"] drawInRect:rightDown];
	

	
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//OldsizeDifference = 0.0;
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 1) {
		//[self PortraitImage];
		//        if (touch.view == _showImageView) {
		//            if ([self superview]) {
		//                [[self superview] bringSubviewToFront:self];
		//            }
		//        } 
    } 
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView:self];
	if([touch tapCount] == 1)
	{
		if(CGRectContainsPoint( leftUp,touchLocation ))
		{
			
			NSLog(@"leftUp");
			CGPoint prevPoint = [touch previousLocationInView:self];
            CGPoint curPoint = [touch locationInView:self];
			//int x = _CutRect.
            CGPoint centerPoint  = leftUp.origin;
            leftUp.origin.x = centerPoint.x + curPoint.x - prevPoint.x;
            leftUp.origin.y = centerPoint.y + curPoint.y - prevPoint.y;
			
			if(leftUp.origin.x<imageRect.origin.x-13)
				leftUp.origin.x = imageRect.origin.x-13;
			if(leftUp.origin.y<imageRect.origin.y-13)
				leftUp.origin.y = imageRect.origin.y-13;
			
			leftDown.origin.x = leftUp.origin.x;
			rightUp.origin.y = leftUp.origin.y;
			
			if(leftUp.origin.x +26<rightUp.origin.x && leftUp.origin.y +26 < leftDown.origin.y)
				[self setCutRectByPoints];
			else {
				[self setPointsByCutRect];
			}


			
		}
		else if(CGRectContainsPoint( leftDown,touchLocation ))
		{
			NSLog(@"leftUp");
			CGPoint prevPoint = [touch previousLocationInView:self];
            CGPoint curPoint = [touch locationInView:self];
			//int x = _CutRect.
            CGPoint centerPoint  = leftDown.origin;
            leftDown.origin.x = centerPoint.x + curPoint.x - prevPoint.x;
            leftDown.origin.y = centerPoint.y + curPoint.y - prevPoint.y;
			
			if(leftDown.origin.x<imageRect.origin.x-13)
				leftDown.origin.x =imageRect.origin.x -13;
			if(leftDown.origin.y > (imageRect.origin.y + imageRect.size.height-13))
				leftDown.origin.y = imageRect.origin.y + imageRect.size.height-13;
			
			rightDown.origin.y = leftDown.origin.y;
			leftUp.origin.x = leftDown.origin.x;
			
			if(leftUp.origin.x +26<rightUp.origin.x && leftUp.origin.y +26 < leftDown.origin.y)
				[self setCutRectByPoints];
			else {
				[self setPointsByCutRect];
			}
			
		}
		else if(CGRectContainsPoint( rightUp,touchLocation ))
		{
			NSLog(@"leftUp");
			CGPoint prevPoint = [touch previousLocationInView:self];
            CGPoint curPoint = [touch locationInView:self];
			//int x = _CutRect.
            CGPoint centerPoint  = rightUp.origin;
            rightUp.origin.x = centerPoint.x + curPoint.x - prevPoint.x;
            rightUp.origin.y = centerPoint.y + curPoint.y - prevPoint.y;
			
			if(rightUp.origin.x > (imageRect.origin.x+imageRect.size.width-13))
				rightUp.origin.x = imageRect.origin.x+imageRect.size.width-13;
			
			if(rightUp.origin.y<imageRect.origin.y-13)
				rightUp.origin.y = imageRect.origin.y-13;
			leftUp.origin.y = rightUp.origin.y;
			rightDown.origin.x = rightUp.origin.x;
			
			if(leftUp.origin.x +26<rightUp.origin.x && leftUp.origin.y +26 < leftDown.origin.y)
				[self setCutRectByPoints];
			else {
				[self setPointsByCutRect];
			}
			
		}
		
		else if(CGRectContainsPoint( rightDown,touchLocation ))
		{
			NSLog(@"leftUp");
			CGPoint prevPoint = [touch previousLocationInView:self];
            CGPoint curPoint = [touch locationInView:self];
			//int x = _CutRect.
            CGPoint centerPoint  = rightDown.origin;
            rightDown.origin.x = centerPoint.x + curPoint.x - prevPoint.x;
            rightDown.origin.y = centerPoint.y + curPoint.y - prevPoint.y;
			
			if(rightDown.origin.x > (imageRect.origin.x + imageRect.size.width-13))
				rightDown.origin.x = imageRect.origin.x + imageRect.size.width-13;
			
			if(rightDown.origin.y > (imageRect.origin.y + imageRect.size.height-13))
				rightDown.origin.y = imageRect.origin.y + imageRect.size.height-13;
			leftDown.origin.y = rightDown.origin.y;
			rightUp.origin.x = rightDown.origin.x;
			
			if(leftUp.origin.x +26<rightUp.origin.x && leftUp.origin.y +26 < leftDown.origin.y)
				[self setCutRectByPoints];
			else {
				[self setPointsByCutRect];
			}
			
		}
		
		else if(CGRectContainsPoint( _CutRect,touchLocation ))
		{
			
			CGPoint prevPoint = [touch previousLocationInView:self];
            CGPoint curPoint = [touch locationInView:self];
			//int x = _CutRect.
            CGPoint centerPoint  = _CutRect.origin;
            _CutRect.origin.x = centerPoint.x + curPoint.x - prevPoint.x;
            _CutRect.origin.y = centerPoint.y + curPoint.y - prevPoint.y; 
			if(_CutRect.origin.x<imageRect.origin.x)
				_CutRect.origin.x =imageRect.origin.x;
			else if(_CutRect.origin.x>(imageRect.origin.x+imageRect.size.width-_CutRect.size.width))
				_CutRect.origin.x = (imageRect.origin.x+imageRect.size.width-_CutRect.size.width);
			
			if(_CutRect.origin.y<imageRect.origin.y)
				_CutRect.origin.y = imageRect.origin.y;
			else if(_CutRect.origin.y>(imageRect.origin.y+imageRect.size.height-_CutRect.size.height))
				_CutRect.origin.y = (imageRect.origin.y+imageRect.size.height-_CutRect.size.height);
			[self setPointsByCutRect];
			
		}
		
	}
	else if ([touch tapCount] == 2) {
        

    }
	
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}


- (void)dealloc {
    [super dealloc];
}


@end
