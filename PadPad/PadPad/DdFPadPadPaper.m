#import "DdFPadPadPaper.h"
#import "DdFPadPadPageLineInformation.h"
#import "JSON.h"
#import "DdFPadPadColor.h"

#define HORIZONTAL_KEY @"h"
#define VERTICAL_KEY @"v"
#define PAPER_COLOR_KEY @"c"

@implementation DdFPadPadPaper
@synthesize horizontal=_horizontal,vertical=_vertical,paperColor=_paperColor;

-(id)initWithHoriziontal:(DdFPadPadPageLineInformation*)horizontal Vertical:(DdFPadPadPageLineInformation*)vertical PaperColor:(DdFPadPadColor*)paperColor {
    self = [super init];
    if (self) {
        _horizontal = horizontal;
        _vertical = vertical;
        _paperColor = paperColor;
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
    if (![self.paperColor.color isEqual:other.paperColor.color]) {
        return NO;
    }
    return YES;
}
-(NSDictionary*)DdFJSONRepresentation {

    NSMutableDictionary *rep = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_paperColor DdFJSONRepresentation],PAPER_COLOR_KEY, nil];
    if (_horizontal) {
        [rep setObject:[_horizontal DdFJSONRepresentation] forKey:HORIZONTAL_KEY];
    }
    if (_vertical) {
        [rep setObject:[_vertical DdFJSONRepresentation] forKey:VERTICAL_KEY];
    }
    return [NSDictionary dictionaryWithDictionary:rep];            
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
    DdFPadPadPageLineInformation *h = nil;
    if ([[json allKeys] containsObject:HORIZONTAL_KEY]) {
        h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:HORIZONTAL_KEY]];        
    }

    DdFPadPadPageLineInformation *v = nil;
    if ([[json allKeys] containsObject:VERTICAL_KEY]) {
        v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[json objectForKey:VERTICAL_KEY]];
    }
    
    DdFPadPadColor *paperColor = [DdFPadPadColor colorFromJSONRepresentation:[json objectForKey:PAPER_COLOR_KEY]];

    return [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v PaperColor:paperColor];
}
@end
