#import "DdFPadPadInkTests.h"
#import "DdFPadPadInk.h"
#import "UIColor+DdFJSON.h"
#import "JSON.h"
#import "DdFPadPadColor.h"

@implementation DdFPadPadInkTests {
    DdFPadPadColor *color;
    DdFPadPadInkSize inkSize;
    DdFPadPadInkType inkType;
    DdFPadPadInk *underTest;
}

-(void)setUp {
    [super setUp];
    color = [DdFPadPadColor blackInk];
    inkSize = 1.5;
    inkType = kFeltTip;
    underTest = [[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:inkSize Type:inkType];
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
    NSString *expected = [NSString stringWithFormat:@"{\"color\":%@,\"type\":0,\"size\":1.5}",[color.color DdFJSONRepresentation]];
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
