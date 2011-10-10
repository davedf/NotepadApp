#import "DdFPadPadInkTests.h"
#import "DdFPadPadInk.h"
#import "UIColor+DdFJSON.h"
#import "JSON.h"

@implementation DdFPadPadInkTests {
    UIColor *color;
    DdFPadPadInkSize inkSize;
    DdFPadPadInkType inkType;
    DdFPadPadInk *underTest;
}

-(void)setUp {
    [super setUp];
    color = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:0.4];
    inkSize = 1.5;
    inkType = kFeltTip;
    underTest = [[DdFPadPadInk alloc]initWithColorRed:0.1 Green:0.2 Blue:0.3 Alpha:0.4 Size:inkSize Type:inkType];
}

-(void)testSetsColor {
    STAssertEqualObjects(color, underTest.color, @"Fail");
}

-(void)testSetsSize {
    STAssertEquals(inkSize, underTest.inkSize, @"Fail");
}

-(void)testSetsInkType {
    STAssertEquals(inkType, underTest.inkType, @"Fail");
}

-(void)testJSONRepresentation {
    NSString *expected = [NSString stringWithFormat:@"{\"color\":%@,\"type\":0,\"size\":1.5}",[color DdFJSONRepresentation]];
    STAssertEqualObjects(expected, [underTest InkJSONRepresentation], @"Fail");
}

-(void)testJSONRepresentationRoundTrip {
    NSString *json = [underTest InkJSONRepresentation];
    NSDictionary *jsonDictionary = [json JSONValue];
    DdFPadPadInk *restored = [[DdFPadPadInk alloc]initWithJSONDictionary:jsonDictionary];
    STAssertEqualObjects(restored.color, underTest.color, @"Fail");
    STAssertEquals(restored.inkSize, underTest.inkSize, @"Fail");
    STAssertEquals(restored.inkType, underTest.inkType, @"Fail");
    STAssertEqualObjects(restored, underTest, @"Fail");
}

@end
