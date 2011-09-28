//
//  DdfPadPadModelController.h
//  PadPad
//
//  Created by David de Florinier on 28/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DdfPadPadDataViewController;

@interface DdfPadPadModelController : NSObject <UIPageViewControllerDataSource>
- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController;
@end
