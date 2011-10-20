#import <Foundation/Foundation.h>

@class DdFPadPadPaper;

@interface DdFPadPadPage : NSObject

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber;

@property (readonly) NSString *pageLabel;

@property (strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;

-(NSDictionary*)DdFJSONRepresentation;

+(DdFPadPadPage*)pageFromJSONDictionary:(NSDictionary*)jsonDictionary;
@end
