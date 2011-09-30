#import <UIKit/UIKit.h>

typedef enum {kDdFPadPadPageView_None=0,kDdFPadPadPageView_Left,kDdFPadPadPageView_Right} DdFPadPadPageViewSide;

@interface DdFPadPadPageView : UIView

-(void)setPageSide:(DdFPadPadPageViewSide)side;
-(void)hidePageSide;
@end
