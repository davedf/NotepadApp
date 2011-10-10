#import "UIColor+DdFJSON.h"
#import "JSON.h"

@implementation UIColor (DdFJSON)

-(NSDictionary*)DdFJSONDictionary {
    CGFloat red,green,blue,alpha;
    
    BOOL gotColor = [self getRed:&red green:&green blue:&blue alpha:&alpha];
    if (gotColor) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithFloat:red],@"r",
                [NSNumber numberWithFloat:green],@"g",
                [NSNumber numberWithFloat:blue],@"b",
                [NSNumber numberWithFloat:alpha],@"a",
                nil];
    }
    return nil;
    
}
-(NSString*)DdFJSONRepresentation {
    NSDictionary *json = [self DdFJSONDictionary];
    if (json) {
        return [json JSONRepresentation];        
    }
    return nil;
}
@end
