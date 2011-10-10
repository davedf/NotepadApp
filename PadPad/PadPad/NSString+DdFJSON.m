#import "NSString+DdFJSON.h"
#import "NSDictionary+DdFJSON.h"
#import "JSON.h"

@implementation NSString (DdFJSON)

-(UIColor*)UIColorJSONValue {
    NSDictionary *json = [self JSONValue];
    return [json UIColorJSONValue];
}
@end
