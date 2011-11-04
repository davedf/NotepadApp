//
//  DdFPadPadModelTestHelper.h
//  PadPad
//
//  Created by David de Florinier on 04/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadLine.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadLinePoint.h"

@interface DdFPadPadModelTestHelper : NSObject
+(DdFPadPadInk*)ink ;
+(DdFPadPadLine*)line;
+(DdFPadPadLine*)lineWithPoints;
+(DdFPadPadLinePoint*)point:(CGPoint)point;
@end
