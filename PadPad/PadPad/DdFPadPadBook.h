#import <Foundation/Foundation.h>
#import "DdFPadPadPage.h"

@class DdFPadPadBookInfo;

@protocol DdFPadPadBookDelegate <NSObject>
-(void)bookUpdated;
@end

@interface DdFPadPadBook : UIDocument
//UIDocument , NSFileWrapper, NSUbiquitousKeyValueStore
@property (weak) NSObject<DdFPadPadBookDelegate> *delegate;
@property (strong) DdFPadPadBookInfo *bookInfo;

-(DdFPadPadPage*)pageForIndex:(NSUInteger)index;
-(NSUInteger)indexOfPage:(DdFPadPadPage*)page;
-(id)initWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate;

+(DdFPadPadBook*)newBookWithName:(NSString*)name Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler;

+(DdFPadPadBook*)bookWithURL:(NSURL*)url Delegate:(NSObject<DdFPadPadBookDelegate>*)delegate CompletionHandler:(void (^)(BOOL success))completionHandler;


@end

