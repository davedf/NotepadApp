#import "DdFStringUtils.h"

@implementation DdFStringUtils
+ (NSString*) newStringWithUUID {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString ;
}
@end
