#import "PadPadPaperView.h"
#import <QuartzCore/QuartzCore.h>
@implementation PadPadPaperView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.layer setCornerRadius:10.0f];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}
@end
