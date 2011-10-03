#import "DdFPadPadLinePointTests.h"
#import "DdFPadPadLinePoint.h"

@implementation DdFPadPadLinePointTests {
    DdFPadPadLinePoint *underTest;
    CGPoint _origin;
    CGPoint _velocity;
}

-(void)setUp
{
    [super setUp];  
    _origin = CGPointMake(1, 2);
    _velocity = CGPointMake(3.0, 4.0);
    underTest = [[DdFPadPadLinePoint alloc] initWithOrigin:_origin velocity:_velocity];
}

-(void)testSpeedIsCalculated {    
    STAssertEquals(5.0f, underTest.speed, @"Fail");    
}

-(void)testOriginSet {
    STAssertEquals(_origin, underTest.origin, @"Fail");    
}

-(void)testVelocitySet {
    STAssertEquals(_velocity, underTest.velocity, @"Fail");        
}
@end
