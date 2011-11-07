#import "DdFPadPadInk.h"
#import "JSON.h"

#define COLOR_KEY @"color"
#define INK_SIZE_KEY @"size"
#define INK_TYPE_KEY @"type"

@implementation DdFPadPadInk 
@synthesize inkSize=_inkSize,inkType=_inkType,color=_color;

-(id)initWithColor:(DdFPadPadColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type {
    self = [super init];
    if (self) {
        _color = color;
        _inkSize = size;
        _inkType = type;
    }
    return self;
}

-(id)initWithJSONDictionary:(NSDictionary*)json {
    self = [super init];
    if (self) {
        _color = [DdFPadPadColor colorFromJSONRepresentation: [json objectForKey:COLOR_KEY]];
        _inkSize = [[json objectForKey:INK_SIZE_KEY] floatValue];
        _inkType = [[json objectForKey:INK_TYPE_KEY] intValue];
    }
    return self;
}

-(NSString*)InkJSONDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
                                [self.color DdFJSONRepresentation],COLOR_KEY,
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
