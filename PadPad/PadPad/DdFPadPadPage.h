#import <Foundation/Foundation.h>

@class DdFPadPadPaper;

@interface DdFPadPadPage : NSObject

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines Identifier:(NSString*)identifier;

@property (readonly) NSString *pageLabel;
@property (readonly, strong) NSArray *lines;
@property (readonly, strong) NSString *identifier;

@property (strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;

-(NSFileWrapper*)NSFileWrapperRepresentation;

+(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber NSFileWrapper:(NSFileWrapper*)wrapper;
+(NSString*)pageIdentifierFromNSFileWrapper:(NSFileWrapper*)wrapper;
@end
