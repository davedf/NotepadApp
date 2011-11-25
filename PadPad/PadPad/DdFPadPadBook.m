#import "DdFPadPadBook.h"
#import "DdFPadPadBookInfo.h"
#import "DdFPadPadPages.h"
#import "NSMutableArray+DdFPadPadPageOrder.h"
#define TYPE_NAME_BOOKROOT @"book"

@interface DdFPadPadBook()
@property (strong) NSFileWrapper *fileWrapper;
@property (strong) DdFPadPadPages *pages;

-(id)initWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate BookInfo:(DdFPadPadBookInfo*)bookInfo;
@end

@implementation DdFPadPadBook 
@synthesize delegate=_delegate,bookInfo=_bookInfo,fileWrapper=_fileWrapper,pages=_pages;

#pragma mark - initialization

-(id)initWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate BookInfo:(DdFPadPadBookInfo*)bookInfo {
    self = [super initWithFileURL:url];
    if (self) {
        self.delegate = delegate;
        self.bookInfo = bookInfo;
        self.pages = [[DdFPadPadPages alloc]init];
    }
    return self;
    
}

-(id)initWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {    
    return [self initWithURL:url Delegate:delegate BookInfo:nil];
}

-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
    DdFPadPadBookInfo *bookInfo = [DdFPadPadBookInfo bookInfoWithName:name];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:bookInfo.fileName];     
    NSLog(@"filePath:%@",filePath);
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    return [self initWithURL:url Delegate:delegate BookInfo:bookInfo];
}


#pragma mark - UIDocument

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"contentsForType:%@",typeName);
    if (!self.fileWrapper) {
        self.fileWrapper  =[[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
        [self.fileWrapper setPreferredFilename:self.bookInfo.fileName];        
    }
    [self.fileWrapper addFileWrapper:[self.bookInfo NSFileWrapperRepresentation]];    
    [self.pages addToFileWrapper:self.fileWrapper];
    return self.fileWrapper;
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"loadFromContents:ofType:%@",typeName);
    self.fileWrapper = (NSFileWrapper*)contents;
    NSMutableArray *loadedWrappers = [NSMutableArray array];
    for (NSFileWrapper *childWrapper in [self.fileWrapper.fileWrappers allValues]) {
        
        if ([DdFPadPadBookInfo recognises:childWrapper]) {
            self.bookInfo = [DdFPadPadBookInfo bookInfoWithNSFileWrapper:childWrapper];
            NSLog(@"bookInfo:[bookId:%@ name:%@]",self.bookInfo.bookId,self.bookInfo.bookName);
            [loadedWrappers addObject:childWrapper];
        } 
    }
    for (NSFileWrapper *loadedWrapper in loadedWrappers) {
        [self.fileWrapper removeFileWrapper:loadedWrapper];
    }
    [self.pages loadFromFileWrapper:self.fileWrapper];
    [self.delegate bookUpdated];
    return YES;
}

-(DdFPadPadPage*)pageForIndex:(NSUInteger)index {
    return [self.pages pageForIndex:index];
}

-(NSUInteger)indexOfPage:(DdFPadPadPage*)page {
    return [self.pages indexOfPage:page];
}

-(void)changePaper:(DdFPadPadPaper*)paper ForPages:(NSArray*)pages {
    //TODO:undo manager
//    self.version = self.version++;
    for (DdFPadPadPage *page in pages) {
        page.paper = paper;
    }    
    //TODO:nil of empty pages means all pages
    [self updateChangeCount:UIDocumentChangeDone];
}
#pragma mark - creating and loading a book

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
