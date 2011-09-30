#import "DdFPadPadPageView.h"
#import <QuartzCore/QuartzCore.h>

#define SPINE_SHADING_WIDTH 20
@implementation DdFPadPadPageView {
    CAGradientLayer *spine;
    DdFPadPadPageViewSide drawnSide;
    DdFPadPadPageViewSide requestedSide;
}

-(void)hidePageSide {
    requestedSide = kDdFPadPadPageView_None;
    [self setNeedsDisplay];
}

-(void)setPageSide:(DdFPadPadPageViewSide)side {
    requestedSide = side;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (drawnSide != requestedSide) {
        if (spine) {
            [spine removeFromSuperlayer];
            spine = nil;
        }
        if (requestedSide != kDdFPadPadPageView_None) {
            CAGradientLayer *gradient = [CAGradientLayer layer];
            if (requestedSide == kDdFPadPadPageView_Left) {
                gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor],nil];
                gradient.frame = CGRectMake(0, 0, SPINE_SHADING_WIDTH, self.bounds.size.height);        
                
            }
            else  {
                gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.05] CGColor],nil];
                gradient.frame = CGRectMake(self.bounds.size.width - SPINE_SHADING_WIDTH, 0, SPINE_SHADING_WIDTH, self.bounds.size.height);
            }
            gradient.startPoint = CGPointMake(0, 0.5);
            gradient.endPoint = CGPointMake(1, 0.5);
            [self.layer insertSublayer:gradient atIndex:0];
            spine = gradient;            
        }
        drawnSide = requestedSide;
    }
}

@end
