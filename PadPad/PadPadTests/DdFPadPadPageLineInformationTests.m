#import "DdFPadPadPageLineInformationTests.h"
#import "DdFPadPadPageLineInformation.h"
#import "DdFPadPadInk.h"
#import "JSON.h"
#import "DdFPadPadModelTestHelper.h"
#import "DdFPadPadColor.h"
#import "DdFPadPadPenRepository.h"
@implementation DdFPadPadPageLineInformationTests {
    DdFPadPadPageLineInformation *noMajorLines;
    DdFPadPadPageLineInformation *majorLines;
    DdFPadPadInk *minorInk;
    DdFPadPadInk *majorInk;
}

-(void)setUp {
    minorInk = [DdFPadPadInk inkFromJson:INK_BLACK_FAINT_PAPER];
    majorInk = [DdFPadPadInk inkFromJson:INK_BLACK_HEAVY_PAPER];
    noMajorLines = [[DdFPadPadPageLineInformation alloc]initWithLineInk:minorInk LineGap:10];
    majorLines = [[DdFPadPadPageLineInformation alloc]initWithLineInk:minorInk LineGap:3 MajorLineInk:majorInk MajorLineInterval:10];
}

-(void)testMinorLineInitializer {
    STAssertEqualObjects(minorInk, noMajorLines.lineInk, @"Fail");    
    STAssertEquals((CGFloat)10, noMajorLines.lineGap, @"Fail");
    STAssertFalse(noMajorLines.hasMajorLines, @"Fail");
}

-(void)testMajorLineInitializer {
    STAssertEqualObjects(minorInk, majorLines.lineInk, @"Fail");
    STAssertEquals((CGFloat)3, majorLines.lineGap, @"Fail");
    STAssertTrue(majorLines.hasMajorLines, @"Fail");
    STAssertEqualObjects(majorInk, majorLines.majorLineInk, @"Fail");        
    STAssertEquals((NSUInteger)10, majorLines.majorLineInterval, @"Fail");    
}

-(void)testJSONRepresentation {
    STAssertEqualObjects(JSON_MAJOR_LINES, [[majorLines DdFJSONRepresentation] JSONRepresentation], @"Fail");
    STAssertEqualObjects(JSON_NO_MAJOR_LINES, [[noMajorLines DdFJSONRepresentation] JSONRepresentation], @"Fail");
}

-(void)testInitFromJSONRepresentation {
    DdFPadPadPageLineInformation *initFromNoMajorLines = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_NO_MAJOR_LINES JSONValue]];
    DdFPadPadPageLineInformation *initFromMajorLines = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_MAJOR_LINES JSONValue]];
    
    STAssertEqualObjects(initFromMajorLines, majorLines, @"Fail");
    STAssertEqualObjects(initFromNoMajorLines, noMajorLines, @"Fail");
}

@end
