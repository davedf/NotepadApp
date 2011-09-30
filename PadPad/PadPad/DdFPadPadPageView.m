#import "DdFPadPadPageView.h"
#import <QuartzCore/QuartzCore.h>

#define SPINE_SHADING_WIDTH 20
@implementation DdFPadPadPageView {
    CAGradientLayer *spine;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)hidePageSide {
    if (spine) {
        [spine removeFromSuperlayer];
        spine = nil;
    }    
}

-(void)setPageSide:(DdFPadPadPageViewSide)side {
    if (spine) {
        [spine removeFromSuperlayer];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    if (side == kDdFPadPadPageView_Left) {
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor],nil];
        gradient.frame = CGRectMake(0, 0, SPINE_SHADING_WIDTH, self.bounds.size.height);        
        
    }
    else {
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.05] CGColor],nil];
        gradient.frame = CGRectMake(self.bounds.size.width - SPINE_SHADING_WIDTH, 0, SPINE_SHADING_WIDTH, self.bounds.size.height);
    }
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    [self.layer insertSublayer:gradient atIndex:0];
    spine = gradient;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
