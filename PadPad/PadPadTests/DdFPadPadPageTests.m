#import "DdFPadPadPageTests.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageLineInformationTests.h"
#import "DdFPadPadPageLineInformation.h"
#import "DdFPadPadPaper.h"
#import "JSON.h"
@implementation DdFPadPadPageTests {
    DdFPadPadPaper *paper;
    DdFPadPadPage *underTest;
}

-(void)setUp {
    [super setUp];
    DdFPadPadPageLineInformation *h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_MAJOR_LINES JSONValue]];
    DdFPadPadPageLineInformation *v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_NO_MAJOR_LINES JSONValue]];
    
    paper = [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v];

    underTest = [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:1 Lines:[NSArray array] Identifier:@"foo"];
                  
}

-(void)testPaperSet {
    STAssertEqualObjects(paper, underTest.paper, @"Fail");
}

-(void)testPageNumberSet {
    STAssertEquals((NSUInteger)1, underTest.pageNumber, @"Fail");
}

-(void)testPageLabel {
    STAssertEqualObjects(@"1", underTest.pageLabel, @"Fail");
}

-(void)testIdentifierSet {
    STAssertEqualObjects(@"foo", underTest.identifier, @"Fail");
}

-(void)testFileWrapperHasNameSet {
    NSFileWrapper *wrapper= [underTest NSFileWrapperRepresentation];
    STAssertEqualObjects(@"foo.page", wrapper.preferredFilename, @"File");
}

-(void)testFileWrapperHasPaper {
    NSFileWrapper *wrapper= [underTest NSFileWrapperRepresentation];

    NSFileWrapper *paperWrapper = [wrapper.fileWrappers objectForKey:@"page.paper"];
    STAssertNotNil(paperWrapper, @"Fail");
    DdFPadPadPaper *newPaper = [DdFPadPadPaper paperWithNSFileWrapperRepresentation:paperWrapper];
    STAssertEqualObjects(newPaper, paper, @"Fail");
}
@end
