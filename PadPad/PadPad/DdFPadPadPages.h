#import <Foundation/Foundation.h>

@class DdFPadPadPage;
@interface DdFPadPadPages : NSObject

-(void)loadFromFileWrapper:(NSFileWrapper*)fileWrapper;
-(void)addToFileWrapper:(NSFileWrapper*)fileWrapper;
-(DdFPadPadPage*)pageForIndex;
@end
