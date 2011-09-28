#import <UIKit/UIKit.h>
#import "PadPadPage.h"
#import "PadPadPaperView.h"

typedef enum {
    PadPadPageSideLeft, PadPadPageSideRight
} PadPadPageSide;


@interface PadPadPageView : UIView

@property (nonatomic,retain) IBOutlet PadPadPaperView *paperView;

-(void)setPageSide:(PadPadPageSide)pageSide;
-(void)showPage:(PadPadPage*)page;
@end
