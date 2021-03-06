#import <Foundation/Foundation.h>

@class DdFPadPadPageLineInformation;
@class DdFPadPadColor;

#define PAGE_PAPER_FILE_NAME @"page.paper"
@interface DdFPadPadPaper : NSObject

@property (readonly,strong) DdFPadPadPageLineInformation *horizontal;
@property (readonly,strong) DdFPadPadPageLineInformation *vertical;

@property (readonly,strong)  DdFPadPadColor *paperColor;

-(id)initWithHoriziontal:(DdFPadPadPageLineInformation*)horizontal Vertical:(DdFPadPadPageLineInformation*)vertical PaperColor:(DdFPadPadColor*)paperColor;

-(NSDictionary*)DdFJSONRepresentation;
-(NSFileWrapper*)NSFileWrapperRepresentation;

+(DdFPadPadPaper*)paperWithJSONRepresentation:(NSDictionary*)json;
+(DdFPadPadPaper*)paperWithNSFileWrapperRepresentation:(NSFileWrapper*)wrapper;

@end
