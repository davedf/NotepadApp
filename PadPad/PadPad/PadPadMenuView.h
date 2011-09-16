#import <UIKit/UIKit.h>

@interface PadPadMenuView : UIView
@property (nonatomic, retain) IBOutletCollection(UIControl) NSArray *menuItems;

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
@end
