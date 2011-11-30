#import "JSON.h"
#import <UIKit/UIKit.h>

#define X_KEY @"x"
#define Y_KEY @"y"

static inline NSDictionary* CGPointToJSON(CGPoint point) {

    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithFloat:point.x],X_KEY, 
            [NSNumber numberWithFloat:point.y],Y_KEY, 
            nil];
}

static inline CGPoint CGPointFromJSON(NSDictionary *dictionary) {
    
    CGPoint point = CGPointMake([[dictionary objectForKey:X_KEY] floatValue], [[dictionary objectForKey:Y_KEY] floatValue]);
    return point;
}

typedef struct  {
    // line : y= ax + b
    CGFloat a;
    CGFloat b;
} LineFormula;

typedef struct  {
    // line : y= ax + b
    CGPoint center;
    CGFloat radius;
} Circle;

typedef struct  {
    // line : y= ax + b
    CGPoint p1;
    CGPoint p2;
} LineSegment;

static BOOL ValidPoint(CGPoint p) {
    if (isnan(p.x)) {
        return NO;
    }
    if (isnan(p.y)) {
        return NO;
    }
    return YES;
}
static BOOL ValidLine(LineSegment l) {
    if (!ValidPoint(l.p1)) {
        return NO;
    }
    if (!ValidPoint(l.p2)) {
        return NO;
    }
    return YES;
}
static LineSegment LineSegmentMake(CGPoint p1, CGPoint p2) {
    LineSegment line;
    line.p1 = p1;
    line.p2 = p2;
    return line;
}

static Circle CircleMake(CGPoint center,CGFloat radius) {
    Circle c;
    c.center = center;
    c.radius = radius;
    return c;
}

typedef struct  {
    NSUInteger number;
    CGPoint point1;
    CGPoint point2;
} LineCircleIntersections;


static CGFloat sq(CGFloat x) {
    return powf(x, 2);
}

static  CGFloat sgn(CGFloat x) {
    return x < 0 ? -1 : 1;
}

static LineCircleIntersections LineCircleIntersectionsMake(NSUInteger number, CGPoint p1, CGPoint p2) {
    LineCircleIntersections res;
    res.number = number;
    res.point1 = p1;
    res.point2 = p2;
    return res;
}

static CGRect CGRectMakeFromPoints(CGPoint p1, CGPoint p2) {
    CGFloat minX = MIN(p1.x, p2.x);
    CGFloat minY = MIN(p1.y, p2.y);
    return CGRectMake(minX, minY, MAX(p1.x, p2.x) - minX, MAX(p1.y, p2.y) - minY);
}


static inline LineFormula LineFormulaMake(CGFloat a, CGFloat b) {
    LineFormula ret;
    ret.a = a;
    ret.b = b;
    return ret;
}

static inline LineFormula LineFormulaMakeFromPoints(CGPoint lineStart,CGPoint lineEnd) {
    // line : y= ax + b
    //between (lineStart.x, lineStart.y) and (lineEnd.x, lineEnd.y)
    CGFloat dx = lineEnd.x - lineStart.x;
    CGFloat dy = lineEnd.y - lineStart.y;
    CGFloat a = dy/dx;
    CGFloat b = lineStart.y - (lineStart.x * a);
    return LineFormulaMake(a, b);
}

static inline LineFormula LineFormulaMakeFromLineSegment(CGPoint lineStart, LineSegment lineSegment) {
    return LineFormulaMakeFromPoints(lineSegment.p1, lineSegment.p2);
}

static inline CGFloat CGPointDistance(CGPoint point1,CGPoint point2)
{		    
    CGFloat dx2 = powf(point1.x - point2.x, 2.0);
    CGFloat dy2 = powf(point1.y - point2.y, 2.0);
    return sqrtf(dx2 + dy2);	
}

static inline CGFloat CGPointMagnitude(CGPoint point)
{		    
    return CGPointDistance(CGPointMake(0, 0), point);
}

static inline CGFloat DistanceFromPointToLine(CGPoint point, CGPoint lineStart, CGPoint lineEnd) {
    // line : y= ax + b
    LineFormula  line = LineFormulaMakeFromPoints(lineStart, lineEnd);
    return (CGFloat) (fabs(-line.a*point.x +point.y - line.b) / sqrt(line.a*line.a + 1));
}

