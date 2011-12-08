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
#import "DdFPadPadPaper.h"
#import "DdFPadPadModelTestHelper.h"
#import "DdFPadPadPageLineInformation.h"

#define JSON_MAJOR_LINES @"{\"mInk\":\"bkhp\",\"gap\":3,\"mInterval\":10,\"ink\":\"bkfp\"}"
#define JSON_NO_MAJOR_LINES @"{\"ink\":\"bkfp\",\"gap\":10}"

@interface DdFPadPadModelTestHelper : NSObject
+(DdFPadPadInk*)ink ;
+(DdFPadPadLine*)line;
+(DdFPadPadLine*)lineWithPoints;
+(DdFPadPadLinePoint*)point:(CGPoint)point;
+(DdFPadPadPaper*)paper;

@end
