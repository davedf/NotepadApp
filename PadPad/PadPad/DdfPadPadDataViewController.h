#import <UIKit/UIKit.h>
#import "DdFPadPadDrawingToolDelegate.h"
@class DdFPadPadPage;
@class DdFPadPadPaper;
@class DdFPadPadToolView;

@interface DdfPadPadDataViewController : UIViewController<DdFPadPadDrawingToolDelegate>

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet DdFPadPadToolView *inkView;
@property (strong, nonatomic) DdFPadPadPage *dataObject;
@property (strong, readonly) UIPanGestureRecognizer *panGestureRecogniser;
-(void)requiresRedraw;

@end
