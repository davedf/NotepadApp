#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"
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
@end
