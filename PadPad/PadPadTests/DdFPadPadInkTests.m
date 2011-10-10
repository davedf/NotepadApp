#import "DdFPadPadInkTests.h"
#import "DdFPadPadInk.h"

@implementation DdFPadPadInkTests {
    UIColor *color;
    DdFPadPadInkSize inkSize;
    DdFPadPadInkType inkType;
    DdFPadPadInk *underTest;
}

-(void)setUp {
    [super setUp];
    color = [UIColor darkGrayColor];
    inkSize = 1.5;
    inkType = kFeltTip;
    underTest = [[DdFPadPadInk alloc]initWithColor:color Size:inkSize Type:inkType];
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

-(void)testNSFileWrapperRepresentationHasExpectedFileName {
    
}
@end
