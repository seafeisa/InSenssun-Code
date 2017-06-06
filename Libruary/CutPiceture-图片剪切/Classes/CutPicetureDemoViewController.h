//
//  CutPicetureDemoViewController.h
//  CutPicetureDemo
//
//  Created by yang kong on 12-6-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import"ShowPicetureView.h"
#import "CutPicetureView.h"
@interface CutPicetureDemoViewController : UIViewController<UIActionSheetDelegate> {

}

@property (nonatomic,retain)ShowPicetureView *ShowPicView;
@property (nonatomic, retain, readonly) CutPicetureView * CutView;

@property (nonatomic, assign) BOOL isCarm;

@end

