#import "DdFPadPadLinePointTests.h"
#import "DdFPadPadLinePoint.h"
#import "JSON.h"

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

-(void)testToJSONRepresentation {
    NSString *expected = @"[1,2,3,4]";

    NSArray *jsonArray = [underTest DdFJSONRepresentation];
    NSString *json = [jsonArray JSONRepresentation];
    STAssertEqualObjects(expected, json, @"Fail");
}

-(void)testFromJSONRepresentation {
    NSString *json = @"[1,2,3,4]";

    DdFPadPadLinePoint *linePoint = [[DdFPadPadLinePoint alloc] initWithJSONRepresentation:[json JSONValue]];
    STAssertEqualObjects(linePoint, underTest, @"Fail");
                                     
}
@end
