//
//  CutPicetureDemoAppDelegate.h
//  CutPicetureDemo
//
//  Created by yang kong on 12-6-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CutPicetureDemoViewController;

@interface CutPicetureDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CutPicetureDemoViewController *viewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CutPicetureDemoViewController *viewController;
@property (nonatomic, retain) UINavigationController* rootNavigator;

@end

