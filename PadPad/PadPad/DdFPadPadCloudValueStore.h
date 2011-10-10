#import <Foundation/Foundation.h>

@interface DdFPadPadCloudValueStore : NSObject

+(BOOL)iCloudEnabled;
+(void)synchronize;
+(NSURL*)LastOpenedDocumentURL;
+(void)SetLastOpenedDocumentURL:(NSURL*)url;
@end
