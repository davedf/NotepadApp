#import "UIColor+DdFJSONTests.h"
#import "UIColor+DdFJSON.h"

@implementation UIColor_DdFJSONTests
-(void)testJsonRepresentation {
    UIColor *color = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:0.4];
    NSString *json = [color DdFJSONRepresentation];
    STAssertEqualObjects(@"{\"r\":0.1,\"b\":0.3,\"g\":0.2,\"a\":0.4}", json, @"Fail");
}

@end
