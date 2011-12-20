//
//  DdFPadPadEraserToolBuilder.m
//  PadPad
//
//  Created by David de Florinier on 20/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadEraserToolBuilder.h"
#import "DdFPadPadEraserTool.h"
@implementation DdFPadPadEraserToolBuilder
@synthesize eraser=_eraser;

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate {
    return [[DdFPadPadEraserTool alloc]initWithDelegate:delegate Eraser:self.eraser];
}

@end
