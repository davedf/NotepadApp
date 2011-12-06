#import "DdFPadPadBookRepository.h"
#import "DdFPadPadCloudValueStore.h"
#import "Log.h"
@implementation DdFPadPadBookRepository
static DdFPadPadBookRepository *sDdFPadPadBookRepository;

-(DdFPadPadBook*)openDefaultBookWithDelegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler {
    NSURL *defaultUrl = [DdFPadPadCloudValueStore LastOpenedDocumentURL];
    BOOL bookExists;
    if (defaultUrl) {
        TRACE(@"checking file exists:%@",[defaultUrl path]);
        bookExists = [[NSFileManager defaultManager] fileExistsAtPath:[defaultUrl path]];
    }
    else {
        bookExists = NO;
    }
    if (bookExists) {
        TRACE(@"opening defaultUrl:%@",[defaultUrl absoluteString]);
        return [DdFPadPadBook bookWithURL:defaultUrl Delegate:delegate CompletionHandler:completionHandler];
    }
    else {
        TRACE(@"No defaultUrl, creating new book");
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
