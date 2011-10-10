#import "DdFCGUtilsTests.h"
#import "DdFCGUtils.h"
#import "JSON.h"

#define JSON @"{\"x\":1.2,\"y\":3.4}"
@implementation DdFCGUtilsTests


-(void)testToJSON {
    CGPoint point = CGPointMake(1.2, 3.4);
    NSDictionary *jsonDictionary = CGPointToJSON(point);
    STAssertNotNil(jsonDictionary, @"Fail");
    STAssertEqualObjects(JSON, [jsonDictionary JSONRepresentation], @"Fail");
}

-(void)testFromJson {
    NSDictionary *jsonDictionary = [JSON JSONValue];
    CGPoint expected = CGPointMake(1.2, 3.4);
    CGPoint point = CGPointFromJSON(jsonDictionary);
    STAssertEquals(expected, point, @"Fail");
}
@end
