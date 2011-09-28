#import "PadPadBookView.h"
#import "PadPadCGUtil.h"


@implementation PadPadBookView
@synthesize leftPage=_leftPage,rightPage=_rightPage;

-(void)dealloc {
    self.leftPage = nil;
    self.rightPage = nil;
    [super dealloc];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGRect newFrame;
    NSLog(@"frame before:%@",CGRectToString(self.frame));
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation ==UIInterfaceOrientationPortraitUpsideDown) {    
        CGFloat x = MIN(self.frame.origin.x, self.frame.origin.y);
        CGFloat y = MAX(self.frame.origin.x, self.frame.origin.y);

        CGFloat height = 944; //20 + MAX(self.superview.frame.size.width, self.superview.frame.size.height);
        CGFloat width = 768; //MIN(self.superview.frame.size.width, self.superview.frame.size.height) - 20;
        newFrame = CGRectMake(
                           x, 
                           y, 
                           width, 
                           height);
    }
    else {
        CGFloat x = MAX(self.frame.origin.x, self.frame.origin.y);
        CGFloat y = MIN(self.frame.origin.x, self.frame.origin.y);
        
        CGFloat height = 748; //MIN(self.superview.frame.size.width, self.superview.frame.size.height);
        CGFloat width = 964; //20 + MAX(self.superview.frame.size.width, self.superview.frame.size.height);
        newFrame = CGRectMake(
                              x, 
                              y, 
                              width, 
                              height);

    }

    
    self.frame= newFrame;
    NSLog(@"frame after:%@",CGRectToString(self.frame));
    
}
@end
