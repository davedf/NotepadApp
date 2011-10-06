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
@synthesize delegate,bookInfo;

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

//-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate {
//    DdFPadPadBookInfo *newBookInfo = [DdFPadPadBookInfo bookInfoWithName:name];
//    NSString *bookFile =[NSString stringWithFormat:@"%@.book",self.bookInfo.bookId];
//    
//    self = [super initWithFileURL:<#(NSURL *)#>];
//    if (self) {
//        
//    }
//    return self;
//}
+(DdFPadPadBook*)newBookWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler {
    DdFPadPadBookInfo *newBookInfo = [DdFPadPadBookInfo bookInfoWithName:name];
    DdFPadPadBook *newBook = [[DdFPadPadBook alloc] init];
    newBook.bookInfo = newBookInfo;
    newBook.delegate = delegate;
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:newBook.bookFile];     
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [newBook saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:completionHandler];
    return newBook;
}

@end
