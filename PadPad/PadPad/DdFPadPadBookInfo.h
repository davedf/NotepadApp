#import <Foundation/Foundation.h>

@interface DdFPadPadBookInfo : NSObject
@property (strong) NSString *bookName;
@property (strong) NSString *bookId;
@property (strong) NSDate *creationDate;
@property (strong) NSDate *lastChangedDate;

-(NSFileWrapper*)NSFileWrapperRepresentation;
-(NSString*)JSONRepresentation;

+(DdFPadPadBookInfo*)bookInfoWithName:(NSString*)bookName;
+(DdFPadPadBookInfo*)bookInfoWithJSON:(NSString *)json;
+(DdFPadPadBookInfo*)bookInfoWithNSFileWrapper:(NSFileWrapper*)fileWrapper;
@end
