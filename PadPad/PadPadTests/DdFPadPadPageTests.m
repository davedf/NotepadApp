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

    underTest = [[DdFPadPadPage alloc]initWithPaper:paper PageNumber:1];
                  
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

-(void)testDdFJSONRepresentation {
    NSString *expected = [NSString stringWithFormat:@"{\"number\":%d,\"paper\":%@}",underTest.pageNumber,[[underTest.paper DdFJSONRepresentation] JSONRepresentation]];
    STAssertEqualObjects(expected, [[underTest DdFJSONRepresentation] JSONRepresentation], @"Fail");
}

-(void)testFromJSONRepresentation {
   NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInt:underTest.pageNumber], @"number",
                         [underTest.paper DdFJSONRepresentation], @"paper", 
                         nil ];
    DdFPadPadPage *result = [DdFPadPadPage pageFromJSONDictionary:json];
    STAssertEqualObjects(result, underTest, @"Fail");
}
@end
