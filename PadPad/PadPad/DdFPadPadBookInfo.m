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


-(NSFileWrapper*)NSFileWrapperRepresentation {
    NSString *json = [self JSONRepresentation];
    NSData *data = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    return wrapper;
}

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

+(DdFPadPadBookInfo*)bookInfoWithName:(NSString *)bookName  {
    DdFPadPadBookInfo *newinfo = [[DdFPadPadBookInfo alloc] init];
    newinfo.bookName = bookName;
    newinfo.bookId = [DdFStringUtils newStringWithUUID];
    newinfo.creationDate = [DdFTimeSource time];
    newinfo.lastChangedDate = newinfo.creationDate;
    return newinfo;
}

+(DdFPadPadBookInfo*)bookInfoWithJSON:(NSString *)json {
    DdFPadPadBookInfo *newinfo = [[DdFPadPadBookInfo alloc] init];
    NSDictionary *vals = [json JSONValue];
    newinfo.bookId = [vals objectForKey:BOOK_ID];
    newinfo.bookName = [vals objectForKey:BOOK_NAME];
    newinfo.creationDate = [NSDate dateFromFileFormat:[vals objectForKey:CREATION_DATE]];
    newinfo.lastChangedDate = [NSDate dateFromFileFormat:[vals objectForKey:LAST_CHANGED_DATE]];
    return newinfo;
}

+(DdFPadPadBookInfo*)bookInfoWithNSFileWrapper:(NSFileWrapper*)fileWrapper {
    NSString *json = [[NSString alloc]initWithBytes:[fileWrapper.regularFileContents bytes] length:[fileWrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    return [DdFPadPadBookInfo bookInfoWithJSON:json];
}
@end
