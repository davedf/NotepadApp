#import <UIKit/UIKit.h>

@class DdFPadPadPage;

typedef enum {kDdFPadPadPageView_None=0,kDdFPadPadPageView_Left,kDdFPadPadPageView_Right} DdFPadPadPageViewSide;

@interface DdFPadPadPageView : UIView


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
-(void)showPage:(DdFPadPadPage*)page;
-(void)requiresRedraw;
@end
