#import <UIKit/UIKit.h>

@class DdFPadPadPage;

@interface DdfPadPadDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIView *inkView;
@property (strong, nonatomic) DdFPadPadPage *dataObject;

@end
