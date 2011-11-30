//
//  DdFPadPadLineBuilderTests.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLineBuilderTests.h"
#import "DdFPadPadLineBuilder.h"
#import "DdFPadPadLinePoint.h"
@implementation DdFPadPadLineBuilderTests {
    DdFPadPadLineBuilder *underTest;
    CGPoint p00, p11, p10, p01;

}

-(void)setUp {
    [super setUp];
    underTest = [[DdFPadPadLineBuilder alloc] initWithGranularityMin:1.0 WithGranularityMax:5.0];
    p00 = CGPointMake(0.0, 0.0);
    p10 = CGPointMake(1.0, 0.0);
    p01 = CGPointMake(0.0, 1.0);
    p11 = CGPointMake(1.0, 1.0);
    
}

-(void)testReplacesPointsCloserThanGranularity {
    [underTest addPoint:p00 WithVelocity:p01];
    CGPoint newPoint = CGPointMake(0.0, 0.99);
    [underTest addPoint:newPoint WithVelocity:p10];
    STAssertEquals(((NSUInteger)2), [underTest.linePoints count], @"fail");    
    DdFPadPadLinePoint *lastPoint = [underTest.linePoints lastObject];
    STAssertEquals(lastPoint.origin, newPoint, @"Fail");
    [underTest addPoint:p11 WithVelocity:p10];
    STAssertEquals(((NSUInteger)2), [underTest.linePoints count], @"fail");    
    lastPoint = [underTest.linePoints lastObject];
    STAssertEquals(lastPoint.origin, p11, @"Fail");
}

-(void)testResetClearsSegments {
    [underTest addPoint:p00 WithVelocity:p01];
    [underTest addPoint:p11 WithVelocity:p11];
    [underTest newLine];
    STAssertEquals(((NSUInteger)0), [underTest.linePoints count], @"fail");    
}

-(void)testResetCreatesANewArrayForSegments {
    NSArray *points = underTest.linePoints;
    [underTest addPoint:p00 WithVelocity:p01];
    [underTest addPoint:p11 WithVelocity:p11];
    [underTest newLine];
    STAssertEquals(((NSUInteger)2), [points count], @"fail");    
}

@end
