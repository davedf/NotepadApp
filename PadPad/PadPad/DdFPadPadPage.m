#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadLine.h"

#define PAPER_KEY @"paper"
#define PAGE_NUMBER_KEY @"number"
#define LINES_KEY @"lines"

@interface DdFPadPadPage()
@end

@implementation DdFPadPadPage
@synthesize pageNumber=_pageNumber,paper=_paper,lines=_lines,identifier=_identifier;

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines Identifier:(NSString*)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
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
    if (![self.identifier isEqualToString:other.identifier]) {
        return NO;
    }
    if (other.pageNumber != self.pageNumber) {
        return NO;
    }
    if (![self.paper isEqual:other.paper]) {
        return NO;
    }
    return YES;
}

-(NSFileWrapper*)NSFileWrapperRepresentation {
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:[NSDictionary dictionary]];
    wrapper.preferredFilename = [NSString stringWithFormat:@"%@.page",self.identifier];
    [wrapper addFileWrapper:[self.paper NSFileWrapperRepresentation]];
    return  wrapper;
}

+(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber NSFileWrapper:(NSFileWrapper*)wrapper {
    NSFileWrapper *paperWrapper = [wrapper.fileWrappers objectForKey:@"page.paper"];
    DdFPadPadPaper *paper = [DdFPadPadPaper paperWithNSFileWrapperRepresentation:paperWrapper];
    NSString *identifier = [[wrapper.filename componentsSeparatedByString:@"."] objectAtIndex:0];
    return [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:pageNumber Lines:[NSArray array] Identifier:identifier];
}
@end
