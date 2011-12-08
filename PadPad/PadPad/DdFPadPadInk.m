#import "DdFPadPadInk.h"
#import "JSON.h"
#import "DdFPadPadPenRepository.h"

#define COLOR_KEY @"color"
#define INK_SIZE_KEY @"size"
#define INK_TYPE_KEY @"type"

@implementation DdFPadPadInk 
@synthesize inkSize=_inkSize,inkType=_inkType,color=_color,name=_name;

-(id)initWithColor:(DdFPadPadColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type Name:(NSString*)name{
    self = [super init];
    if (self) {
        _color = color;
        _inkSize = size;
        _inkType = type;
        _name = name;
    }
    return self;
}

//-(id)initWithJSONDictionary:(NSString*)json {
//    self = [super init];
//    if (self) {
//        
//        _color = [DdFPadPadColor colorFromJSONRepresentation: [json objectForKey:COLOR_KEY]];
//        _inkSize = [[json objectForKey:INK_SIZE_KEY] floatValue];
//        _inkType = [[json objectForKey:INK_TYPE_KEY] intValue];
//    }
//    return self;
//}

-(id)copy {
    return [[DdFPadPadInk alloc]initWithColor:_color Size:_inkSize Type:_inkType Name:_name];
}

+(DdFPadPadInk*)inkFromJson:(NSString*)json {
    return [[DdFPadPadPenRepository sharedDdFPadPadPenRepository]ink:json];
}
-(NSString*)InkJSONRepresentation {
    return self.name;
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
