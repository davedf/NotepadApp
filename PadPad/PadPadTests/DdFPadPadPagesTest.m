#import "DdFPadPadPagesTest.h"
#import "DdFPadPadPages.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadModelTestHelper.h"

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

-(void)testPageWithPageIndex {
    DdFPadPadPage *p1 =  [underTest pageForIndex:0];
    STAssertNotNil(p1, @"Fail");
    DdFPadPadPage *p2 =  [underTest pageForIndex:0];
    STAssertEquals(p1, p2, @"Fail");
}

-(void)testPageWithPageIndexRoundTrip {
    DdFPadPadPage *p1 =  [underTest pageForIndex:0];
    [p1 addLine:[DdFPadPadModelTestHelper lineWithPoints]];
    STAssertEquals((NSUInteger)1, p1.lines.count, @"Fail");
    
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
    [underTest addToFileWrapper:wrapper];
    
    
    DdFPadPadPages *result = [[DdFPadPadPages alloc]init];
    [result loadFromFileWrapper:wrapper];
    DdFPadPadPage *p2 =  [result pageForIndex:0];
    STAssertEquals((NSUInteger)1, p2.lines.count, @"Fail");
    STAssertEqualObjects(p1, p2, @"Fail");
}
@end
