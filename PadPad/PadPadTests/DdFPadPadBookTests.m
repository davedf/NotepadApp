#import "DdFPadPadBookTests.h"
#import "DdFPadPadBook.h"

@implementation DdFPadPadBookTests {
    DdFPadPadBook *underTest;
//    BOOL loadComplete,loadedOk;
    
}

-(void)setUp {
    [super setUp];
    __block BOOL loadedOk= NO;
    __block BOOL loadComplete = NO;
    
    underTest = [DdFPadPadBook newBookWithName:@"testBook" Delegate:nil CompletionHandler:^(BOOL success){
        loadedOk = success;
        loadComplete = YES;
    }];
    NSUInteger waitCount = 0;

    while (!loadComplete && waitCount < 26) {
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"Waiting for save to complete documentState:%d state:%@ ",underTest.documentState, underTest.documentState== UIDocumentStateNormal?@"Normal":(underTest.documentState== UIDocumentStateClosed?@"Closed":@"Other"));        
        waitCount++;
    }
    if (waitCount >= 6) {
        NSLog(@"Waiting for save timed out");
    }
}

-(void)tearDown {
    if (underTest && underTest.fileURL) {
//        NSUInteger waitCount = 0;
//        while (!loadComplete && waitCount < 6) {
//            [NSThread sleepForTimeInterval:1];
//            NSLog(@"Waiting for save to complete");
//            waitCount++;
//        }
        NSError *error = nil;
        NSLog(@"cleaning up file:%@",[underTest.fileURL absoluteString]);
        [[NSFileManager defaultManager] removeItemAtURL:underTest.fileURL error:&error];;
        if (error) {
            NSLog(@"error:%@",[error localizedDescription]);
        }
    }
    [super tearDown];
}
-(void)testBookInfoIsNotNull {
    STAssertNotNil(underTest.bookInfo, @"Fail");
}

@end
