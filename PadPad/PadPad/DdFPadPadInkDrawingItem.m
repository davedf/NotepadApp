//
//  DdFPadPadInkDrawingItem.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadInkDrawingItem.h"
#import "DdFPadPadLine+CGContextRef.h"

@implementation DdFPadPadInkDrawingItem {
    DdFPadPadLine *_line;
    CGAffineTransform _pointTransform;
    CGFloat _lineWidthScale;
}

-(id)initWithLine:(DdFPadPadLine*)line PointTransformer:(CGAffineTransform)pointTransform LineWidthScale:(CGFloat)lineWidthScale {
    self = [super init];
    if (self) {
        _line = line;
        _pointTransform = pointTransform;
        _lineWidthScale = lineWidthScale;
    }
    return self;
}
-(void)drawInContext:(CGContextRef)contextRef {
    DdFPadPadLine *scaledLine = [_line scaleForViewWithPointTransform:_pointTransform InkScale:_lineWidthScale];
    [scaledLine drawLineInContext:contextRef];
}
@end
