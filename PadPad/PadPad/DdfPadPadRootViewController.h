#import <UIKit/UIKit.h>
#import "DdfPadPadModelController.h"

@interface DdfPadPadRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) DdfPadPadModelController *modelController;
@property (strong) DdFPadPadBook *book;
@property (weak,readonly) UIPopoverController *popController;
@property (strong, nonatomic) IBOutlet UIButton *undoButton;

-(IBAction)undoButtonClicked:(id)sender;
@end
