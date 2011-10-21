#import "DdFPadPadPaperTests.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadPageLineInformation.h"
#import "JSON.h"
#import "DdFPadPadPageLineInformationTests.h"
@implementation DdFPadPadPaperTests {
    DdFPadPadPaper *underTest;
    DdFPadPadPageLineInformation *h;
    DdFPadPadPageLineInformation *v;
}

-(void)setUp {
    [super setUp];
    h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_MAJOR_LINES JSONValue]];
    v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_NO_MAJOR_LINES JSONValue]];
    
    underTest = [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v];
}

-(void)testVerticalSet {
    STAssertNotNil(underTest.vertical, @"Fail");
}

-(void)testHorizontalSet {
    STAssertNotNil(underTest.horizontal, @"Fail");
}

-(void)testJSONRepresentation {
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
     [h DdFJSONRepresentation],@"h", 
     [v DdFJSONRepresentation],@"v", 
     nil];
    STAssertEqualObjects([underTest DdFJSONRepresentation], expected, @"Fail");
}

-(void)testFromJSONRepresentation {
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                              [h DdFJSONRepresentation],@"h", 
                              [v DdFJSONRepresentation],@"v", 
                              nil];

    DdFPadPadPaper *result = [DdFPadPadPaper paperWithJSONRepresentation:json];
    STAssertEqualObjects(underTest, result, @"Fail");
}

-(void)testNSFileWrapperHasFileName {
    NSFileWrapper *wrapper = [underTest NSFileWrapperRepresentation];
    STAssertNotNil(wrapper, @"Fail");
    STAssertEqualObjects(@"page.paper", wrapper.preferredFilename, @"Fail");
}

-(void)testNSFileWrapperContainsJSON {
        
    NSFileWrapper *wrapper = [underTest NSFileWrapperRepresentation];
    NSString *json = [[NSString alloc]initWithBytes:[wrapper.regularFileContents bytes] length:[wrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    STAssertEqualObjects([[underTest DdFJSONRepresentation] JSONRepresentation],json, @"Fail");
}

-(void)testRehydrateJSON {
    NSFileWrapper *wrapper = [underTest NSFileWrapperRepresentation];
    DdFPadPadPaper *result = [DdFPadPadPaper paperWithNSFileWrapperRepresentation:wrapper];
    STAssertEqualObjects(underTest, result, @"Fail");
}

@end
