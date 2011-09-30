#import <UIKit/UIKit.h>

typedef enum {kDdFPadPadPageView_Left,kDdFPadPadPageView_Right} DdFPadPadPageViewSide;

@interface DdFPadPadPageView : UIView

-(void)setPageSide:(DdFPadPadPageViewSide)side;
-(void)hidePageSide;
@end
