#import "DdFPadPadPaper.h"
#import "DdFPadPadPageLineInformation.h"
#import "JSON.h"
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

-(NSFileWrapper*)NSFileWrapperRepresentation {
    NSString *json = [[self DdFJSONRepresentation] JSONRepresentation];
    NSData *data = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    [wrapper setPreferredFilename:@"page.paper"];
    return wrapper;

}

+(DdFPadPadPaper*)paperWithNSFileWrapperRepresentation:(NSFileWrapper*)wrapper {
    NSString *json = [[NSString alloc]initWithBytes:[wrapper.regularFileContents bytes] length:[wrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [json JSONValue];
    return [DdFPadPadPaper paperWithJSONRepresentation:jsonDictionary];
}

+(DdFPadPadPaper*)paperWithJSONRepresentation:(NSDictionary*)json {
    DdFPadPadPageLineInformation *h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:HORIZONTAL_KEY]];

    DdFPadPadPageLineInformation *v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:VERTICAL_KEY]];

    return [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v];
}
@end
