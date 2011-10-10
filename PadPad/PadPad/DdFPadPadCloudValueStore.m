
#import "DdFPadPadCloudValueStore.h"

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
    if (!absoluteUrl) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        NSURL *url = [defaults URLForKey:LAST_OPENED_URL_STRING];        
        NSLog(@"LastOpenedDocumentURL:%@",[url absoluteString]);
        return url;
    }
    else {
        NSLog(@"LastOpenedDocumentURL:%@",absoluteUrl);
        return [NSURL URLWithString:absoluteUrl];
    }
    NSLog(@"LastOpenedDocumentURL:nil");
    return nil;
}

+(void)SetLastOpenedDocumentURL:(NSURL*)url {
    NSString *absoluteUrl = [url absoluteString];
    NSLog(@"SetLastOpenedDocumentURL:%@",absoluteUrl);
    if ([DdFPadPadCloudValueStore iCloudEnabled]) {
        [sCloudStore setString:absoluteUrl forKey:LAST_OPENED_URL_STRING];        
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setURL:url forKey:LAST_OPENED_URL_STRING];
    [defaults synchronize];
    
}

@end
