#import "NSMutableArray+DdFPadPadPageOrder.h"
#import "JSON.h"

#define PAGE_ORDER_FILENAME @"book.pageorder"

@implementation NSMutableArray (DdFPadPadPageOrder)

-(NSFileWrapper*)NSFileWrapperRepresentation {
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents:[self NSDataRepresentation]];
    [wrapper setPreferredFilename:PAGE_ORDER_FILENAME];
    return wrapper;
}
-(NSData*)NSDataRepresentation {
    NSString *json = [self JSONRepresentation];
    NSData *data = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    return data;
}

-(void)AddFromNSFileWrapper:(NSFileWrapper*)fileWrapper {
    NSString *json = [[NSString alloc]initWithBytes:[fileWrapper.regularFileContents bytes] length:[fileWrapper.regularFileContents length] encoding:NSUTF8StringEncoding];

    NSArray *items = [json JSONValue];
    [self removeAllObjects];
    [self addObjectsFromArray:items];
}

-(BOOL)recognises:(NSFileWrapper*)fileWrapper {
    return [fileWrapper.filename isEqualToString:PAGE_ORDER_FILENAME];
}

@end
