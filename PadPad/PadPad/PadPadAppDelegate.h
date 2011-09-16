//
//  PadPadAppDelegate.h
//  PadPad
//
//  Created by David de Florinier on 14/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PadPadViewController;

@interface PadPadAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PadPadViewController *viewController;

@end
