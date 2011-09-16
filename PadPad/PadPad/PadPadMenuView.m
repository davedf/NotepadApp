#import "PadPadMenuView.h"
#import <QuartzCore/QuartzCore.h>
@implementation PadPadMenuView
@synthesize menuItems=_menuItems;

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.layer setCornerRadius:5.0f];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}

-(void)dealloc {
    self.menuItems =nil;
    [super dealloc];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {


    CGRect newFrame;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        newFrame = CGRectMake(0, 0, MAX(self.frame.size.height, self.frame.size.width),MIN(self.frame.size.height, self.frame.size.width));
    }
    else {
        newFrame = CGRectMake(0, 0, MIN(self.frame.size.height, self.frame.size.width),MAX(self.frame.size.height, self.frame.size.width));

    }
    self.opaque = NO;
    [UIView animateWithDuration:duration/2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        self.frame = newFrame;
        for (UIControl *ctl in self.menuItems) {
            CGRect newCtlFrame = CGRectMake(ctl.frame.origin.y, ctl.frame.origin.x, ctl.frame.size.height, ctl.frame.size.width);
            ctl.frame = newCtlFrame;        
        }
        
    }];

    [UIView animateWithDuration:duration/2 delay:duration/2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished){
        self.opaque = YES;
    }];

    
}


@end
