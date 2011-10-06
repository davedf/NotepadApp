#import "DdFPadPadBook.h"
#import "DdFPadPadBookInfo.h"

#define TYPE_NAME_BOOKROOT @"book"

@interface DdFPadPadBook()
-(NSFileWrapper*)pageOrder;
-(NSFileWrapper*)pageInfo;
@property (readonly) NSString *bookFile;
@end

@implementation DdFPadPadBook {
    NSArray *pages;
}
@synthesize delegate=_delegate,bookInfo=_bookInfo;

#pragma mark - UIDocument

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    return nil;
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    [self.delegate bookUpdated];
    return YES;
}

-(NSString*)bookFile {
    return [NSString stringWithFormat:@"%@.book",self.bookInfo.bookId];
}

#pragma mark - DdFPadPadBook()
-(NSFileWrapper*)pageOrder {
    return nil;
}
-(NSFileWrapper*)pageInfo {
    return nil;
}

-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
    DdFPadPadBookInfo *bookInfo = [DdFPadPadBookInfo bookInfoWithName:name];
    NSString *bookFile =[NSString stringWithFormat:@"%@.book",bookInfo.bookId];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:bookFile];     
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    self = [super initWithFileURL:url];
    if (self) {
        self.delegate = delegate;
        self.bookInfo = bookInfo;
    }
    return self;
}

+(DdFPadPadBook*)newBookWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler {
    DdFPadPadBook *newBook = [[DdFPadPadBook alloc] initWithName:name Delegate:delegate];
    [newBook saveToURL:newBook.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:completionHandler];
    return newBook;
}

@end
