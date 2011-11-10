//
//  DdFPadPadApplicationState.m
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadApplicationState.h"
#import "DdFGCDSingleton.h"
#import "DdfPadPadDataViewController.h"
#import "DdfPadPadModelController.h"
#import "DdfPadPadRootViewController.h"
#import "DdFPadPadBook.h"

@implementation DdFPadPadApplicationState
@synthesize rootController=_rootController;

+(DdFPadPadApplicationState*)sharedDdFPadPadApplicationState {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

-(DdFPadPadBook*)book {
    return self.rootController.modelController.book;
}
-(DdfPadPadDataViewController*)leftPageController {
    return [self.rootController.pageViewController.viewControllers objectAtIndex:0];
}

-(DdfPadPadDataViewController*)rightPageController {
    if (self.rootController.pageViewController.viewControllers.count > 1) {
        return [self.rootController.pageViewController.viewControllers objectAtIndex:1];
    }
    return nil;
}
@end
