#import "NSMutableArray+DdFPadPadPagOrderTests.h"
#import "NSMutableArray+DdFPadPadPageOrder.h"

@implementation NSMutableArray_DdFPadPadPagOrderTests{
    NSMutableArray *testArray;
}

-(void)setUp {
    [super setUp];
    testArray = [[NSMutableArray alloc] initWithObjects:@"foo",@"bar", nil];
}

-(void)testNSFileWrapperHasFileName {
    NSFileWrapper *result = [testArray NSFileWrapperRepresentation];
    STAssertEqualObjects(@"book.pageorder", result.preferredFilename, @"Fail");
}


-(void)testNSFileWrapperHasData {
    NSFileWrapper *fileWrapper = [testArray NSFileWrapperRepresentation];
    NSString *json = [[NSString alloc]initWithBytes:[fileWrapper.regularFileContents bytes] length:[fileWrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    
    STAssertEqualObjects(@"[\"foo\",\"bar\"]", json, @"Fail");
}

-(void)testAddsFromFileWrapper {
    NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:testArray];
    [newArray addObject:@"foobar"];
    NSFileWrapper *fileWrapper = [newArray NSFileWrapperRepresentation];
    [testArray AddFromNSFileWrapper:fileWrapper];
    STAssertEqualObjects(newArray, testArray, @"Fail");
}

-(void)testRecognisesFileWrapper {
    NSFileWrapper *result = [testArray NSFileWrapperRepresentation];
    [result setFilename:result.preferredFilename];
    STAssertTrue([testArray recognises:result], @"Fail");
}

-(void)testDoesNotRecogniseFileWrapper {
    NSFileWrapper *result = [testArray NSFileWrapperRepresentation];
    [result setFilename:@"foo.bar"];
    STAssertFalse([testArray recognises:result], @"Fail");
    
}
@end
