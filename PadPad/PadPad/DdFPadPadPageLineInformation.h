#import <Foundation/Foundation.h>

@class DdFPadPadInk;

@interface DdFPadPadPageLineInformation : NSObject

@property (strong, readonly) DdFPadPadInk *lineInk;

@property (readonly) NSUInteger majorLineInterval;
@property (readonly) BOOL hasMajorLines;
@property (strong, readonly) DdFPadPadInk *majorLineInk;
@property (readonly) CGFloat lineGap;

-(id)initWithLineInk:(DdFPadPadInk*)lineInk LineGap:(CGFloat)lineGap;

-(id)initWithLineInk:(DdFPadPadInk*)lineInk LineGap:(CGFloat)lineGap MajorLineInk:(DdFPadPadInk*)majorLineInk MajorLineInterval:(NSUInteger)majorLineInterval;

-(NSDictionary*)DdFJSONRepresentation;

+(DdFPadPadPageLineInformation*)pageLineInformationWithJSONRepresentation:(NSDictionary*)jsonRepresentation;

@end
