//
//  ShowPicetureView.m
//  CutPicetureDemo
//
//  Created by yang kong on 12-6-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowPicetureView.h"
#import "UIImage-Extensions.h"
@implementation ShowPicetureView

@synthesize showImageView = _showImageView;
@synthesize CutView = _CutView;
@synthesize PortraitCount;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		
		_showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //_showImageView.image = [UIImage imageNamed:@"new.png"];
        _showImageView.userInteractionEnabled = YES;
        _showImageView.multipleTouchEnabled = YES;
        _showImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _showImageView.layer.shadowOffset = CGSizeMake(-1,-1);
        _showImageView.layer.shouldRasterize = YES;
        _showImageView.layer.shadowOpacity = 1;
        _showImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _showImageView.layer.borderWidth = 1.0;
		
		
        [self addSubview:_showImageView];
        self.backgroundColor = [UIColor clearColor];
        self.multipleTouchEnabled = YES;
		
        // Initialization code
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
		//ShowPicetureView
		
		}
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

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
	CGSize size = CGSizeMake(800, 480);
    return [self scaleFromImage:tileImage toSize:size];
}
- (UIImage *)getCutPicetureByRect:(CGRect)theRect
{
	CGRect rect1 =theRect;//[self.CutView CutRect];
	UIImage *rotatedImage = [_showImageView.image imageRotatedByDegrees:90*PortraitCount];
	CGImageRef tiledImage  = [rotatedImage CGImage];
	int w = CGImageGetWidth(tiledImage);
	int h = CGImageGetHeight(tiledImage);
	NSLog(@"image w = %d,h = %d",w,h);
	//CGSize size = CGSizeMake(w, h);
	
	int x = rect1.origin.x*w/self.frame.size.width;
	int y = rect1.origin.y*h/self.frame.size.height;
	int w1 = rect1.size.width*w/self.frame.size.width;
	int h1 = rect1.size.height*h/self.frame.size.height;
	NSLog(@"image w = %d,h = %d",w1,h1);
	CGRect rect = CGRectMake(x,y,w1,h1);
	
	return [self tileForRect:rect image:rotatedImage];
	
}

#define CUTVIEW_WIDTH_MAX  (280)
#define CUTVIEW_HEIGHT_MAX (360)
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


- (void)setBgImage:(UIImage*)theImage
{
	PortraitCount= 0;
	CGSize  size = [self setCutPicetureFrameByImage:theImage];
	int x = (320-size.width)/2;
	int y = (380 - size.height)/2;
	self.frame = CGRectMake(x, y, size.width, size.height);

	_showImageView.frame = CGRectMake(0, 0, size.width, size.height);
	_showImageView.image = theImage;
	//[_CutView setBgImage:theImage andtheRect:self.frame];

}


- (void)PortraitImage
{
	if(_showImageView.image == nil)
		return;
	[UIView beginAnimations:@"animationID" context:nil]; 
	[UIView setAnimationDuration:0.5f]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; 

	
	PortraitCount ++;
	UIImage *rotatedImage = [_showImageView.image imageRotatedByDegrees:90*PortraitCount];
	CGSize  size = [self setCutPicetureFrameByImage:rotatedImage];
	int x = (320-size.width)/2;
	int y = (380 - size.height)/2;

	self.transform = CGAffineTransformRotate(self.transform, M_PI / 2.0);


	[UIView commitAnimations];
		self.frame = CGRectMake(x, y, size.width, size.height);
	CGRect rect =  _showImageView.frame;
	if(PortraitCount%2>0)
		_showImageView.frame = CGRectMake(rect.origin.x	,rect.origin.y, size.height,size.width );
	else {
		_showImageView.frame = CGRectMake(rect.origin.x	,rect.origin.y, size.width,size.height );
	}

	//_showImageView.image = rotatedImage;
	//[_CutView setBgImage:rotatedImage andtheRect:_showImageView.frame];
}

- (void)dealloc
{
    [_showImageView release];
    _showImageView = nil;
	
//	[_CutView release];
//	_CutView = nil;
    [super dealloc];
}




@end
