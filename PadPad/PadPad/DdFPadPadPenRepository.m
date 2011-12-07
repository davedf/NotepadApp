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
    NSArray *_inkNames;
}
@synthesize pen=_pen;

-(id)init {
    self = [super init];
    if (self) {
        _inks = [NSDictionary dictionaryWithObjectsAndKeys:
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:1 Type:kFeltTip],INK_BLACK_1, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:3 Type:kFeltTip],INK_BLACK_3, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:5 Type:kFeltTip],INK_BLACK_5, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:8 Type:kFeltTip],INK_BLACK_8, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:1 Type:kFeltTip],INK_BLUE_1, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:3 Type:kFeltTip],INK_BLUE_3, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:5 Type:kFeltTip],INK_BLUE_5, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blueInk] Size:8 Type:kFeltTip],INK_BLUE_8, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor redInk] Size:1 Type:kFeltTip],INK_RED_1, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor redInk] Size:3 Type:kFeltTip],INK_RED_3, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor redInk] Size:5 Type:kFeltTip],INK_RED_5, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor redInk] Size:8 Type:kFeltTip],INK_RED_8, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor yellowHighlightInk] Size:10 Type:kFeltTip],INK_MARKER_10, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor yellowHighlightInk] Size:20 Type:kFeltTip],INK_MARKER_20, 
                 [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor yellowHighlightInk] Size:30 Type:kFeltTip],INK_MARKER_30, 
                 nil];
        _inkNames = [NSArray arrayWithObjects:
                     INK_BLACK_1,INK_BLACK_3,INK_BLACK_5,INK_BLACK_8,
                     INK_BLUE_1,INK_BLUE_3,INK_BLUE_5,INK_BLUE_8,
                     INK_RED_1,INK_RED_3,INK_RED_5,INK_RED_8,
                     INK_MARKER_10,INK_MARKER_20,INK_MARKER_30,
                     nil];
        _pen = [[DdFPadPadPen alloc]init];
        _pen.ink = [self ink:INK_DEFAULT];
    }
    return self;
}

-(NSArray*)inkNames {
    return _inkNames;
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
