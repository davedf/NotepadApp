#import <UIKit/UIKit.h>
#import "DdfPadPadModelController.h"

@interface DdfPadPadRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) DdfPadPadModelController *modelController;;
@end
