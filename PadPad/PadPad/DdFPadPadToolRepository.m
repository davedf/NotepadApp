//
//  DdFPadPadToolRepository.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolRepository.h"

@implementation DdFPadPadToolRepository
@synthesize selectedToolBuilder=_selectedToolBuilder;

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate {
    NSObject<DdFPadPadDrawingTool> *newTool = [self.selectedToolBuilder newDrawingToolWithDelegate:toolDelegate];
    return newTool;
}

@end
