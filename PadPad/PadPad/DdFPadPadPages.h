#import <Foundation/Foundation.h>

@class DdFPadPadPage;
@class DdFPadPadPaper;
@interface DdFPadPadPages : NSObject

-(void)loadFromFileWrapper:(NSFileWrapper*)fileWrapper;
-(void)addToFileWrapper:(NSFileWrapper*)fileWrapper;
-(DdFPadPadPage*)pageForIndex:(NSUInteger)pageIndex;
-(NSUInteger)indexOfPage:(DdFPadPadPage*)page;
-(void)changeAllPaper:(DdFPadPadPaper*)paper;
@end
