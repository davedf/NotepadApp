#import <Foundation/Foundation.h>

@class DdFPadPadPaper;
@class DdFPadPadLine;
@interface DdFPadPadPage : NSObject

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines Identifier:(NSString*)identifier;

@property (readonly) NSString *pageLabel;
@property (readonly, strong) NSArray *lines;
@property (readonly, strong) NSString *identifier;

@property (strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;
@property (readonly) NSString *filename;

-(NSFileWrapper*)NSFileWrapperRepresentation;
-(void)UpdateNSFileWrapperRepresentation:(NSFileWrapper*)wrapper;

-(void)addLine:(DdFPadPadLine*)line;

+(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber NSFileWrapper:(NSFileWrapper*)wrapper;
+(NSString*)pageIdentifierFromNSFileWrapper:(NSFileWrapper*)wrapper;
@end
