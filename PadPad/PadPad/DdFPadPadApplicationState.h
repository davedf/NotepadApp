//
//  DdFPadPadApplicationState.h
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DdfPadPadDataViewController;
@class DdfPadPadRootViewController;
@class DdFPadPadBook;

@interface DdFPadPadApplicationState : NSObject

@property (readonly) DdfPadPadDataViewController *leftPageController;
@property (readonly) DdfPadPadDataViewController *rightPageController;
@property (readonly) DdFPadPadBook *book;
@property (weak) DdfPadPadRootViewController *rootController;
-(void)hidePopover;
+(DdFPadPadApplicationState*)sharedDdFPadPadApplicationState;
@end