static inline BOOL CGPointIsInRangeOfRect(CGPoint point, CGRect rect, CGFloat range)
{
    if (point.x + range < MIN(rect.origin.x, rect.origin.x + rect.size.width))
        return false;
    
    if (point.y + range < MIN(rect.origin.y, rect.origin.y + rect.size.height))
        return false;
    
    if (point.x - range > MAX(rect.origin.x, rect.origin.x + rect.size.width))
        return false;
    
    if (point.y - range > MAX(rect.origin.y, rect.origin.y + rect.size.height))
        return false;
    
    return true;
}


static LineCircleIntersections LineIntersectionsOnCircle(Circle c, LineSegment line) {
    //Algorithm taken from http://mathworld.wolfram.com/Circle-LineIntersection.html
//    LOG_APP(@"LineIntersectionsOnCircle(Circle:[(%f,%f),%f], LineSegment:[(%f,%f),(%f,%f)])",c.center.x, c.center.y, c.radius,line.p1.x, line.p1.y,line.p2.x, line.p2.y);
    LineSegment zLine = LineSegmentMake(CGPointMake(line.p1.x - c.center.x, line.p1.y - c.center.y), CGPointMake(line.p2.x - c.center.x, line.p2.y - c.center.y));
    LineCircleIntersections intersections;
    CGFloat dx = zLine.p2.x - zLine.p1.x;
    CGFloat dy = zLine.p2.y - zLine.p1.y;
    
    CGFloat dLambda = sqrtf((dx * dx) + (dy * dy));
    CGFloat D = (zLine.p1.x * zLine.p2.y) - (zLine.p2.x * zLine.p1.y);
    CGFloat descriminant = ((sq(c.radius) * sq(dLambda)) - sq(D));
    intersections.number = descriminant < 0 ? 0 : (descriminant > 0 ? 2 : 1);
    if (intersections.number== 0) {
        return intersections;
    }
    
    CGFloat sqrt_descriminant = sqrtf(descriminant);
    CGFloat D_dy = D * dy;
    CGFloat sgn_dy_dx = sgn(dy) * dx;
    
    CGFloat xTopMain = (sgn_dy_dx * sqrt_descriminant);
    CGFloat xTop[2];
    xTop[0] = D_dy + xTopMain;
    xTop[1] = D_dy - xTopMain;
    
    CGFloat yTop[2];
    CGFloat yTopMain = fabsf(dy) * sqrt_descriminant;
    CGFloat yTopOther = -1 * D * dx;
    yTop[0] = yTopOther + yTopMain;
    yTop[1] = yTopOther - yTopMain;
    
    CGFloat dLambdaSq = sq(dLambda);
    CGPoint point[2];
    
    
    CGRect bounds = CGRectMakeFromPoints(line.p1, line.p2);
    CGPoint point1 = CGPointMake(xTop[0]/dLambdaSq + c.center.x, yTop[0]/dLambdaSq + c.center.y);
    NSUInteger intersectionsSet = 0;
    if (CGPointIsInRangeOfRect(point1, bounds, 0)) {
        point[intersectionsSet++] = point1;
    }
    
    CGPoint point2 = CGPointMake(xTop[1]/dLambdaSq + c.center.x, yTop[1]/dLambdaSq + c.center.y);
    if (CGPointIsInRangeOfRect(point2, bounds, 0)) {
        point[intersectionsSet++] = point2;
    }
    if (intersectionsSet > 1) {
        BOOL leftToRight = zLine.p1.x < zLine.p2.x;
        BOOL shouldReverse = leftToRight? (xTop[0] > xTop[1]) : ((xTop[0] < xTop[1]));
        
        if (xTop[0] == xTop[1]) {
            BOOL topToBottom = zLine.p1.y > zLine.p2.y;
            shouldReverse = topToBottom? (point1.y < point2.y) : (point1.y > point2.y);
        }
        if (shouldReverse) {
            point[0] = point2;
            point[1] = point1;
        }
    }
    intersections.number = intersectionsSet;
    intersections.point1 = point[0];
    if (intersectionsSet > 1)
        intersections.point2 = point[1];
    return intersections;
}

static BOOL CGPointIsInsideCircle(CGPoint p, Circle c) {
    CGFloat distance = CGPointDistance(p, c.center);
    return distance < (c.radius - 0.1);
}

static BOOL LineIsInsideCircle(LineSegment l, Circle c) {
    return CGPointIsInsideCircle(l.p1, c) && CGPointIsInsideCircle(l.p2, c);
}
