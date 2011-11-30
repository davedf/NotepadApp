#import "DdFCGUtilsTests.h"
#import "DdFCGUtils.h"
#import "JSON.h"

#define JSON @"{\"x\":1.2,\"y\":3.4}"
#define ACCURACY 0.00001

@interface DdFCGUtilsTests()
-(void )runIntersectionTestForCircle:(Circle )c LineSection:(LineSegment )l WithExpectedResult:(LineCircleIntersections )expected;

@end

@implementation DdFCGUtilsTests

-(void)testDistanceBetweenPoints {
    CGFloat result = CGPointDistance(CGPointMake(0.1, 0.2), CGPointMake(3.1, 4.2));
    STAssertEquals(5.0f, result, @"Fail");
    
}

-(void)testPointMagnitude {
    CGFloat result = CGPointMagnitude(CGPointMake(3, 4.0));
    STAssertEquals(5.0f, result, @"Fail");
}


-(void)testToJSON {
    CGPoint point = CGPointMake(1.2, 3.4);
    NSDictionary *jsonDictionary = CGPointToJSON(point);
    STAssertNotNil(jsonDictionary, @"Fail");
    STAssertEqualObjects(JSON, [jsonDictionary JSONRepresentation], @"Fail");
}

-(void)testFromJson {
    NSDictionary *jsonDictionary = [JSON JSONValue];
    CGPoint expected = CGPointMake(1.2, 3.4);
    CGPoint point = CGPointFromJSON(jsonDictionary);
    STAssertEquals(expected, point, @"Fail");
}

