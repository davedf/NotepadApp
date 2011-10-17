#import "DdFPadPadPaper.h"
#import "DdFPadPadPageLineInformation.h"

#define HORIZONTAL_KEY @"h"
#define VERTICAL_KEY @"v"

@implementation DdFPadPadPaper
@synthesize horizontal=_horizontal,vertical=_vertical;

-(id)initWithHoriziontal:(DdFPadPadPageLineInformation*)horizontal Vertical:(DdFPadPadPageLineInformation*)vertical {
    self = [super init];
    if (self) {
        _horizontal = horizontal;
        _vertical = vertical;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadPaper *other = (DdFPadPadPaper*)object;
    if (![self.horizontal isEqual:other.horizontal]) {
        return NO;
    }
    if (![self.vertical isEqual:other.vertical]) {
        return NO;
    }
    return YES;
}
-(NSDictionary*)DdFJSONRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [_horizontal DdFJSONRepresentation],HORIZONTAL_KEY, 
            [_vertical DdFJSONRepresentation],VERTICAL_KEY, 
            nil];
}

+(DdFPadPadPaper*)paperWithJSONRepresentation:(NSDictionary*)json {
    DdFPadPadPageLineInformation *h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:HORIZONTAL_KEY]];

    DdFPadPadPageLineInformation *v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:VERTICAL_KEY]];

    return [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v];
}
@end
