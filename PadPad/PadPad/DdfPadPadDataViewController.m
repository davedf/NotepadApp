#import "DdfPadPadDataViewController.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageView.h"

@interface DdfPadPadDataViewController()
@property (readonly) DdFPadPadPageView *pageView;
@end

@implementation DdfPadPadDataViewController

@synthesize dataLabel=_dataLabel,dataObject=_dataObject,inkView=_inkView;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"dataObject:%@",self.dataObject);
    self.dataLabel.text = self.dataObject.pageLabel;
    [self.pageView showPage:self.dataObject];
    [self.inkView setBackgroundColor:[UIColor clearColor]];
    [self.inkView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(inkPanned:)]];
}

                                       
-(IBAction)inkPanned:(id)sender {
                                           
}
                                       
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {        
    [self.pageView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

#pragma mark - DdfPadPadDataViewController() 
-(DdFPadPadPageView*)pageView {
    return (DdFPadPadPageView*)self.view;
}

@end
