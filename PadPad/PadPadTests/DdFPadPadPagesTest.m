#import "DdFPadPadPagesTest.h"
#import "DdFPadPadPages.h"

@implementation DdFPadPadPagesTest {
    DdFPadPadPages *underTest;
}

-(void)setUp {
    underTest = [[DdFPadPadPages alloc]init];
}

-(void)testAddToFileWrapperAddsPageOrder {
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
    [underTest addToFileWrapper:wrapper];
    
    NSFileWrapper *pageOrderWrapper = [wrapper.fileWrappers objectForKey:@"page.order"];
    STAssertNotNil(pageOrderWrapper, @"Fail");
}

-(void)testFileWrapperRoundTrip {
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
    [underTest addToFileWrapper:wrapper];
    DdFPadPadPages *result = [[DdFPadPadPages alloc]init];
    [result loadFromFileWrapper:wrapper];
    STAssertEqualObjects(result, underTest, @"Fail");
}



@end
