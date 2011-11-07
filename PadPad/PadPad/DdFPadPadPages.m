#import "DdFPadPadPages.h"
#import "JSON.h"
#import "DdFPadPadPage.h"

#define PAGE_ORDER_FILE_NAME @"page.order"

@interface DdFPadPadPages()
-(void)addPageOrderToFileWrapper:(NSFileWrapper*)fileWrapper;
-(void)loadPageOrderFromFileWrapper:(NSFileWrapper*)fileWrapper;
@end

@implementation DdFPadPadPages {
    NSMutableDictionary *_pageIndexToPageIdMap;
    NSMutableDictionary *_pageIdToNSFileWrapperMap;
    NSMutableDictionary *_loadedPageIdToDdFPadPadPageMap;
}

-(id)init {
    self = [super init];
    if (self) {
        _pageIndexToPageIdMap = [[NSMutableDictionary alloc]init];
        _pageIdToNSFileWrapperMap = [[NSMutableDictionary alloc]init];
        _loadedPageIdToDdFPadPadPageMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)loadFromFileWrapper:(NSFileWrapper*)fileWrapper {
    [self loadPageOrderFromFileWrapper:fileWrapper];
    _pageIdToNSFileWrapperMap = [[NSMutableDictionary alloc]init];
    
    _loadedPageIdToDdFPadPadPageMap = [[NSMutableDictionary alloc]init];

    for (NSString *wrapperName in [fileWrapper.fileWrappers allKeys]) {        
            
        if ([_pageIndexToPageIdMap objectForKey:wrapperName]) {
            NSFileWrapper *pageWrapper = [fileWrapper.fileWrappers objectForKey:wrapperName];
            [_pageIdToNSFileWrapperMap setObject:pageWrapper forKey:wrapperName];                
        }
    }
}

-(void)addToFileWrapper:(NSFileWrapper*)fileWrapper {
    [self addPageOrderToFileWrapper:fileWrapper];
    //add page filewrappers from _pageIdToNSFileWrapperMap
    for (NSFileWrapper *wrapper in [_pageIdToNSFileWrapperMap allValues]) {
        [fileWrapper addFileWrapper:wrapper];
    }
    //add loaded pages from _loadedPageIdToDdFPadPadPageMap
    for (DdFPadPadPage *page in [_loadedPageIdToDdFPadPadPageMap allValues]) {
        [fileWrapper addFileWrapper:[page NSFileWrapperRepresentation]];
    }    
}

-(DdFPadPadPage*)pageForIndex {
    return nil;
}

-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadPages *other = (DdFPadPadPages*) object;
    if (![_pageIndexToPageIdMap isEqual:other->_pageIndexToPageIdMap]) {
        return NO;
    }
    if (![_pageIdToNSFileWrapperMap isEqual:other->_pageIdToNSFileWrapperMap]) {
        return NO;
    }
    if (![_loadedPageIdToDdFPadPadPageMap isEqual:other->_loadedPageIdToDdFPadPadPageMap]) {
        return NO;
    }
    return YES;
}

#pragma mark - DdFPadPadPages()
-(void)addPageOrderToFileWrapper:(NSFileWrapper*)fileWrapper {
    NSString *pageOrderJSON = [_pageIndexToPageIdMap JSONRepresentation];
    NSData *data = [NSData dataWithBytes:[pageOrderJSON UTF8String] length:[pageOrderJSON length]];
    
    NSFileWrapper *pageOrderWrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    [pageOrderWrapper setPreferredFilename:PAGE_ORDER_FILE_NAME];
    [fileWrapper addFileWrapper:pageOrderWrapper];

}

-(void)loadPageOrderFromFileWrapper:(NSFileWrapper*)fileWrapper {
    NSFileWrapper *pageOrderFileWrapper = [fileWrapper.fileWrappers objectForKey:PAGE_ORDER_FILE_NAME];
    NSString *json = [[NSString alloc]initWithBytes:[pageOrderFileWrapper.regularFileContents bytes] length:[pageOrderFileWrapper.regularFileContents length] encoding:NSUTF8StringEncoding];

    NSDictionary *order = [json JSONValue];
    _pageIndexToPageIdMap = [NSMutableDictionary dictionaryWithDictionary:order];
}

@end
