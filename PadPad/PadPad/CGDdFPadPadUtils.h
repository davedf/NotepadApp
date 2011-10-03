#import <UIKit/UIKit.h>


static inline CGFloat CGPointDistance(CGPoint point1,CGPoint point2)
{		    
    CGFloat dx2 = powf(point1.x - point2.x, 2.0);
    CGFloat dy2 = powf(point1.y - point2.y, 2.0);
    return sqrtf(dx2 + dy2);	
}

static inline CGFloat CGPointMagnitude(CGPoint point)
{		    
    return CGPointDistance(CGPointMake(0, 0), point);
}
