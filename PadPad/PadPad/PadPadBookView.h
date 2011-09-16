#import <UIKit/UIKit.h>
#import "PadPadPageView.h"

@interface PadPadBookView : UIView

@property (nonatomic,retain) IBOutlet PadPadPageView *leftPage;
@property (nonatomic,retain) IBOutlet PadPadPageView *rightPage;

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end
