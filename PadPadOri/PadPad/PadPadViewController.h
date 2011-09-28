#import <UIKit/UIKit.h>
#import "PadPadMenuView.h"
#import "PadPadBookView.h"

@interface PadPadViewController : UIViewController

@property (nonatomic,retain) IBOutlet PadPadMenuView *menuView;
@property (nonatomic,retain) IBOutlet PadPadBookView *bookView;
@end
