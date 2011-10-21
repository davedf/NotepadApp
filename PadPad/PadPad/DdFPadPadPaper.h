#import <Foundation/Foundation.h>

@class DdFPadPadPageLineInformation;


@interface DdFPadPadPaper : NSObject

@property (readonly,strong) DdFPadPadPageLineInformation *horizontal;
@property (readonly,strong) DdFPadPadPageLineInformation *vertical;

-(id)initWithHoriziontal:(DdFPadPadPageLineInformation*)horizontal Vertical:(DdFPadPadPageLineInformation*)vertical;

-(NSDictionary*)DdFJSONRepresentation;
-(NSFileWrapper*)NSFileWrapperRepresentation;

+(DdFPadPadPaper*)paperWithJSONRepresentation:(NSDictionary*)json;
+(DdFPadPadPaper*)paperWithNSFileWrapperRepresentation:(NSFileWrapper*)wrapper;

@end
