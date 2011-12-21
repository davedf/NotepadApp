//
//  DdFPadPadToolView.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolView.h"

@implementation DdFPadPadToolView {
    NSObject<DdFPadPadToolViewDrawingItem> *_drawingItem;
}

-(void)draw:(NSObject<DdFPadPadToolViewDrawingItem>*)drawingItem {
    _drawingItem = drawingItem;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    if (_drawingItem) {
        [_drawingItem drawInContext:context];
        
    }
    else {
        CGContextStrokePath(context);
    }
}


@end
