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

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate {
    NSObject<DdFPadPadDrawingTool> *newTool = [self.selectedToolBuilder newDrawingTool];
    newTool.delegate = toolDelegate;
    return newTool;
}

@end
