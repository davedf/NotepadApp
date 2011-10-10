#import "NSDictionary+DdFJSON.h"

@implementation NSDictionary (DdFJSON)

-(UIColor*)UIColorJSONValue {
    NSNumber *red = [self objectForKey:@"r"];
    NSNumber *green = [self objectForKey:@"g"];
    NSNumber *blue = [self objectForKey:@"b"];
    NSNumber *alpha = [self objectForKey:@"a"];
    return [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:[alpha floatValue]];
}

@end
