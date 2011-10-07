#import <Foundation/Foundation.h>

@interface DdFPadPadBookInfo : NSObject
@property (strong) NSString *bookName;
@property (strong) NSString *bookId;
@property (strong) NSDate *creationDate;
@property (strong) NSDate *lastChangedDate;

@property (readonly) NSString *fileName;

-(NSString*)JSONRepresentation;
-(NSData*)NSDataRepresentation;
-(NSFileWrapper*)NSFileWrapperRepresentation;

+(BOOL)recognises:(NSFileWrapper*)fileWrapper;
+(DdFPadPadBookInfo*)bookInfoWithName:(NSString*)bookName;
+(DdFPadPadBookInfo*)bookInfoWithJSON:(NSString *)json;
+(DdFPadPadBookInfo*)bookInfoWithNSFileWrapper:(NSFileWrapper*)fileWrapper;


@end
