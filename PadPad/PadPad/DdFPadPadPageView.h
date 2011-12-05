#import <UIKit/UIKit.h>

@class DdFPadPadPage;
@class DdFPadPadToolCoordinateAdaptor;

typedef enum {kDdFPadPadPageView_None=0,kDdFPadPadPageView_Left,kDdFPadPadPageView_Right} DdFPadPadPageViewSide;

@interface DdFPadPadPageView : UIView

@property (weak) DdFPadPadToolCoordinateAdaptor *coordinateAdaptor;

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
-(void)showPage:(DdFPadPadPage*)page;
-(void)requiresRedraw;
@end
