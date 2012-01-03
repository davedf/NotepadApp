//
//  DdFPadPadLine+Intersection.m
//  PadPad
//
//  Created by David de Florinier on 03/01/2012.
//  Copyright (c) 2012 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLine+Intersection.h"
#import "DdFCGUtils.h"
#import "DdFPadPadLinePoint.h"
#import "DdFPadPadLineIntersectionResult.h"
#import "DdFStringUtils.h"

@implementation DdFPadPadLine (Intersection)

-(DdFPadPadLineIntersectionResult*) linesAfterIntersectionOfPoint:(CGPoint )point WithRange:(CGFloat)range {
    DdFPadPadLineIntersectionResult *result = [[DdFPadPadLineIntersectionResult alloc]init];
    result.erased = NO;
    result.count = 1;
    result.line1 = self;
    if ([self.points count] < 2) {
        return result;
    }
    if (!CGPointIsInRangeOfRect(point, self.bounds, range)) {
        return result;
    }
    NSArray *points = self.points;
    Circle c = CircleMake(point, range);
    
    //try erasing the start of the line
    result = [self tryEraseEndOfLine:points WithCircle:c Reverse:NO];
    if (result.erased) {
        return result;
    }
    
    //try erasing the end of the line
    NSMutableArray *rPoints = [[NSMutableArray alloc] initWithCapacity:[self.points count]];

    for (DdFPadPadLinePoint *p in [self.points reverseObjectEnumerator]  ) {
        [rPoints addObject:p];
    }

    result = [self tryEraseEndOfLine:rPoints WithCircle:c Reverse:YES];
    if (result.erased) {
        return result;
    }
    result.line1 = self;
    NSMutableArray *currentLinePoints = [[NSMutableArray alloc] initWithArray:self.points];

    NSMutableArray *line1Points = [[NSMutableArray alloc]init];
    NSMutableArray *line2Points = [[NSMutableArray alloc]init];
    
    while ([currentLinePoints count] > 1) {
        DdFPadPadLinePoint *p1 = [currentLinePoints objectAtIndex:0];
        DdFPadPadLinePoint *p2 = [currentLinePoints objectAtIndex:1];
        [currentLinePoints removeObjectAtIndex:0];
        
        LineSegment line = LineSegmentMake(p1.origin, p2.origin);
        TRACE(@"Checking for intersections on line:([%f,%f],[%f,%f])", line.p1.x,line.p1.y,line.p2.x,line.p2.y );
        
        if (!ValidLine(line)) {
            TRACE(@"One of the points is invalid, ");
            if (ValidPoint(line.p1)) {
                NSLog(@"first point is valid");
                [line1Points addObject:p1];
            }
            [currentLinePoints removeAllObjects];
        }
        else if (CGPointIsInsideCircle(p1.origin, c) && CGPointIsInsideCircle(p2.origin, c)) {
            TRACE(@"both points at start of line are inside the circle, first one can be completely erased");
            p1 = nil;
            result.erased = YES;
        }
        else if (CGPointIsInsideCircle(p1.origin, c)) {
            TRACE(@"first point is inside the circle, second one is outside, start the split line at the intersection");
            LineCircleIntersections intersections = LineIntersectionsOnCircle(c, line);
            if (intersections.number > 0) {
                
                DdFPadPadLinePoint *newP = [[DdFPadPadLinePoint alloc]initWithOrigin:intersections.point1 velocity:p1.velocity];                                            
                result.erased = YES;
                [line2Points addObject:newP];
                [line2Points addObjectsFromArray:currentLinePoints];
                [currentLinePoints removeAllObjects];
            } else {
                TRACE(@"Unexpected - should be an intersection");
                return result;
            }
            
        }
        else if (CGPointIsInsideCircle(p2.origin, c)) {
            TRACE(@"first point is outside the circle, second one is inside, split the line at the intersection");
            LineCircleIntersections intersections = LineIntersectionsOnCircle(c, line);
            [line1Points addObject:p1];
            if (intersections.number > 0) {
                DdFPadPadLinePoint *newP = [[DdFPadPadLinePoint alloc]initWithOrigin:intersections.point1 velocity:p1.velocity];
                result.erased = YES;
                [line1Points addObject:newP];
            } else {
                TRACE(@"Unexpected - should be an intersection");
                return result;
            }
            
        }
        else {
            CGRect rect = CGRectMakeFromPoints(p1.origin, p2.origin);
            [line1Points addObject:p1];
            if (CGPointIsInRangeOfRect(c.center, rect, c.radius)) {
                
                TRACE(@"both points are outside the circle,  but there may be an intersection between the points");
                LineCircleIntersections intersections = LineIntersectionsOnCircle(c, line);
                if (intersections.number > 1) {
                    DdFPadPadLinePoint *newP1 = [[DdFPadPadLinePoint alloc]initWithOrigin:intersections.point1 velocity:p1.velocity];
                     
                    DdFPadPadLinePoint *newP2 = [[DdFPadPadLinePoint alloc]initWithOrigin:intersections.point2 velocity:p2.velocity];                    
                    result.erased = YES;
                    [line1Points addObject:newP1];
                    [line2Points addObject:newP2];
                    [line2Points addObjectsFromArray:currentLinePoints];
                    [currentLinePoints removeAllObjects];
                }
            }
        }
        
    }
    
    if (result.erased) {
        if  ([line1Points count] > 0 ) {
            result.line1 = [[DdFPadPadLine alloc]initWithId:[DdFStringUtils newStringWithUUID] Ink:self.ink Points:line1Points];
        }
        
        if ([line2Points count] > 0) {
            result.count = 2;
            if (result.count == 1) {
                result.line1 = [[DdFPadPadLine alloc]initWithId:[DdFStringUtils newStringWithUUID] Ink:self.ink Points:line2Points];
            }
            else {
                result.line2 = [[DdFPadPadLine alloc]initWithId:[DdFStringUtils newStringWithUUID] Ink:self.ink Points:line2Points];
            }
        }
    }
    else {
        result.count = 1;
        result.line1 = self;
    }
    return result;
}
-(DdFPadPadLineIntersectionResult*)tryEraseEndOfLine:(NSArray *) line WithCircle:(Circle )c Reverse:(BOOL ) reverse {
    DdFPadPadLineIntersectionResult *result = [[DdFPadPadLineIntersectionResult alloc]init];
    result.erased = NO;
    NSMutableArray *currentLinePoints = [[NSMutableArray alloc] initWithArray:line];
    NSMutableArray *newPoints = [NSMutableArray array];
    
    DdFPadPadLinePoint *p1 = nil;
    DdFPadPadLinePoint *p2 = nil;
    while ([currentLinePoints count] > 1) {
        p1 = [currentLinePoints objectAtIndex:0];
        p2 = [currentLinePoints objectAtIndex:1];
        [currentLinePoints removeObjectAtIndex:0];
        LineSegment line = LineSegmentMake(p1.origin, p2.origin);
        if (CGPointIsInsideCircle(p1.origin, c) && CGPointIsInsideCircle(p2.origin, c)) {
            TRACE(@"both points at start of line are inside the circle, first one can be completely erased");
            result.erased = YES;
        }
        else if (CGPointIsInsideCircle(p1.origin, c)) {
            TRACE(@"first point is inside the circle, second one is outside, move first point to intersection");
            LineCircleIntersections intersections = LineIntersectionsOnCircle(c, line);
            if (intersections.number > 0) {
                DdFPadPadLinePoint *newP = [[DdFPadPadLinePoint alloc]initWithOrigin:intersections.point1  velocity:p1.velocity];
                result.erased = YES;
                [newPoints addObject:newP];
                [newPoints addObjectsFromArray:currentLinePoints];
                [currentLinePoints removeAllObjects];
            } else {
                TRACE(@"Unexpected - should be an intersection");
                return result;
            }
            
        }
        else {
            TRACE(@"first point at start of line is outside the circle");
            [newPoints addObjectsFromArray:currentLinePoints];
            [currentLinePoints removeAllObjects];
        }
    }
    if (result.erased) {
        if ([newPoints count] == 0) {
            result.count = 0;
        } else {
            result.count = 1;
            
            if (reverse) {
                NSMutableArray *toAdd = [[NSMutableArray alloc] initWithCapacity:[newPoints count]];
                for (DdFPadPadLinePoint *p in [newPoints reverseObjectEnumerator]) {
                    [toAdd addObject:p];
                }
                result.line1 = [[DdFPadPadLine alloc] initWithId:[DdFStringUtils newStringWithUUID] Ink:self.ink Points:toAdd];
                                 
            }
            else {
                result.line1 = [[DdFPadPadLine alloc] initWithId:[DdFStringUtils newStringWithUUID] Ink:self.ink Points:newPoints];
            }
        }
        
        
    }
    return result;
}

@end
