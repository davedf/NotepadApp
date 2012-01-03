//
//  DdFPadPadLineIntersectionResult.h
//  PadPad
//
//  Created by David de Florinier on 03/01/2012.
//  Copyright (c) 2012 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadLine.h"

@interface DdFPadPadLineIntersectionResult : NSObject

@property BOOL erased;
@property NSUInteger count;
@property (strong) DdFPadPadLine *line1;
@property (strong) DdFPadPadLine *line2;

@end
