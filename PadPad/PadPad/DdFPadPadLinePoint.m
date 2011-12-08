#import "DdFPadPadLinePoint.h"
#import "DdFCGUtils.h"
#import "JSON.h"

#define ORIGIN_KEY @"o"
#define VELOCITY_KEY @"v"

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

-(id)initWithJSONRepresentation:(NSArray*)jsonRepresentation {
    self = [super init];
    if (self) {
        _origin = CGPointMake([[jsonRepresentation objectAtIndex:0] floatValue], [[jsonRepresentation objectAtIndex:1] floatValue]);
        _velocity = CGPointMake([[jsonRepresentation objectAtIndex:2] floatValue], [[jsonRepresentation objectAtIndex:3] floatValue]);
//        _velocity = CGPointFromJSON([jsonRepresentation objectForKey:VELOCITY_KEY]);;
        _speed = CGPointMagnitude(_velocity);
    }
    return self;
    
}

-(NSArray*)DdFJSONRepresentation {
    return [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:_origin.x], 
            [NSNumber numberWithFloat:_origin.y], 
            [NSNumber numberWithFloat:_velocity.x], 
            [NSNumber numberWithFloat:_velocity.y], 
            nil];
}

-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadLinePoint *other = (DdFPadPadLinePoint*)object;
    if (self.origin.x != other.origin.x) {
        return NO;
    }
    if (self.origin.y != other.origin.y) {
        return NO;
    }
    if (self.velocity.x != other.velocity.x) {
        return NO;
    }
    if (self.velocity.y != other.velocity.y) {
        return NO;
    }
    return YES;
}

-(NSString*)description {
    return [[self DdFJSONRepresentation] JSONRepresentation];
}
@end
