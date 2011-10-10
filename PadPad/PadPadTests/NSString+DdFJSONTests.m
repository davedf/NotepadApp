#import "NSString+DdFJSONTests.h"
#import "NSString+DdFJSON.h"

@implementation NSString_DdFJSONTests

-(void)testUIColorJSONValue {
    NSString *json = @"{\"r\":0.100000,\"g\":0.200000,\"b\":0.300000,\"a\":0.400000}";
    UIColor *color = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:0.4];
    STAssertEqualObjects(color, [json UIColorJSONValue], @"Fail");
}
@end
