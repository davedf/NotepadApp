#import <Foundation/Foundation.h>
#import "DdFPadPadBook.h"

@interface DdFPadPadBookRepository : NSObject
-(DdFPadPadBook*)openDefaultBookWithDelegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler;
+(DdFPadPadBookRepository*)sharedRepository;
@end
