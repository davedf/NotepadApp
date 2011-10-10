#import "DdFPadPadLineTests.h"
#import "DdFPadPadLine.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadLinePoint.h"

@implementation DdFPadPadLineTests {
    DdFPadPadLine *underTest;
    DdFPadPadInk *ink;
}

-(void)setUp {
    ink = [[DdFPadPadInk alloc]initWithColorRed:0 Green:0 Blue:0 Alpha:1 Size:10 Type:kFeltTip];
    underTest = [[DdFPadPadLine alloc]initWithInk:ink Points:[NSArray array]];
}

-(void)testInkIsSet {
    STAssertEqualObjects(ink, underTest.ink, @"Fail");
}

-(void)testPointsAreSet {
    STAssertEqualObjects([NSArray array], underTest.points, @"Fail");
}

-(void)testPointAreNeverNil {
    underTest = [[DdFPadPadLine alloc]initWithInk:ink Points:nil];
    STAssertEqualObjects([NSArray array], underTest.points, @"Fail");
}

-(void)testEmptyLineHasEmptyBounds {
    STAssertEquals(CGRectMake(0, 0, 0, 0), underTest.bounds, @"Fail");
}

-(void)testPointAdded {
    DdFPadPadLinePoint *point = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(1, 1) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point];
    NSArray *expected= [NSArray arrayWithObject:point];
    STAssertEqualObjects(expected, underTest.points, @"Fail");
}

-(void)testAddingPointsChangesBounds {
    DdFPadPadLinePoint *point1 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(1, 1) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point1];
    STAssertEquals(CGRectMake(1, 1, 0, 0), underTest.bounds, @"Fail");
    
    DdFPadPadLinePoint *point2 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(2, 2) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point2];
    STAssertEquals(CGRectMake(1, 1, 1, 1), underTest.bounds, @"Fail");
}

@end
