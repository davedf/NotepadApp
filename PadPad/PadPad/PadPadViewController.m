#import "PadPadViewController.h"

@implementation PadPadViewController
@synthesize menuView=_menuView,bookView=_bookView;

-(void)dealloc {
    self.menuView = nil;
    self.bookView = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    if (self.interfaceOrientation != UIInterfaceOrientationPortrait && self.interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown) {
        [self.menuView willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
        [self.bookView willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
        
    }
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.menuView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.bookView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
@end
