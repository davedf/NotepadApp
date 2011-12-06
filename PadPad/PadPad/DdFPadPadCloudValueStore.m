
#import "DdFPadPadCloudValueStore.h"
#import "Log.h"
#define LAST_OPENED_URL_STRING @"lastOpenedDocument"
@implementation DdFPadPadCloudValueStore
static NSURL *s_iCloudUrl;
static NSUbiquitousKeyValueStore *sCloudStore;

+(BOOL)iCloudEnabled {
    return s_iCloudUrl != nil;
}

+(void)initialize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Team-ID + Bundle Identifier
    s_iCloudUrl = [fileManager URLForUbiquityContainerIdentifier:@"ZNRQWH2HBB.com.deflorinier.PadPad"];
    TRACE(@"iCloudURL will be%@", [s_iCloudUrl absoluteString]);
    sCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [sCloudStore synchronize];
}

+(void)synchronize {
    [sCloudStore synchronize];
}
+(NSURL*)LastOpenedDocumentURL {
    NSString *absoluteUrl = [sCloudStore stringForKey:LAST_OPENED_URL_STRING];
    TRACE(@"absoluteUrl:%@",absoluteUrl);
    if (!absoluteUrl) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        NSURL *url = [defaults URLForKey:LAST_OPENED_URL_STRING];        
        TRACE(@"LastOpenedDocumentURL:%@",[url absoluteString]);
        return url;
    }
    else {
        TRACE(@"LastOpenedDocumentURL:%@",absoluteUrl);
        return [NSURL URLWithString:absoluteUrl];
    }
    TRACE(@"LastOpenedDocumentURL:nil");
    return nil;
}

+(void)SetLastOpenedDocumentURL:(NSURL*)url {
    NSString *absoluteUrl = [url absoluteString];
    TRACE(@"SetLastOpenedDocumentURL:%@",absoluteUrl);
    if ([DdFPadPadCloudValueStore iCloudEnabled]) {
        [sCloudStore setString:absoluteUrl forKey:LAST_OPENED_URL_STRING];        
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setURL:url forKey:LAST_OPENED_URL_STRING];
    [defaults synchronize];
    
}

@end
