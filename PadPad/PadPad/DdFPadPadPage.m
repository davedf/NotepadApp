#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadLine.h"

#define PAPER_KEY @"paper"
#define PAGE_NUMBER_KEY @"number"
#define LINES_KEY @"lines"

@interface DdFPadPadPage()
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

@end
