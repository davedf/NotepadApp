#import "DdFPadPadInk.h"
#import "JSON.h"
#import "UIColor+DdFJSON.h"
#import "NSDictionary+DdFJSON.h"

#define COLOR_KEY @"color"
#define INK_SIZE_KEY @"size"
#define INK_TYPE_KEY @"type"

@implementation DdFPadPadInk {
    UIColor *_color;
    DdFPadPadInkType _inkType;
    DdFPadPadInkSize _inkSize;
}
@synthesize inkSize=_inkSize,inkType=_inkType,color=_color;

-(id)initWithColorRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue Alpha:(CGFloat)alpha Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type {
    self = [super init];
    if (self) {
        _color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        _inkSize = size;
        _inkType = type;
    }
    return self;
}

-(id)initWithJSONDictionary:(NSDictionary*)json {
    self = [super init];
    if (self) {
        _color = [[json objectForKey:COLOR_KEY] UIColorJSONValue];
        _inkSize = [[json objectForKey:INK_SIZE_KEY] floatValue];
        _inkType = [[json objectForKey:INK_TYPE_KEY] intValue];
    }
    return self;
}

-(NSString*)InkJSONDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
                                [self.color DdFJSONDictionary],COLOR_KEY,
                                [NSNumber numberWithFloat:self.inkSize],INK_SIZE_KEY,
                                [NSNumber numberWithInt:self.inkType],INK_TYPE_KEY,
                                nil];    
}

-(NSString*)InkJSONRepresentation {
    return [[self InkJSONDictionary] JSONRepresentation];
}


-(BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if ([self class] != [object class]) {        
        return NO;
    }
    DdFPadPadInk *other = (DdFPadPadInk*)object;
    if (other.inkSize != self.inkSize) {
        return NO;
    }
    if (other.inkType != self.inkType) {
        return NO;
    }
    if (![other.color isEqual:self.color]) {
        return NO;
    }
    return YES;
}
@end
