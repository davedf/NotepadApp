#import "DdFPadPadPage.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadLine.h"
#import "Log.h"

#define PAPER_KEY @"paper"
#define PAGE_NUMBER_KEY @"number"
#define LINES_KEY @"lines"

@interface DdFPadPadPage()
@end

@implementation DdFPadPadPage
@synthesize pageNumber=_pageNumber,paper=_paper,lines=_lines,identifier=_identifier,requiresSave=_requiresSave;

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines Identifier:(NSString*)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _paper = paper;
        self.pageNumber = pageNumber;
        _requiresSave = NO;
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
    if (![self.lines isEqual:other.lines]) {
        return NO;
    }
    return YES;
}

-(void)addLine:(DdFPadPadLine*)line {
    _lines = [_lines arrayByAddingObject:line];
    _requiresSave = YES;
}

-(void)changePaper:(DdFPadPadPaper*)newPaper {
    if ([_paper isEqual:newPaper]) {
        TRACE(@"no change to paper, skipping");
        return;
    }
    _paper = newPaper;
    _requiresSave = YES;
}

-(NSString*)filename {
    return [NSString stringWithFormat:@"%@.page",self.identifier];
}

-(void)UpdateNSFileWrapperRepresentation:(NSFileWrapper*)wrapper {
    TRACE(@"UpdateNSFileWrapperRepresentation");
    for (NSFileWrapper *currentWrapper in [wrapper.fileWrappers allValues]) {
        [wrapper removeFileWrapper:currentWrapper];
    }
    [wrapper addFileWrapper:[self.paper NSFileWrapperRepresentation]];    
    for (DdFPadPadLine *line in self.lines) {
        [wrapper addFileWrapper:[line NSFileWrapperRepresentation]];            
    }
    _requiresSave = NO;
}
-(NSFileWrapper*)NSFileWrapperRepresentation {
    TRACE(@"NSFileWrapperRepresentation");

    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:[NSDictionary dictionary]];
    wrapper.preferredFilename = self.filename;
    [self UpdateNSFileWrapperRepresentation:wrapper];
    return  wrapper;
}

+(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber NSFileWrapper:(NSFileWrapper*)wrapper {
    NSFileWrapper *paperWrapper = [wrapper.fileWrappers objectForKey:@"page.paper"];
    DdFPadPadPaper *paper = [DdFPadPadPaper paperWithNSFileWrapperRepresentation:paperWrapper];
    NSString *identifier = [DdFPadPadPage pageIdentifierFromNSFileWrapper:wrapper];
    return [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:pageNumber Lines:[DdFPadPadLine linesContainedByFileWrapper:wrapper] Identifier:identifier];
}

+(NSString*)pageIdentifierFromNSFileWrapper:(NSFileWrapper*)wrapper {
    NSString *fileName = wrapper.filename ? wrapper.filename : wrapper.preferredFilename;
    TRACE(@"fileName:%@",fileName);
    return  [[fileName componentsSeparatedByString:@"."] objectAtIndex:0];

}
@end
