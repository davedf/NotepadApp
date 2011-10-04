#import "DdFPadPadBookInfoTests.h"
#import "DdFPadPadBookInfo.h"
#import "NSDate+DdFFormatting.h"
#import <UIKit/UIKit.h>
    
@implementation DdFPadPadBookInfoTests {
    DdFPadPadBookInfo *underTest;
}

-(void)setUp {
    [super setUp];
    underTest = [DdFPadPadBookInfo newBookInfoWithName:@"foo"];
                 
}

-(void)testShouldSetName {
    STAssertEqualObjects(@"foo", underTest.bookName, @"Fail");
}

-(void)testShouldSetBookId {
    STAssertNotNil(underTest.bookId, @"Fail");
}

-(void)testJSONRepresentation {
    NSString *expected = [NSString stringWithFormat:@"{\"lastChangedDate\":\"%@\",\"bookName\":\"%@\",\"bookId\":\"%@\",\"creationDate\":\"%@\"}",[underTest.lastChangedDate toFileStringFormat],underTest.bookName,underTest.bookId,[underTest.creationDate toFileStringFormat]];
    STAssertEqualObjects(expected, [underTest JSONRepresentation] , @"Fail");
}

-(void)testNewInfoFromJSON {
    NSString *dateString = @"2011-10-04T12:21:26.140Z+0100";
    NSString *json = @"{\"lastChangedDate\":\"2011-10-04T12:21:26.140Z+0100\",\"bookName\":\"foo\",\"bookId\":\"bar\",\"creationDate\":\"2011-10-04T12:21:26.140Z+0100\"}";
    DdFPadPadBookInfo *parsed = [DdFPadPadBookInfo newBookInfoWithJSON:json];
    STAssertEqualObjects([NSDate dateFromFileFormat:dateString], parsed.creationDate, @"Fail");
    STAssertEqualObjects([NSDate dateFromFileFormat:dateString], parsed.lastChangedDate, @"Fail");
    STAssertEqualObjects(@"bar", parsed.bookId, @"Fail");
    STAssertEqualObjects(@"foo", parsed.bookName, @"Fail");
    
}
@end
