#import <UIKit/UIKit.h>

@class DdFPadPadPage;
@class DdFPadPadPaper;

@interface DdfPadPadDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIView *inkView;
@property (strong, nonatomic) DdFPadPadPage *dataObject;

-(void)requiresRedraw;

@end
