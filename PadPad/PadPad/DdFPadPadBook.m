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

-(void)clearBook {
    
}
#pragma mark - UIDocument

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSFileWrapper *book = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
    [book addFileWrapper:[self.bookInfo NSFileWrapperRepresentation]];
    [book setPreferredFilename:self.bookFile];        
    return book;
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    [self.delegate bookUpdated];
    NSFileWrapper *wrapper = (NSFileWrapper*)contents;
    for (NSFileWrapper *childWrapper in [wrapper.fileWrappers allValues]) {
        
        if ([DdFPadPadBookInfo recognises:childWrapper]) {
            self.bookInfo = [DdFPadPadBookInfo bookInfoWithNSFileWrapper:childWrapper];
            NSLog(@"bookInfo:[bookId:%@ name:%@]",self.bookInfo.bookId,self.bookInfo.bookName);
        } 
    }
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

-(id)initWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
    self = [super initWithFileURL:url];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
    DdFPadPadBookInfo *bookInfo = [DdFPadPadBookInfo bookInfoWithName:name];
    NSString *bookFile =[NSString stringWithFormat:@"%@.book",bookInfo.bookId];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:bookFile];     
    NSLog(@"filePath:%@",filePath);
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
    [newBook saveToURL:newBook.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        NSLog(@"save completed:%@",success?@"Y":@"N");
        [newBook openWithCompletionHandler:completionHandler];
    }];
    
    return newBook;
}

+(DdFPadPadBook*)bookWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler {
    DdFPadPadBook *newBook = [[DdFPadPadBook alloc] initWithURL:url Delegate:delegate];
    [newBook openWithCompletionHandler:completionHandler];
    return newBook;
}
@end
