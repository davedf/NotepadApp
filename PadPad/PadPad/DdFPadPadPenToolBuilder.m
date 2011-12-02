//
//  DdFPadPadPenToolBuilder.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPenToolBuilder.h"
#import "DdFPadPadPenTool.h"

@implementation DdFPadPadPenToolBuilder
@synthesize pen=_pen;

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate {
    return [[DdFPadPadPenTool alloc]initWithDelegate:delegate Pen:self.pen];
}
@end
