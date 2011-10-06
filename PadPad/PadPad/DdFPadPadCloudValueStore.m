
#import "DdFPadPadCloudValueStore.h"

@implementation DdFPadPadCloudValueStore
static NSURL *s_iCloudUrl;
+(void)initialize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Team-ID + Bundle Identifier
    s_iCloudUrl = [fileManager URLForUbiquityContainerIdentifier:@"ZNRQWH2HBB.com.deflorinier.PadPad"];
    NSLog(@"iCloudURL will be%@", [s_iCloudUrl absoluteString]);
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    [cloudStore synchronize];
/*    
    [cloudStore setString:[iCloudURL absoluteString] forKey:@"iCloudURL"];
    [cloudStore synchronize]; // Important as it stores the values you set before on iCloud
    NSLog(@"iCloudURL=%@", [cloudStore stringForKey:@"iCloudURL"]);
*/
}

@end
