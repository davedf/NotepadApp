#import "DdFPadPadBookTests.h"
#import "DdFPadPadBook.h"

@implementation DdFPadPadBookTests {
    DdFPadPadBook *underTest;
    BOOL loadComplete,loadedOk;
    
}

-(void)setUp {
    [super setUp];
    underTest = [DdFPadPadBook newBookWithName:@"testBook" Delegate:nil CompletionHandler:^(BOOL ok){
        loadedOk = ok;
        loadComplete = YES;
    }];
}

-(void)tearDown {
    if (underTest && underTest.fileURL) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtURL:underTest.fileURL error:&error];;
        
    }
    [super tearDown];
}
-(void)testBookInfoIsNotNull {
    
}

@end
