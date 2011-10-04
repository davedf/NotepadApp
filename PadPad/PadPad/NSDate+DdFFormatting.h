#import <Foundation/Foundation.h>

@interface NSDate (DdFFormatting)
-(NSString*)toFileStringFormat;

+(NSDate*)dateFromFileFormat:(NSString*)fileFormatString;
@end
