#import <Foundation/Foundation.h>
#import "DdFPadPadColor.h"

typedef enum {kFeltTip=0} DdFPadPadInkType;

typedef CGFloat DdFPadPadInkSize;

@interface DdFPadPadInk : NSObject

@property (readonly,strong) DdFPadPadColor *color;
@property (readonly) DdFPadPadInkType inkType;
@property (readonly) DdFPadPadInkSize inkSize;
@property (readonly,strong) NSString *name;
-(id)initWithColor:(DdFPadPadColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type Name:(NSString*)name;
-(NSString*)InkJSONRepresentation;

+(DdFPadPadInk*)inkFromJson:(NSString*)json;
@end
