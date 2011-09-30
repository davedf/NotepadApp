#import <UIKit/UIKit.h>

@class DdFPadPadPage;

typedef enum {kDdFPadPadPageView_None=0,kDdFPadPadPageView_Left,kDdFPadPadPageView_Right} DdFPadPadPageViewSide;

@interface DdFPadPadPageView : UIView

@property (strong, nonatomic) DdFPadPadPage *dataObject;

-(void)showSpineShading;
-(void)hideSpineShading;
@end
