#import <Foundation/Foundation.h>

@class DdFPadPadInk;
@class DdFPadPadLinePoint;

@interface DdFPadPadLine : NSObject

-(id)initWithId:(NSString*)lineId Ink:(DdFPadPadInk*)ink Points:(NSArray*)points;
-(void)addPoint:(DdFPadPadLinePoint*) point;

@property (readonly) NSString *lineId;
@property (readonly) DdFPadPadInk *ink;
@property (readonly) NSArray /*<DdFPadPadLinePoint>*/ *points;
@property (readonly) CGRect bounds;

-(NSString*)DdFJSONRepresentation;
-(NSFileWrapper*)NSFileWrapperRepresentation;

+(DdFPadPadLine*)lineFromNSFileWrapper:(NSFileWrapper*)fileWrapper;
+(NSArray*)JSONArrayToPoints:(NSArray*)jsonArray;
@end
