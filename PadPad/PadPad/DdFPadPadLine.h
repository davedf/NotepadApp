#import <Foundation/Foundation.h>

@class DdFPadPadInk;
@class DdFPadPadLinePoint;

@interface DdFPadPadLine : NSObject

-(id)initWithInk:(DdFPadPadInk*)ink Points:(NSArray*)points;
-(void)addPoint:(DdFPadPadLinePoint*) point;

@property (readonly) DdFPadPadInk *ink;
@property (readonly) NSArray /*<DdFPadPadLinePoint>*/ *points;
@property (readonly) CGRect bounds;

@end
