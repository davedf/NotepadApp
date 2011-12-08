#import "DdFPadPadInkTests.h"
#import "DdFPadPadInk.h"
#import "UIColor+DdFJSON.h"
#import "JSON.h"
#import "DdFPadPadColor.h"
#import "DdFPadPadPenRepository.h"
@implementation DdFPadPadInkTests {
    DdFPadPadColor *color;
    DdFPadPadInkSize inkSize;
    DdFPadPadInkType inkType;
    DdFPadPadInk *underTest;
}

-(void)setUp {
    [super setUp];
    DdFPadPadInk *ink = [[DdFPadPadPenRepository sharedDdFPadPadPenRepository]ink:INK_BLACK_FAINT_PAPER];
    color = ink.color;
    inkSize = ink.inkSize;
    inkType = ink.inkType;
    
    underTest = [[DdFPadPadInk alloc]initWithColor:color Size:inkSize Type:inkType Name:INK_BLACK_FAINT_PAPER];
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
    STAssertEqualObjects(underTest.name, [underTest InkJSONRepresentation], @"Fail");
}

-(void)testJSONRepresentationRoundTrip {
    NSString *json = [underTest InkJSONRepresentation];
    DdFPadPadInk *restored = [DdFPadPadInk inkFromJson:json];
    STAssertEqualObjects(restored.color, underTest.color, @"Fail");
    STAssertEquals(restored.inkSize, underTest.inkSize, @"Fail");
    STAssertEquals(restored.inkType, underTest.inkType, @"Fail");
    STAssertEqualObjects(restored, underTest, @"Fail");
}

@end
