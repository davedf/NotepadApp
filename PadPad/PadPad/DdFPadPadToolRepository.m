//
//  DdFPadPadToolRepository.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolRepository.h"
#import "DdFPadPadPenToolBuilder.h"
#import "DdFPadPadPenRepository.h"
#import "DdFGCDSingleton.h"

@implementation DdFPadPadToolRepository {
    DdFPadPadPenToolBuilder *_penToolBuilder;
}
@synthesize selectedToolBuilder=_selectedToolBuilder;

-(id)init {
    self = [super init];
    if (self) {
        _penToolBuilder = [[DdFPadPadPenToolBuilder alloc]init];
        _penToolBuilder.pen = [[DdFPadPadPenRepository sharedDdFPadPadPenRepository] pen];
        _selectedToolBuilder = _penToolBuilder;
    }
    return self;
}

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate {
    NSObject<DdFPadPadDrawingTool> *newTool = [self.selectedToolBuilder newDrawingToolWithDelegate:toolDelegate];
    return newTool;
}

-(NSObject<DdFPadPadDrawingToolBuilder>*)penToolBuilder {
    return _penToolBuilder;
}

+(DdFPadPadToolRepository*)sharedDdFPadPadToolRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });

}

@end
