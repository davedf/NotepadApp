#import "NSDate+DdFFormatting.h"

static NSDateFormatter *s_fileStringFormatter;
static inline NSDateFormatter* FileStringFormatter() {
    if (!s_fileStringFormatter) {
        s_fileStringFormatter = [[NSDateFormatter alloc]init];
        [s_fileStringFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'Z"];
        
    }
    return s_fileStringFormatter;
    
}
@implementation NSDate (DdFFormatting)


-(NSString*)toFileStringFormat {
    
    return [FileStringFormatter() stringFromDate:self];
}

+(NSDate*)dateFromFileFormat:(NSString*)fileFormatString {
    return [FileStringFormatter() dateFromString:fileFormatString];
}
@end
