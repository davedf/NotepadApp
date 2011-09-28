#import "PadPadPageView.h"

@interface PadPadPageView()
@property (retain) PadPadPage *page;
@end

@implementation PadPadPageView
@synthesize page=_page,paperView=_paperView;

-(id)initWithCoder:(NSCoder *)aDecoder {
    self= [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];        
    }
    return self;
}

-(void)dealloc {
    self.page = nil;
    self.paperView = nil;
    [super dealloc];
}


-(void)showPage:(PadPadPage *)page {
    self.page = page;
}

-(void)setPageSide:(PadPadPageSide)pageSide {
    
}
@end
