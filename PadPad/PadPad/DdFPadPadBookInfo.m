#import "DdFPadPadBookInfo.h"
#import "DdFStringUtils.h"
#import "DdFTimeSource.h"
#import "NSDate+DdFFormatting.h"
#import "JSON.h"

#define BOOK_ID @"bookId"
#define BOOK_NAME @"bookName"
#define CREATION_DATE @"creationDate"
#define LAST_CHANGED_DATE @"lastChangedDate"

@implementation DdFPadPadBookInfo
@synthesize bookId,bookName,creationDate,lastChangedDate;


-(NSString*)JSONRepresentation {
    NSDictionary *json = [[NSDictionary alloc]initWithObjectsAndKeys:
                          self.bookId,BOOK_ID,
                          self.bookName,BOOK_NAME,
                          [self.creationDate toFileStringFormat],CREATION_DATE,
                          [self.lastChangedDate toFileStringFormat],LAST_CHANGED_DATE,
                          
                          nil];
    return [json JSONRepresentation];
}

-(BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadBookInfo *other = (DdFPadPadBookInfo*)object;
    if (![self.bookId isEqual:other.bookId]) {
        return NO;
    }
    if (![self.bookName isEqual:other.bookName]) {
        return NO;
    }
    if (![self.creationDate isEqual:other.creationDate]) {
        return NO;
    }
    if (![self.lastChangedDate isEqual:other.lastChangedDate]) {
        return NO;
    }
    return YES;
}

-(NSString*)description {
    return [self JSONRepresentation];
}

+(DdFPadPadBookInfo*)newBookInfoWithName:(NSString *)bookName  {
    DdFPadPadBookInfo *newinfo = [[DdFPadPadBookInfo alloc] init];
    newinfo.bookName = bookName;
    newinfo.bookId = [DdFStringUtils newStringWithUUID];
    newinfo.creationDate = [DdFTimeSource time];
    newinfo.lastChangedDate = newinfo.creationDate;
    return newinfo;
}

+(DdFPadPadBookInfo*)newBookInfoWithJSON:(NSString *)json {
    DdFPadPadBookInfo *newinfo = [[DdFPadPadBookInfo alloc] init];
    NSDictionary *vals = [json JSONValue];
    newinfo.bookId = [vals objectForKey:BOOK_ID];
    newinfo.bookName = [vals objectForKey:BOOK_NAME];
    newinfo.creationDate = [NSDate dateFromFileFormat:[vals objectForKey:CREATION_DATE]];
    newinfo.lastChangedDate = [NSDate dateFromFileFormat:[vals objectForKey:LAST_CHANGED_DATE]];
    return newinfo;
}
@end
