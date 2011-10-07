#import "DdFPadPadBookRepository.h"
#import "DdFPadPadCloudValueStore.h"

@implementation DdFPadPadBookRepository
static DdFPadPadBookRepository *sDdFPadPadBookRepository;

-(DdFPadPadBook*)openDefaultBookWithDelegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler {
    NSURL *defaultUrl = [DdFPadPadCloudValueStore LastOpenedDocumentURL];
    BOOL bookExists;
    if (defaultUrl) {
        NSLog(@"checking file exists:%@",[defaultUrl path]);
        bookExists = [[NSFileManager defaultManager] fileExistsAtPath:[defaultUrl path]];
    }
    else {
        bookExists = NO;
    }
    if (bookExists) {
        NSLog(@"opening defaultUrl:%@",[defaultUrl absoluteString]);
        return [DdFPadPadBook bookWithURL:defaultUrl Delegate:delegate CompletionHandler:completionHandler];
    }
    else {
        NSLog(@"No defaultUrl, creating new book");
        DdFPadPadBook *newBook = [DdFPadPadBook newBookWithName:@"New Book" Delegate:delegate CompletionHandler:completionHandler];
        [DdFPadPadCloudValueStore SetLastOpenedDocumentURL:newBook.fileURL];
        return newBook;
    }
}

+(DdFPadPadBookRepository*)sharedRepository {
    if (!sDdFPadPadBookRepository) {        
        sDdFPadPadBookRepository = [[DdFPadPadBookRepository alloc]init];
        [DdFPadPadCloudValueStore synchronize];
    }
    return sDdFPadPadBookRepository;
}

@end
