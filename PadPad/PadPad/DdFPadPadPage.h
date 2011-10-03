#import <Foundation/Foundation.h>

@class DdFPadPadPaper;

@interface DdFPadPadPage : NSObject

@property (strong) NSString *pageLabel;
@property (strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;
@end
