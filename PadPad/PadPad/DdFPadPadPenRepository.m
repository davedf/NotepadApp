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

@implementation DdFPadPadPenRepository
@synthesize pen=_pen;

-(id)init {
    self = [super init];
    if (self) {
        _pen = [[DdFPadPadPen alloc]init];
        _pen.ink = [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:3 Type:kFeltTip];
    }
    return self;
}
+(DdFPadPadPenRepository*)sharedDdFPadPadPenRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
@end
