#import <Foundation/Foundation.h>

typedef enum {kFeltTip=0} DdFPadPadInkType;

typedef CGFloat DdFPadPadInkSize;

@interface DdFPadPadInk : NSObject

@property (readonly) UIColor *color;
@property (readonly) DdFPadPadInkType inkType;
@property (readonly) DdFPadPadInkSize inkSize;

-(id)initWithColorRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue Alpha:(CGFloat)alpha Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type ;
-(id)initWithJSONDictionary:(NSDictionary*)json;
-(NSString*)InkJSONDictionary;
-(NSString*)InkJSONRepresentation;

@end
