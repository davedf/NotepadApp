#import "PadPadViewController.h"

@implementation PadPadViewController
@synthesize menuView=_menuView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.menuView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
@end
