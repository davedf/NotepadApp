#import "DdFPadPadLinePoint.h"
#import "CGDdFPadPadUtils.h"

@implementation DdFPadPadLinePoint {
@private
    CGPoint _origin;
    CGPoint _velocity;
    CGFloat _speed;
}
@synthesize origin=_origin, velocity=_velocity,speed=_speed;

-(id)initWithOrigin:(CGPoint)origin velocity:(CGPoint)velocity {
 
    self = [super init];
    if (self) {
        _speed = CGPointMagnitude(velocity);
        _origin = origin;
        _velocity = velocity;
    }
    return self;
}
@end
