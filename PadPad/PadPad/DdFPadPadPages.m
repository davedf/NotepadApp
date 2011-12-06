#import "DdFPadPadPages.h"
#import "JSON.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageBuilder.h"
#import "Log.h"
#define PAGE_ORDER_FILE_NAME @"page.order"

@interface DdFPadPadPages()
-(void)addPageOrderToFileWrapper:(NSFileWrapper*)fileWrapper;
-(void)loadPageOrderFromFileWrapper:(NSFileWrapper*)fileWrapper;
-(DdFPadPadPage*)existingPageForIndex:(NSUInteger)pageIndex;
-(NSString*)pageIdForIndex:(NSUInteger)pageIndex;
-(void)storePage:(DdFPadPadPage*)page ForIndex:(NSUInteger)pageIndex;
@end

@implementation DdFPadPadPages {
    NSMutableDictionary *_pageIndexToPageIdMap;
    NSMutableDictionary *_pageIdToPageIndexMap;
    NSMutableDictionary *_pageIdToNSFileWrapperMap;
    NSMutableDictionary *_loadedPageIdToDdFPadPadPageMap;
}

-(id)init {
    self = [super init];
    if (self) {
        _pageIndexToPageIdMap = [[NSMutableDictionary alloc]init];
        _pageIdToPageIndexMap = [[NSMutableDictionary alloc]init];
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
        NSFileWrapper *pageWrapper = [fileWrapper.fileWrappers objectForKey:wrapperName];

        NSString *pageId = [DdFPadPadPage pageIdentifierFromNSFileWrapper:pageWrapper];
        TRACE(@"pageId:%@", pageId);
        if (pageId && [[_pageIndexToPageIdMap allValues] containsObject:pageId]) {
            TRACE(@"Adding pageId:%@ to _pageIdToNSFileWrapperMap",pageId);
            [_pageIdToNSFileWrapperMap setObject:pageWrapper forKey:pageId];                
        }
    }
}

-(void)addToFileWrapper:(NSFileWrapper*)fileWrapper {
    [self addPageOrderToFileWrapper:fileWrapper];
    for (DdFPadPadPage *page in [_loadedPageIdToDdFPadPadPageMap allValues]) {
        NSFileWrapper *existing = [fileWrapper.fileWrappers objectForKey:page.filename];
        if (existing) {
            if (page.requiresSave) {
                [page UpdateNSFileWrapperRepresentation:existing];                
            }
        }
        else {
            [fileWrapper addFileWrapper:[page NSFileWrapperRepresentation]];
        }
    }    
}

-(NSUInteger)indexOfPage:(DdFPadPadPage*)page {
    return [[_pageIdToPageIndexMap objectForKey:page.identifier] intValue];
}

-(NSString*)pageIdForIndex:(NSUInteger)pageIndex {
    NSString *pageIndexNumber = [NSString stringWithFormat:@"%d",pageIndex];

    return [_pageIndexToPageIdMap objectForKey:pageIndexNumber];
    
}

-(NSUInteger) numberOfPagesIndexed {
    return [_pageIdToPageIndexMap count];
}
-(void)storePage:(DdFPadPadPage*)page ForIndex:(NSUInteger)pageIndex {
    NSString *pageIndexNumber = [NSString stringWithFormat:@"%d",pageIndex];
    [_loadedPageIdToDdFPadPadPageMap setObject:page forKey:page.identifier];
    TRACE(@"adding to page order identifier:%@ key:%@",page.identifier,pageIndexNumber);
    [_pageIndexToPageIdMap setObject:page.identifier forKey:pageIndexNumber];
    [_pageIdToPageIndexMap setObject:pageIndexNumber forKey:page.identifier];
}

-(DdFPadPadPage*)existingPageForIndex:(NSUInteger)pageIndex {
    NSUInteger pageNumber = pageIndex + 1;
    NSString *pageId = [self pageIdForIndex:pageIndex];
    if (pageId) {
        DdFPadPadPage *loadedPage = [_loadedPageIdToDdFPadPadPageMap objectForKey:pageId];
        if (loadedPage) {
            return loadedPage;
        }
        
        NSFileWrapper *wrapper = [_pageIdToNSFileWrapperMap objectForKey:pageId];
        if (wrapper) {
            DdFPadPadPage *unwrapped = [DdFPadPadPage pageWithPageNumber:pageNumber NSFileWrapper:wrapper];
            [_loadedPageIdToDdFPadPadPageMap setObject:unwrapped forKey:pageId];
            [_pageIdToNSFileWrapperMap removeObjectForKey:pageId];
            return unwrapped;
        }
    }
    return nil;
}
-(DdFPadPadPage*)pageForIndex:(NSUInteger)pageIndex {
    DdFPadPadPage *existingPage = [self existingPageForIndex:pageIndex];
    if (existingPage) {
        return existingPage;
    }
    DdFPadPadPage *previousExistingPage = nil;
    if (pageIndex > 0) {
        previousExistingPage = [self existingPageForIndex:(pageIndex-1)];
    }
    
    DdFPadPadPage *newPage = [[DdFPadPadPageBuilder sharedPageBuilder] pageWithPageNumber:pageIndex + 1 Paper:previousExistingPage.paper];

    [self storePage:newPage ForIndex:pageIndex];
    return newPage;
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

-(void)changeAllPaper:(DdFPadPadPaper*)paper {
    for (NSString *pageIndex in [_pageIdToPageIndexMap allValues]) {
        DdFPadPadPage *page = [self pageForIndex:[pageIndex intValue]];
        [page changePaper:paper];
    }
}

#pragma mark - DdFPadPadPages()
-(void)addPageOrderToFileWrapper:(NSFileWrapper*)fileWrapper {
    NSFileWrapper *currentPageOrderFileWrapper = [fileWrapper.fileWrappers objectForKey:PAGE_ORDER_FILE_NAME];
    [fileWrapper removeFileWrapper:currentPageOrderFileWrapper];
    NSString *pageOrderJSON = [_pageIndexToPageIdMap JSONRepresentation];
    TRACE(@"saving page order:%@",pageOrderJSON);
    NSData *data = [NSData dataWithBytes:[pageOrderJSON UTF8String] length:[pageOrderJSON length]];
    
    NSFileWrapper *pageOrderWrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    [pageOrderWrapper setPreferredFilename:PAGE_ORDER_FILE_NAME];
    [fileWrapper addFileWrapper:pageOrderWrapper];

}

-(void)loadPageOrderFromFileWrapper:(NSFileWrapper*)fileWrapper {
    NSFileWrapper *pageOrderFileWrapper = [fileWrapper.fileWrappers objectForKey:PAGE_ORDER_FILE_NAME];
    NSString *json = [[NSString alloc]initWithBytes:[pageOrderFileWrapper.regularFileContents bytes] length:[pageOrderFileWrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    TRACE(@"loading page order:%@",json);
    NSDictionary *order = [json JSONValue];
    _pageIndexToPageIdMap = [NSMutableDictionary dictionaryWithDictionary:order];
    for (NSString *pageIndex in [_pageIndexToPageIdMap allKeys]) {
        [_pageIdToPageIndexMap setObject:pageIndex forKey:[_pageIndexToPageIdMap objectForKey:pageIndex]];
    }
}

@end