-(void)testPointIsInRange {
    CGPoint point = CGPointMake(2, 2);
    CGFloat range = 1.0;
    CGRect  rect = CGRectMake(2, 2, 1.0, 1.0);
    STAssertTrue(CGPointIsInRangeOfRect(point, rect, range), @"Fail point:[%f,%f] range:%f rect:[%f,%f,%f,%f]", point.x,point.y, range, rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
}

-(void)testPointToLeftOfRectIsNotInRange {
    CGPoint point = CGPointMake(0.9, 2);
    CGFloat range = 1.0;
    CGRect  rect = CGRectMake(2, 2, 1.0, 1.0);
    STAssertFalse(CGPointIsInRangeOfRect(point, rect, range), @"Fail point:[%f,%f] range:%f rect:[%f,%f,%f,%f]", point.x,point.y, range, rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
}

-(void)testPointBelowRectIsNotInRange {
    CGPoint point = CGPointMake(2, 0.9);
    CGFloat range = 1.0;
    CGRect  rect = CGRectMake(2, 2, 1.0, 1.0);
    STAssertFalse(CGPointIsInRangeOfRect(point, rect, range), @"Fail point:[%f,%f] range:%f rect:[%f,%f,%f,%f]", point.x,point.y, range, rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
}

-(void)testPointToRightOfRectIsNotInRange {
    CGPoint point = CGPointMake(4.1, 2);
    CGFloat range = 1.0;
    CGRect  rect = CGRectMake(2, 2, 1.0, 1.0);
    STAssertFalse(CGPointIsInRangeOfRect(point, rect, range), @"Fail point:[%f,%f] range:%f rect:[%f,%f,%f,%f]", point.x,point.y, range, rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
}

-(void)testPointAboveRectIsNotInRange {
    CGPoint point = CGPointMake(2, 4.1);
    CGFloat range = 1.0;
    CGRect  rect = CGRectMake(2, 2, 1.0, 1.0);
    STAssertFalse(CGPointIsInRangeOfRect(point, rect, range), @"Fail point:[%f,%f] range:%f rect:[%f,%f,%f,%f]", point.x,point.y, range, rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
}

-(void)testDistanceFromPointToLineWhenPointIsOnLine {
    
    CGPoint lp1 = CGPointMake(5.0, 5.0);
    CGPoint lp2 = CGPointMake(10, 10);
    CGPoint p1 = CGPointMake(7.0, 7.0);
    STAssertEqualsWithAccuracy((CGFloat)0, DistanceFromPointToLine(p1, lp1, lp2), ACCURACY, @"Fail");
}

-(void)testDistanceFromPointToLineWhenPointIsAboveLine {
    
    CGPoint lp1 = CGPointMake(5.0, 5.0);
    CGPoint lp2 = CGPointMake(10, 10);
    CGPoint p1 = CGPointMake(7.0, 8.0);
    STAssertEqualsWithAccuracy((CGFloat)0.707107, DistanceFromPointToLine(p1, lp1, lp2), ACCURACY, @"Fail");
}

-(void)testDistanceFromPointToLineWhenPointIsBelowLine {
    
    CGPoint lp1 = CGPointMake(5.0, 5.0);
    CGPoint lp2 = CGPointMake(10, 10);
    CGPoint p1 = CGPointMake(8.0, 7.0);
    STAssertEqualsWithAccuracy((CGFloat)0.707107, DistanceFromPointToLine(p1, lp1, lp2), ACCURACY, @"Fail");
}


-(void)testLineFormula {
    STAssertEquals(LineFormulaMake(1, 0), LineFormulaMakeFromPoints(CGPointMake(3, 3), CGPointMake(7, 7)), @"Fail line : y= x");;
    STAssertEquals(LineFormulaMake(1, 3), LineFormulaMakeFromPoints(CGPointMake(3, 6), CGPointMake(6, 9)), @"Fail line : y= x + 3");;
    STAssertEquals(LineFormulaMake(2, 1), LineFormulaMakeFromPoints(CGPointMake(2, 5), CGPointMake(3, 7)), @"Fail line : y= 2x + 1");;
    STAssertEquals(LineFormulaMake(-2, 1), LineFormulaMakeFromPoints(CGPointMake(2, -3), CGPointMake(3, -5)), @"Fail line : y= -2x + 1");;
    STAssertEquals(LineFormulaMake(0.5, 0.25), LineFormulaMakeFromPoints(CGPointMake(2, 1.25), CGPointMake(3, 1.75)), @"Fail line : y= 0.5x + 0.25");;
}

-(void )testLineFormulaIsOrderIndependent {
    CGPoint  p1 = CGPointMake(2, 1.25);
    CGPoint  p2 = CGPointMake(3, 1.75);
    STAssertEquals(LineFormulaMakeFromPoints(p2,p1), LineFormulaMakeFromPoints(p1,p2), @"Fail line : y= 0.5x + 0.25");;
}

-(void )testLineIntersectionsOnCircleIntersectionsSimpleLeftRight {
    LineSegment l = LineSegmentMake(CGPointMake(-3, 0), CGPointMake(3, 0));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(-2, 0), CGPointMake(2, 0));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsSimpleRightLeft {
    LineSegment l = LineSegmentMake(CGPointMake(3, 0), CGPointMake(-3, 0));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(2, 0), CGPointMake(-2, 0));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsSimpleTopToBottom {
    LineSegment l = LineSegmentMake(CGPointMake(0, 3), CGPointMake(0, -3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(0, 2), CGPointMake(0, -2));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsSimpleBottomToTop {
    LineSegment l = LineSegmentMake(CGPointMake(0, -3), CGPointMake(0, 3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(0, -2), CGPointMake(0, 2));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsTopLeftToBottomRight {
    LineSegment l = LineSegmentMake(CGPointMake(-3, 3), CGPointMake(3, -3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGFloat pos = 1.4142137f;
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(-pos, pos), CGPointMake(pos, -pos));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsBottomRightToTopLeft {
    LineSegment l = LineSegmentMake(CGPointMake(3, -3), CGPointMake(-3, 3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGFloat pos = 1.4142137f;
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(pos, -pos), CGPointMake(-pos, pos));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsBottomLeftToTopRight {
    LineSegment l = LineSegmentMake(CGPointMake(-3, -3), CGPointMake(3, 3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGFloat pos = 1.4142137f;
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(-pos, -pos), CGPointMake(pos, pos));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsTopRightToBottomLeft {
    LineSegment l = LineSegmentMake(CGPointMake(3, 3), CGPointMake(-3, -3));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGFloat pos = 1.4142137f;
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(pos, pos), CGPointMake(-pos, -pos));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsOffset {
    LineSegment l = LineSegmentMake(CGPointMake(0, 0), CGPointMake(6, 6));
    Circle  c= CircleMake(CGPointMake(2, 2), 2);
    CGFloat pos = 1.4142137f;
    LineCircleIntersections expected = LineCircleIntersectionsMake(2, CGPointMake(2-pos, 2-pos), CGPointMake(2+pos, 2+pos));
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsRightPointInsideCircle {
    LineSegment l = LineSegmentMake(CGPointMake(-3, 0), CGPointMake(1, 0));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGPoint empty;
    LineCircleIntersections expected = LineCircleIntersectionsMake(1, CGPointMake(-2, 0), empty);
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsLeftPointInsideCircle {
    LineSegment l = LineSegmentMake(CGPointMake(-1, 0), CGPointMake(3, 0));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGPoint empty;
    LineCircleIntersections expected = LineCircleIntersectionsMake(1, CGPointMake(2, 0), empty);
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

-(void )testLineIntersectionsOnCircleIntersectionsBothPointsInsideCircle {
    LineSegment l = LineSegmentMake(CGPointMake(-1, 0), CGPointMake(1, 0));
    Circle  c= CircleMake(CGPointMake(0, 0), 2);
    CGPoint empty;
    LineCircleIntersections expected = LineCircleIntersectionsMake(0, empty, empty);
    [self runIntersectionTestForCircle:c LineSection:l WithExpectedResult:expected];
}

#pragma mark - helpers
-(void )runIntersectionTestForCircle:(Circle )c LineSection:(LineSegment )l WithExpectedResult:(LineCircleIntersections )expected {
    LineCircleIntersections result = LineIntersectionsOnCircle(c, l);
    STAssertEquals(expected.number, result.number, @"Fail:result.number expected:%d was:%d", expected.number, result.number);
    if  (expected.number > 0) {
        STAssertEquals(expected.point1, result.point1, @"Fail:result.point1");
    }
    if  (expected.number > 1) {
        STAssertEquals(expected.point2, result.point2, @"Fail:result.point2");
    }
}

@end
