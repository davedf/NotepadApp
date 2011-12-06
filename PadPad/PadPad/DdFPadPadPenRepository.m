//
//  DdFPadPadPenRepository.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPenRepository.h"
#import "DdFGCDSingleton.h"
#import "DdFPadPadColor.h"

@implementation DdFPadPadPenRepository {
    NSDictionary *_inks;
}
@synthesize pen=_pen;

-(id)init {
    self = [super init];
    if (self) {
        _inks = [NSDictionary dictionaryWithObjectsAndKeys:
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:1 Type:kFeltTip],INK_BLACK_1, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:3 Type:kFeltTip],INK_BLACK_3, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:5 Type:kFeltTip],INK_BLACK_5, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:1 Type:kFeltTip],INK_BLUE_1, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:3 Type:kFeltTip],INK_BLUE_3, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:5 Type:kFeltTip],INK_BLUE_5, 
                 nil];
        
        _pen = [[DdFPadPadPen alloc]init];
        _pen.ink = [self ink:INK_DEFAULT];
    }
    return self;
}

-(NSArray*)inkNames {
    return [_inks allKeys];
}

-(DdFPadPadInk*)ink:(NSString*)inkName {
    return [_inks objectForKey:inkName];
}
+(DdFPadPadPenRepository*)sharedDdFPadPadPenRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
@end
