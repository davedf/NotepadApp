#import <UIKit/UIKit.h>

@class DdFPadPadPage;
@class DdFPadPadPaper;
@class DdFPadPadToolView;

@interface DdfPadPadDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet DdFPadPadToolView *inkView;
@property (strong, nonatomic) DdFPadPadPage *dataObject;

-(void)requiresRedraw;

@end
