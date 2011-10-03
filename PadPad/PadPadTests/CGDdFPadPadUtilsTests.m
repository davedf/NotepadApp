#import "CGDdFPadPadUtilsTests.h"
#import "CGDdFPadPadUtils.h"

@implementation CGDdFPadPadUtilsTests

-(void)testDistanceBetweenPoints {
    CGFloat result = CGPointDistance(CGPointMake(0.1, 0.2), CGPointMake(3.1, 4.2));
    STAssertEquals(5.0f, result, @"Fail");
    
}

-(void)testPointMagnitude {
    CGFloat result = CGPointMagnitude(CGPointMake(3, 4.0));
    STAssertEquals(5.0f, result, @"Fail");
}

@end
