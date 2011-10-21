#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadLine.h"

#define PAPER_KEY @"paper"
#define PAGE_NUMBER_KEY @"number"
#define LINES_KEY @"lines"

@interface DdFPadPadPage()
-(NSArray*)LinesJSONRepresentation;
@end

@implementation DdFPadPadPage
@synthesize pageNumber=_pageNumber,paper=_paper,lines=_lines;

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines {
    self = [super init];
    if (self) {
        self.paper = paper;
        self.pageNumber = pageNumber;
        _lines = lines;
    }
    return self;
}
-(NSString*)pageLabel {
    return [NSString stringWithFormat:@"%d",self.pageNumber];
}

-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadPage *other = (DdFPadPadPage*)object;
    if (other.pageNumber != self.pageNumber) {
        return NO;
    }
    if (![self.paper isEqual:other.paper]) {
        return NO;
    }
    return YES;
}
-(NSArray*)LinesJSONRepresentation {
    NSMutableArray *jsonLines = [[NSMutableArray alloc]initWithCapacity:self.lines.count];
    for (DdFPadPadLine *line in self.lines) {
        [jsonLines addObject:[line DdFJSONRepresentation]];
    }
    return jsonLines;
}
-(NSDictionary*)DdFJSONRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.pageNumber], PAGE_NUMBER_KEY,
            [self.paper DdFJSONRepresentation],PAPER_KEY,
            [self LinesJSONRepresentation], LINES_KEY,
            nil];
}

+(DdFPadPadPage*)pageFromJSONDictionary:(NSDictionary*)jsonDictionary {
    NSUInteger pageNumber = [[jsonDictionary objectForKey:PAGE_NUMBER_KEY] intValue];
    DdFPadPadPaper *paper = [DdFPadPadPaper paperWithJSONRepresentation:[jsonDictionary objectForKey:PAPER_KEY]];
//    NSArray *jsonLines = [jsonDictionary objectForKey:LINES_KEY];
//    NSMutableArray *lines = [[NSMutableArray alloc]initWithCapacity:jsonLines.count];
//    for (NSDictionary *jsonLine in jsonLines) {
//        [lines addObject:[DdFPadPadLine lin
//    }
    return [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:pageNumber Lines:[NSArray array]];
}
@end
