#import <Foundation/Foundation.h>

typedef enum {kFeltTip=0} DdFPadPadInkType;

typedef CGFloat DdFPadPadInkSize;

@interface DdFPadPadInk : NSObject

@property (readonly) UIColor *color;
@property (readonly) DdFPadPadInkType inkType;
@property (readonly) DdFPadPadInkSize inkSize;

-(id)initWithColor:(UIColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type;


@end
