#import "DdFPadPadLineTests.h"
#import "DdFPadPadLine.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadLinePoint.h"
#import "DdFPadPadPenRepository.h"
#define JSON_EXAMPLE @"{\"ink\":\"bk1\",\"points\":[[1,1,0,0],[2,2,0,0]]}"

@interface DdFPadPadLineTests()
-(void)addExtraPoints;
@end

@implementation DdFPadPadLineTests {
    DdFPadPadLine *underTest;
    DdFPadPadInk *ink;
}

-(void)setUp {
    ink = [DdFPadPadInk inkFromJson:INK_BLACK_1];
    underTest = [[DdFPadPadLine alloc]initWithId:@"foobar" Ink:ink Points:[NSArray array]];
}

-(void)testInkIsSet {
    STAssertEqualObjects(ink, underTest.ink, @"Fail");
}

-(void)testPointsAreSet {
    STAssertEqualObjects([NSArray array], underTest.points, @"Fail");
}

-(void)testPointAreNeverNil {
    underTest = [[DdFPadPadLine alloc]initWithId:@"foobar" Ink:ink Points:nil];
    STAssertEqualObjects([NSArray array], underTest.points, @"Fail");
}

-(void)testEmptyLineHasEmptyBounds {
    STAssertEquals(CGRectMake(0, 0, 0, 0), underTest.bounds, @"Fail");
}

-(void)testPointAdded {
    DdFPadPadLinePoint *point = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(1, 1) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point];
    STAssertEquals(CGRectMake(1, 1, 0, 0), underTest.bounds, @"Fail");
    NSArray *expected= [NSArray arrayWithObject:point];
    STAssertEqualObjects(expected, underTest.points, @"Fail");
}

-(void)testAddingPointsChangesBounds {
    [self addExtraPoints];
    STAssertEquals(CGRectMake(1, 1, 1, 1), underTest.bounds, @"Fail");
}

-(void)testNSFileWrapperHasFileName {
    NSFileWrapper *wrapper = [underTest NSFileWrapperRepresentation];
    STAssertNotNil(wrapper, @"Fail");
    STAssertEqualObjects(@"foobar.line", wrapper.preferredFilename, @"Fail");
}
-(void)testNSFileWrapperContainsJSON {
    [self addExtraPoints];

    NSFileWrapper *wrapper = [underTest NSFileWrapperRepresentation];
    NSString *json = [[NSString alloc]initWithBytes:[wrapper.regularFileContents bytes] length:[wrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    STAssertEqualObjects(JSON_EXAMPLE,json, @"Fail");
}

-(void)testRehydrateJSON {
    [self addExtraPoints];
    NSData *data = [NSData dataWithBytes:[JSON_EXAMPLE UTF8String] length:[JSON_EXAMPLE length]];
    
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    [wrapper setFilename:[NSString stringWithFormat:@"%@.line",@"foobar"]];
    DdFPadPadLine *result = [DdFPadPadLine lineFromNSFileWrapper:wrapper];
    STAssertEqualObjects(@"foobar", result.lineId, @"Fail");
    STAssertEqualObjects(underTest.ink, result.ink, @"Fail");
    STAssertEqualObjects(underTest.points, result.points, @"Fail");
}

#pragma mark - DdFPadPadLineTests()
-(void)addExtraPoints {
    DdFPadPadLinePoint *point1 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(1, 1) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point1];
    STAssertEquals(CGRectMake(1, 1, 0, 0), underTest.bounds, @"Fail");
    
    DdFPadPadLinePoint *point2 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(2, 2) velocity:CGPointMake(0, 0)];
    [underTest addPoint:point2];
 
}

@end
