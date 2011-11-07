#import <Foundation/Foundation.h>
#import "DdFPadPadColor.h"

typedef enum {kFeltTip=0} DdFPadPadInkType;

typedef CGFloat DdFPadPadInkSize;

@interface DdFPadPadInk : NSObject

@property (readonly,strong) DdFPadPadColor *color;
@property (readonly) DdFPadPadInkType inkType;
@property (readonly) DdFPadPadInkSize inkSize;

-(id)initWithColor:(DdFPadPadColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type ;
-(id)initWithJSONDictionary:(NSDictionary*)json;
-(NSString*)InkJSONDictionary;
-(NSString*)InkJSONRepresentation;

@end
