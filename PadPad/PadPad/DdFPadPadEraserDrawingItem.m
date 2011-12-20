//
//  DdFPadPadEraserDrawingItem.m
//  PadPad
//
//  Created by David de Florinier on 19/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadEraserDrawingItem.h"

@implementation DdFPadPadEraserDrawingItem {
    CGPoint _point;
    CGFloat _size;
    CGAffineTransform _pointTransform;
    CGFloat _lineWidthScale;

}

-(id)initWithPoint:(CGPoint)point size:(CGFloat)size PointTransformer:(CGAffineTransform)pointTransform LineWidthScale:(CGFloat)lineWidthScale {
    self = [super init];
    if (self) {
        _point = point;
        _size = size;
        _pointTransform = pointTransform;
        _lineWidthScale = lineWidthScale;
    }
    return self;
}

#pragma mark - DdFPadPadToolViewDrawingItem
-(void)drawInContext:(CGContextRef)contextRef {
    CGContextSetLineWidth(contextRef, 2.0 * _lineWidthScale);
    CGContextSetStrokeColorWithColor(contextRef, [[UIColor lightGrayColor] CGColor]);    
    CGFloat scaledSize= (_size * _lineWidthScale); 
    CGFloat lengths[3];
    CGFloat dashSize = scaledSize /5;
    lengths[0] = dashSize;
    lengths[1] = dashSize;
    CGContextSetLineDash(contextRef, 4.0 * _lineWidthScale, lengths, 2);
    
    CGPoint point = CGPointApplyAffineTransform(_point, _pointTransform);
    CGContextStrokePath(contextRef);
    
    CGContextMoveToPoint(contextRef, point.x, point.y);                
    
    CGRect pointrect = CGRectMake(point.x - scaledSize/2, point.y - scaledSize/2, scaledSize, scaledSize);
    CGContextAddEllipseInRect(contextRef, pointrect);
    CGContextStrokePath(contextRef);

}

@end
