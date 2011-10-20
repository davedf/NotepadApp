#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"

#define PAPER_KEY @"paper"
#define PAGE_NUMBER_KEY @"number"

@implementation DdFPadPadPage
@synthesize pageNumber=_pageNumber,paper=_paper;

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber {
    self = [super init];
    if (self) {
        self.paper = paper;
        self.pageNumber = pageNumber;
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
-(NSDictionary*)DdFJSONRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:self.pageNumber], PAGE_NUMBER_KEY,
            [self.paper DdFJSONRepresentation],PAPER_KEY,
            nil];
}

+(DdFPadPadPage*)pageFromJSONDictionary:(NSDictionary*)jsonDictionary {
    NSUInteger pageNumber = [[jsonDictionary objectForKey:PAGE_NUMBER_KEY] intValue];
    DdFPadPadPaper *paper = [DdFPadPadPaper paperWithJSONRepresentation:[jsonDictionary objectForKey:PAPER_KEY]];
    return [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:pageNumber];
}
@end
