#import <Foundation/Foundation.h>

@interface DdFPadPadLinePoint : NSObject

@property (readonly) CGPoint origin;
@property (readonly) CGPoint velocity;
@property (readonly) CGFloat speed;

-(id)initWithOrigin:(CGPoint)origin velocity:(CGPoint)velocity;
-(id)initWithJSONRepresentation:(NSDictionary*)jsonRepresentation;

-(NSArray*)DdFJSONRepresentation;
@end
