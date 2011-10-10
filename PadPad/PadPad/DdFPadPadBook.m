#import "DdFPadPadBook.h"
#import "DdFPadPadBookInfo.h"
#import "NSMutableArray+DdFPadPadPageOrder.h"
#define TYPE_NAME_BOOKROOT @"book"

@interface DdFPadPadBook()
@property (readonly) NSString *bookFile;
@property (strong) NSMutableArray *pageOrder;
@property (strong) NSFileWrapper *fileWrapper;
@end

@implementation DdFPadPadBook {
    NSArray *pages;
}
@synthesize delegate=_delegate,bookInfo=_bookInfo,pageOrder=_pageOrder,fileWrapper=_fileWrapper;

#pragma mark - UIDocument

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"contentsForType:%@",typeName);
    if (!self.fileWrapper) {
        self.fileWrapper  =[[NSFileWrapper alloc]initDirectoryWithFileWrappers:nil];
        [self.fileWrapper setPreferredFilename:self.bookFile];        
    }
    [self.fileWrapper addFileWrapper:[self.bookInfo NSFileWrapperRepresentation]];    
    [self.fileWrapper addFileWrapper:[self.pageOrder NSFileWrapperRepresentation]];
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
        else if ([self.pageOrder recognises:childWrapper]) {
            [self.pageOrder AddFromNSFileWrapper:childWrapper];
            NSLog(@"New page order:%@",self.pageOrder);
            [loadedWrappers addObject:childWrapper];
        }
    }
    for (NSFileWrapper *loadedWrapper in loadedWrappers) {
        [self.fileWrapper removeFileWrapper:loadedWrapper];
    }
    [self.delegate bookUpdated];
    return YES;
}

-(NSString*)bookFile {
    return [NSString stringWithFormat:@"%@.book",self.bookInfo.bookId];
}

-(id)initWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
    
    self = [super initWithFileURL:url];
    if (self) {
        self.delegate = delegate;
        self.pageOrder = [[NSMutableArray alloc]init];
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
        self.pageOrder = [[NSMutableArray alloc]init];
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
