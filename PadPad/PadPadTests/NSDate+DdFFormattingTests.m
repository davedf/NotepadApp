#import "NSDate+DdFFormattingTests.h"
#import "NSDate+DdFFormatting.h"

#define FILE_FORMATTED_DATE @"2011-10-04T11:55:25.902Z+0100"

@implementation NSDate_DdFFormattingTests

-(void)testFromAndToFileFormatString {
    NSDate *date = [NSDate dateFromFileFormat:FILE_FORMATTED_DATE];
    NSString *result = [date toFileStringFormat];
    STAssertEqualObjects(FILE_FORMATTED_DATE, result, @"Fail");
}

@end
