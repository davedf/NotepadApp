//
//  DdFPadPadLine+CGContextRef.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLine+CGContextRef.h"
#import "DdFPadPadLinePoint.h"
#import "DdFPadPadLine+Interpolation.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadColor.h"

@interface DdFPadPadLine()
-(void)setupCGContext:(CGContextRef)context;
-(CGFloat)lineWidthMultipleForPoint:(DdFPadPadLinePoint*)point PreviousLineWidthMultiple:(CGFloat)lineWidthMultiple;
-(CGFloat)lineWidthForMultiple:(CGFloat)lineWidthMultiple;
-(void)drawPoint:(DdFPadPadLinePoint*)point InContext:(CGContextRef)context;
-(void)drawLineFromPoint:(DdFPadPadLinePoint*)point1 ToPoint:(DdFPadPadLinePoint*)point2 InContext:(CGContextRef)context;
-(void)drawInterpolatedCurvedLineInContext:(CGContextRef)context;
-(void)drawInterpolatedLine:(CGPoint*)points WithNumberOfPoints:(NSUInteger)total LineWidthAdjust:(CGFloat)lineWidthAdjust OpacityAdjust:(CGFloat) opacityAdjust Interpolated:(NSUInteger) interpolated InContext:(CGContextRef)context;
@end

@implementation DdFPadPadLine (CGContextRef)
-(CGFloat)lineWidthMultipleForPoint:(DdFPadPadLinePoint*)point PreviousLineWidthMultiple:(CGFloat)lineWidthMultiple{
    CGFloat multiple = point.speed / 5000;
    CGFloat granularity = 0.05;
    if (multiple > 0.75) {
        multiple = 0.75;
    }
    if (fabs(multiple - lineWidthMultiple) < granularity) {
        return lineWidthMultiple;
    }
    if (multiple < lineWidthMultiple) {
        return fmax(0.0, lineWidthMultiple - granularity);
    }
    else if (multiple > lineWidthMultiple) {
        return fmax(0.0,lineWidthMultiple + granularity);
    }
    
    return lineWidthMultiple;    
}

-(CGFloat)lineWidthForMultiple:(CGFloat)lineWidthMultiple {
    return self.ink.inkSize - (self.ink.inkSize * lineWidthMultiple);
}

-(void)setupCGContext:(CGContextRef)context {
    CGContextSetLineWidth(context, self.ink.inkSize); 
    CGContextSetLineJoin(context, kCGLineJoinRound);
    DdFPadPadColor *color = self.ink.color;
    UIColor *uicolor = color.color;
    CGContextSetStrokeColorWithColor(context, [uicolor CGColor]);    
}

-(void)drawPoint:(DdFPadPadLinePoint*)point InContext:(CGContextRef)context {
    CGContextAddEllipseInRect(context, CGRectMake(point.origin.x - self.ink.inkSize/2, point.origin.y - self.ink.inkSize/2, self.ink.inkSize, self.ink.inkSize));
}

-(void)drawLineFromPoint:(DdFPadPadLinePoint*)point1 ToPoint:(DdFPadPadLinePoint*)point2 InContext:(CGContextRef)context {
    CGContextMoveToPoint(context, point1.origin.x, point2.origin.y);                
    CGContextAddLineToPoint(context, point2.origin.x, point2.origin.y);
}

-(void)drawInterpolatedCurvedLineInContext:(CGContextRef)context {
    NSUInteger interpolated = 8;
    NSUInteger total = [self sizeAfterInterpolation:interpolated];
    CGPoint points[total];
    [self genHermiteInterpolationToPoints:points Interpolated:interpolated];
    
    [self drawInterpolatedLine:points WithNumberOfPoints:total LineWidthAdjust:0.7 OpacityAdjust:1.0 Interpolated:interpolated InContext:context];
    [self drawInterpolatedLine:points WithNumberOfPoints:total LineWidthAdjust:1.0 OpacityAdjust:0.5 Interpolated:interpolated InContext:context];
}

-(void)drawInterpolatedLine:(CGPoint*)points WithNumberOfPoints:(NSUInteger)total LineWidthAdjust:(CGFloat)lineWidthAdjust OpacityAdjust:(CGFloat) opacityAdjust Interpolated:(NSUInteger) interpolated InContext:(CGContextRef)context{
    
    DdFPadPadColor *color = self.ink.color;
    UIColor *uicolor = color.color;        
    CGContextSetStrokeColorWithColor(context, [uicolor CGColor]);    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGFloat lineWidthMultiple  = 0.0; 
    
    CGFloat lineWidth = [self lineWidthForMultiple:lineWidthMultiple];
    CGContextSetLineWidth(context, lineWidth * lineWidthAdjust);
    
    int index = 3;
    CGContextMoveToPoint(context, points[0].x, points[0].y);                
    int nextLineWidthCheck = interpolated;
    while (index < total) {        
        if (index >= nextLineWidthCheck) {
            nextLineWidthCheck+=interpolated;        
            DdFPadPadLinePoint *point = [self getMiDiaryLinePointForInterpolatedPointIndex:index-1 Interpolated:interpolated];
            CGFloat newlineWidthMultiple = [self lineWidthMultipleForPoint:point PreviousLineWidthMultiple:lineWidthMultiple];
            if (index > 3 && newlineWidthMultiple != lineWidthMultiple) {
                CGContextStrokePath(context);    
                CGContextSetLineCap(context, kCGLineCapSquare);
                lineWidthMultiple = newlineWidthMultiple;
                CGFloat lineWidth = [self lineWidthForMultiple:lineWidthMultiple];
                CGContextSetLineWidth(context, lineWidth * lineWidthAdjust);
                CGContextMoveToPoint(context, points[index-3].x, points[index-3].y);                
            }
        }
        CGContextAddCurveToPoint(context, points[index-2].x, points[index-2].y, points[index-1].x, points[index-1].y, points[index].x, points[index].y);        
        index+=3;
    }
    
    CGContextStrokePath(context);    
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextMoveToPoint(context, points[total-4].x, points[total-4].y);                
    CGContextAddCurveToPoint(context, points[total-3].x, points[total-3].y, points[total-2].x, points[total-2].y, points[total-1].x, points[total-1].y);        
    
    CGContextStrokePath(context);    
    
}

-(void)drawLineInContext:(CGContextRef)context {
    [self setupCGContext:context];
    
    switch ([self.points count]) {
        case 0:
            break;
        case 1:
            [self drawPoint:[self.points objectAtIndex:0] InContext:context];
            break;            
        case 2:
            [self drawLineFromPoint:[self.points objectAtIndex:0] ToPoint:[self.points objectAtIndex:1] InContext:context];
            break;
        case 3:
            [self drawLineFromPoint:[self.points objectAtIndex:0] ToPoint:[self.points objectAtIndex:1] InContext:context];
            [self drawLineFromPoint:[self.points objectAtIndex:1] ToPoint:[self.points objectAtIndex:2] InContext:context];
            break;
        default:
            [self drawInterpolatedCurvedLineInContext:context];
            break;
    }
}
@end
