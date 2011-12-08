//
//  DdFPadPadPenRepository.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadInk.h"
#import "DdFPadPadPen.h"
#define INK_BLACK_FAINT_PAPER @"bkfp"
#define INK_BLACK_HEAVY_PAPER @"bkhp"
#define INK_BLACK_1 @"bk1"
#define INK_BLACK_3 @"bk3"
#define INK_BLACK_5 @"bk5"
#define INK_BLACK_8 @"bk8"
#define INK_BLUE_1 @"bl1"
#define INK_BLUE_3 @"bl3"
#define INK_BLUE_5 @"bl5"
#define INK_BLUE_8 @"bl8"
#define INK_RED_1 @"r1"
#define INK_RED_3 @"r3"
#define INK_RED_5 @"r5"
#define INK_RED_8 @"r8"
#define INK_MARKER_10 @"mk10"
#define INK_MARKER_20 @"mk20"
#define INK_MARKER_30 @"mk30"
#define INK_DEFAULT INK_BLACK_3
@interface DdFPadPadPenRepository : NSObject

@property (readonly,strong) DdFPadPadPen *pen;

@property (readonly) NSArray *inkNames;

-(DdFPadPadInk*)ink:(NSString*)inkName;

+(DdFPadPadPenRepository*)sharedDdFPadPadPenRepository;
@end
