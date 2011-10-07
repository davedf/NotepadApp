
#import "DdFPadPadCloudValueStore.h"

#define LAST_OPENED_URL_STRING @"lastOpenedDocument"
@implementation DdFPadPadCloudValueStore
static NSURL *s_iCloudUrl;
static NSUbiquitousKeyValueStore *sCloudStore;
+(void)initialize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Team-ID + Bundle Identifier
    s_iCloudUrl = [fileManager URLForUbiquityContainerIdentifier:@"ZNRQWH2HBB.com.deflorinier.PadPad"];
    NSLog(@"iCloudURL will be%@", [s_iCloudUrl absoluteString]);
    sCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [sCloudStore synchronize];
}

+(void)synchronize {
    [sCloudStore synchronize];
}
+(NSURL*)LastOpenedDocumentURL {
    NSString *absoluteUrl = [sCloudStore stringForKey:LAST_OPENED_URL_STRING];
    NSLog(@"absoluteUrl:%@",absoluteUrl);
    if (absoluteUrl) {
        return [NSURL URLWithString:absoluteUrl];
    }
    return nil;
}
+(void)SetLastOpenedDocumentURL:(NSURL*)url {
    NSString *absoluteUrl = [url absoluteString];
    [sCloudStore setString:absoluteUrl forKey:LAST_OPENED_URL_STRING];
    
}

@end
