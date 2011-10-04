#import "DdFPadPadBook.h"

#define TYPE_NAME_BOOKROOT @"book"

@interface DdFPadPadBook()
-(NSFileWrapper*)pageOrder;
-(NSFileWrapper*)pageInfo;
@end

@implementation DdFPadPadBook {
    NSArray *pages;
}
@synthesize delegate;

#pragma mark - UIDocument

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    return nil;
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    [self.delegate bookUpdated];
    return YES;
}

#pragma mark - DdFPadPadBook()
-(NSFileWrapper*)pageOrder {
    return nil;
}
-(NSFileWrapper*)pageInfo {
    return nil;
}
@end
