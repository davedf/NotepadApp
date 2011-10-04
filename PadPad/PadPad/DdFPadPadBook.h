#import <Foundation/Foundation.h>


@protocol DdFPadPadBookDelegate <NSObject>
-(void)bookUpdated;
@end

@interface DdFPadPadBook : UIDocument
//UIDocument , NSFileWrapper

@property (weak) NSObject<DdFPadPadBookDelegate> *delegate;
@end

