#import <Foundation/Foundation.h>

@class DdFPadPadBookInfo;

@protocol DdFPadPadBookDelegate <NSObject>
-(void)bookUpdated;
@end

@interface DdFPadPadBook : UIDocument
//UIDocument , NSFileWrapper, NSUbiquitousKeyValueStore
@property (weak) NSObject<DdFPadPadBookDelegate> *delegate;
@property (strong) DdFPadPadBookInfo *bookInfo;

-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate;

+(DdFPadPadBook*)newBookWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler;

@end

