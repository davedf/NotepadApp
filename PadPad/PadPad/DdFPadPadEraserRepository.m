//
//  DdFPadPadEraserRepository.m
//  PadPad
//
//  Created by David de Florinier on 20/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadEraserRepository.h"
#import "DdFGCDSingleton.h"

@implementation DdFPadPadEraserRepository
@synthesize eraser=_eraser;
-(id)init {
    self = [super init];
    if (self) {
        _eraser = [[DdfPadPadEraser alloc]init];
        _eraser.size = 10;
    }
    return self;
}

+(DdFPadPadEraserRepository*)sharedDdFPadPadEraserRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });

}
@end
