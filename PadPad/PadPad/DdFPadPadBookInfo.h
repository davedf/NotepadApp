#import <Foundation/Foundation.h>

@interface DdFPadPadBookInfo : NSObject
@property (strong) NSString *bookName;
@property (strong) NSString *bookId;
@property (strong) NSDate *creationDate;
@property (strong) NSDate *lastChangedDate;

-(NSString*)JSONRepresentation;
+(DdFPadPadBookInfo*)newBookInfoWithName:(NSString*)bookName;
+(DdFPadPadBookInfo*)newBookInfoWithJSON:(NSString *)json;
@end
