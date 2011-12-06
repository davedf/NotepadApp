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

#define INK_BLACK_1 @"bk1"
#define INK_BLACK_3 @"bk3"
#define INK_BLACK_5 @"bk5"
#define INK_DEFAULT INK_BLACK_3
@interface DdFPadPadPenRepository : NSObject

@property (readonly,strong) DdFPadPadPen *pen;

@property (readonly) NSArray *inkNames;

-(DdFPadPadInk*)ink:(NSString*)inkName;

+(DdFPadPadPenRepository*)sharedDdFPadPadPenRepository;
@end
