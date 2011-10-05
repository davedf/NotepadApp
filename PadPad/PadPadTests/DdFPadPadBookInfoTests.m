#import "DdFPadPadBookInfoTests.h"
#import "DdFPadPadBookInfo.h"
#import "NSDate+DdFFormatting.h"
#import <UIKit/UIKit.h>
    
@implementation DdFPadPadBookInfoTests {
    DdFPadPadBookInfo *underTest;
}

-(void)setUp {
    [super setUp];
    underTest = [DdFPadPadBookInfo bookInfoWithName:@"foo"];
                 
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
    DdFPadPadBookInfo *parsed = [DdFPadPadBookInfo bookInfoWithJSON:json];
    STAssertEqualObjects([NSDate dateFromFileFormat:dateString], parsed.creationDate, @"Fail");
    STAssertEqualObjects([NSDate dateFromFileFormat:dateString], parsed.lastChangedDate, @"Fail");
    STAssertEqualObjects(@"bar", parsed.bookId, @"Fail");
    STAssertEqualObjects(@"foo", parsed.bookName, @"Fail");
    
}
 
-(void)testToAndFromNSFileWrapperRepresentation{
    NSFileWrapper *dir = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
    [dir addFileWrapper:[underTest NSFileWrapperRepresentation]];
    NSError *error;
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.book"];     
    NSLog(@"filePath:%@",filePath);

    NSURL *url = [NSURL fileURLWithPath:filePath];
    BOOL result = [dir writeToURL:url options:NSFileWrapperWritingAtomic originalContentsURL:url error:&error];
    STAssertTrue(result, @"Fail");
    STAssertNil(error, @"Fail");
    
    NSFileWrapper *loaded = [[NSFileWrapper alloc]initWithURL:url options:0 error:&error];
    NSFileWrapper *loadedWrapper = [loaded.fileWrappers objectForKey:underTest.fileName];
    DdFPadPadBookInfo *loadedInfo = [DdFPadPadBookInfo bookInfoWithNSFileWrapper:loadedWrapper];
    DdFPadPadBookInfo *expected = [DdFPadPadBookInfo bookInfoWithJSON:[underTest JSONRepresentation]];
    STAssertEqualObjects(loadedInfo, expected, @"Fail");
}
@end
