//
//  DdFPadPadLine+Interpolation.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLine+Interpolation.h"
#import "DdFCGUtils.h"
@implementation DdFPadPadLine (Interpolation)

-(void)genHermiteInterpolationToPoints:(CGPoint*)vertices Interpolated:(NSUInteger) interpolated {
    int count = 0;
    int num = [self.points count];
    
    float dt = 1.f / (float) interpolated;
    
    float tension = 0.f;
    float bias    = 0.f;
    
    if (num < 2) return;
    
    // We need two extra points
    CGPoint d0, dN;
    DdFPadPadLinePoint *linePoint0 = [self.points objectAtIndex:0];
    DdFPadPadLinePoint *linePoint1 = [self.points objectAtIndex:1];
    DdFPadPadLinePoint *linePointLast = [self.points objectAtIndex:(NSUInteger) (num-1)];
    DdFPadPadLinePoint *linePointBeforeLast = [self.points objectAtIndex:(NSUInteger) (num-2)];
    d0 = CGPointAdd(linePoint0.origin, CGPointNormalize(ccpSub(linePoint1.origin, linePoint0.origin)));
    dN = CGPointAdd(linePointLast.origin, CGPointNormalize(ccpSub(linePointLast.origin, linePointBeforeLast.origin)));
    
    for (int i=0; i<(num-1); i++) {
        DdFPadPadLinePoint *linePoint = [self.points objectAtIndex:(NSUInteger) i];
        
        vertices[count] = linePoint.origin;
        count++;
        
        CGPoint y0, y1, y2, y3;
        
        if (i==0) {
            y0 = d0;
        } else {
            DdFPadPadLinePoint *linePointPrev = [self.points objectAtIndex:(NSUInteger) (i-1)];
            y0 = linePointPrev.origin;
        }
        y1 = linePoint.origin;
        DdFPadPadLinePoint *linePointNext = [self.points objectAtIndex:(NSUInteger) (i+1)];
        y2 = linePointNext.origin;
        
        if (i==(num-2)) {
            y3 = dN;
        } else {
            DdFPadPadLinePoint *linePointAfterNext = [self.points objectAtIndex:(NSUInteger) (i+2)];
            y3 = linePointAfterNext.origin;
        }
        
        for (float mu=dt; mu < 1.f; mu += dt) {
            CGPoint m0, m1,p;
            double a0, a1, a2, a3;
            double mu2 = mu * mu;
            double mu3 = mu2 *mu;
            
            m0.x  = (y1.x - y0.x) * (1.f + bias) * (1.f - tension) / 2.f;
            m0.x += (y2.x - y1.x) * (1.f - bias) * (1.f - tension) / 2.f;
            m0.y  = (y1.y - y0.y) * (1.f + bias) * (1.f - tension) / 2.f;
            m0.y += (y2.y - y1.y) * (1.f - bias) * (1.f - tension) / 2.f;
            
            m1.x  = (y2.x - y1.x) * (1.f + bias) * (1.f - tension) / 2.f;
            m1.x += (y3.x - y2.x) * (1.f - bias) * (1.f - tension) / 2.f;
            m1.y  = (y2.y - y1.y) * (1.f + bias) * (1.f - tension) / 2.f;
            m1.y += (y3.y - y2.y) * (1.f - bias) * (1.f - tension) / 2.f;
            
            a0 =  2.f * mu3 - 3.f * mu2 + 1;
            a1 =        mu3 - 2.f * mu2 + mu;
            a2 =        mu3 -       mu2;
            a3 = -2.f * mu3 + 3.f * mu2;
            
            // The point
            p.x = (CGFloat) ((a0 * y1.x) + (a1 * m0.x) + (a2 * m1.x) + (a3 * y2.x));
            p.y = (CGFloat) ((a0 * y1.y) + (a1 * m0.y) + (a2 * m1.y) + (a3 * y2.y));
            
            vertices[count] = p;
            count++;
        }
    }
    
    vertices[count] = linePointLast.origin;    
}

-(DdFPadPadLinePoint*)getMiDiaryLinePointForInterpolatedPointIndex:(NSUInteger)index Interpolated:(NSUInteger)interpolated {
    NSUInteger nonInterpolated =  (index -  index % interpolated) / interpolated;
    return  [self.points objectAtIndex:nonInterpolated];    
}

-(NSUInteger)sizeAfterInterpolation:(NSUInteger) interpolated {
    NSUInteger size = [self.points count];
    NSUInteger interpolatedSize =  (interpolated * (size -1)) + 1;
    return interpolatedSize;
}
@end
