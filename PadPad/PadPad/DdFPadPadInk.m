#import "DdFPadPadInk.h"

@implementation DdFPadPadInk {
    UIColor *_color;
    DdFPadPadInkType _inkType;
    DdFPadPadInkSize _inkSize;
}
@synthesize inkSize=_inkSize,inkType=_inkType,color=_color;

-(id)initWithColor:(UIColor*)color Size:(DdFPadPadInkSize)size Type:(DdFPadPadInkType)type {
    self = [super init];
    if (self) {
        _color = color;
        _inkSize = size;
        _inkType = type;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadInk *other = (DdFPadPadInk*)object;
    if (other.inkSize != self.inkSize) {
        return NO;
    }
    if (other.inkType != self.inkType) {
        return NO;
    }
    if (![other.color isEqual:self.color]) {
        return NO;
    }
    return YES;
}
@end
