#import "DdFPadPadBookTests.h"
#import "DdFPadPadBook.h"

@implementation DdFPadPadBookTests {
    DdFPadPadBook *underTest;
    
}

-(void)setUp {
    [super setUp];
    
    underTest = [[DdFPadPadBook alloc]initWithName:@"test book" Delegate:nil];
}

-(void)testBookInfoIsNotNull {
    STAssertNotNil(underTest.bookInfo, @"Fail");
}

@end
