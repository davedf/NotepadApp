#import <Foundation/Foundation.h>

@class DdFPadPadPaper;

@interface DdFPadPadPage : NSObject

-(id)initWithPaper:(DdFPadPadPaper*)paper PageNumber:(NSUInteger)pageNumber Lines:(NSArray*)lines;

@property (readonly) NSString *pageLabel;
@property (readonly, strong) NSArray *lines;
@property (strong) DdFPadPadPaper *paper;
@property NSUInteger pageNumber;

@end
