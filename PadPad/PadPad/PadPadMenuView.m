#import "PadPadMenuView.h"

@implementation PadPadMenuView
@synthesize menuItems=_menuItems;

-(void)dealloc {
    self.menuItems =nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.height, self.frame.size.width);
    
    self.frame = newFrame;
    for (UIControl *ctl in self.menuItems) {
        CGRect newCtlFrame = CGRectMake(ctl.frame.origin.y, ctl.frame.origin.x, ctl.frame.size.height, ctl.frame.size.width);
        ctl.frame = newCtlFrame;        
    }
}


@end
