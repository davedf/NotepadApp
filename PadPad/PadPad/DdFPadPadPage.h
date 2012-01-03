#import <Foundation/Foundation.h>

@class DdFPadPadPaper;
@class DdFPadPadLine;
@interface DdFPadPadPage : NSObject

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines Identifier:(NSString*)identifier;

@property (readonly) NSString *pageLabel;
@property (readonly, strong) NSArray *lines;
@property (readonly, strong) NSString *identifier;

@property (readonly,strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;
@property (readonly) NSString *filename;
@property (readonly) BOOL requiresSave;

-(NSFileWrapper*)NSFileWrapperRepresentation;
-(void)UpdateNSFileWrapperRepresentation:(NSFileWrapper*)wrapper;

-(void)changePaper:(DdFPadPadPaper*)newPaper;
-(void)addLine:(DdFPadPadLine*)line undoManager:(NSUndoManager*)undoManager;
-(void)replaceLines:(NSArray*)lines WithNewLines:(NSArray*)newLines undoManager:(NSUndoManager*)undoManager;
-(void)removeLine:(NSString*)lineId;

+(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber NSFileWrapper:(NSFileWrapper*)wrapper;
+(NSString*)pageIdentifierFromNSFileWrapper:(NSFileWrapper*)wrapper;
@end
