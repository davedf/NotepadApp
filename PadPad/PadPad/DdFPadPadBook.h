#import <Foundation/Foundation.h>

@class DdFPadPadBookInfo;

@protocol DdFPadPadBookDelegate <NSObject>
-(void)bookUpdated;
@end

@interface DdFPadPadBook : UIDocument
//UIDocument , NSFileWrapper

@property (weak) NSObject<DdFPadPadBookDelegate> *delegate;

@property (strong) DdFPadPadBookInfo *bookInfo;

+(DdFPadPadBook*)newBookWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler;

@end

