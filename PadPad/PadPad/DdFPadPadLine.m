#import "DdFPadPadLine.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadLinePoint.h"

@interface DdFPadPadLine()
-(void)calculateBounds;

@end

@implementation DdFPadPadLine {
    DdFPadPadInk *_ink;
    NSArray *_points;
    CGRect _bounds;
    BOOL _requiresBoundsCalculation;
}
@synthesize ink=_ink, points=_points;

-(id)initWithInk:(DdFPadPadInk*)ink Points:(NSArray*)points {
    self = [super init];
    if (self) {
        _ink = ink;
        _points = points;
        if (!_points) {
            _points = [NSArray array];
        }
        _requiresBoundsCalculation = YES;
    }
    return self;
}

-(void)addPoint:(DdFPadPadLinePoint*) point {
    _points = [_points arrayByAddingObject:point];
    _requiresBoundsCalculation = YES;
}

-(CGRect)bounds {
    if (_requiresBoundsCalculation) {
        [self calculateBounds];        
    }
    return _bounds;
}


#pragma mark - DdFPadPadLine()
-(void)calculateBounds {
    BOOL first = YES;
    CGFloat maxX = 0;
    CGFloat maxY = 0;
    CGFloat minX = 0;
    CGFloat minY = 0;
    for (DdFPadPadLinePoint *point in _points) {
        if (point.origin.x > maxX) {
            maxX = point.origin.x;
        }
        if (point.origin.y > maxY) {
            maxY = point.origin.y;
        }
        if (first) {
            first= NO;
            minX = point.origin.x;
            minY = point.origin.y;
        }
        else {
            if (point.origin.x < minX) {
                minX = point.origin.x;
            }
            if (point.origin.y < minY) {
                minY = point.origin.y;
            }
        }
    }
    _bounds = CGRectMake(minX, minY, maxX - minX, maxY - minY);    
    _requiresBoundsCalculation = NO;
}
@end
