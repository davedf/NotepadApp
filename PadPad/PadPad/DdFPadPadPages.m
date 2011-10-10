#import "DdFPadPadPages.h"
@implementation DdFPadPadPages {
    NSMutableArray *_pageOrder;
    NSMutableDictionary *_pageIdToNSFileWrapperMap;
    NSMutableDictionary *_loadedPageIdToDdFPadPadPageMap;
}

-(id)init {
    self = [super init];
    if (self) {
        _pageOrder = [[NSMutableArray alloc]init];
        _pageIdToNSFileWrapperMap = [[NSMutableDictionary alloc]init];
        _loadedPageIdToDdFPadPadPageMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)loadFromFileWrapper:(NSFileWrapper*)fileWrapper {
    //move page filewrappers to _pageIdToNSFileWrapperMap, and remove them from the containing file wrapper
}
-(void)addToFileWrapper:(NSFileWrapper*)fileWrapper {
    //add page filewrappers from _pageIdToNSFileWrapperMap
    //add loaded pages from _loadedPageIdToDdFPadPadPageMap
    
}
-(DdFPadPadPage*)pageForIndex {
    return nil;
}

@end
