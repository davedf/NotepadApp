#import "DdfPadPadDataViewController.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageView.h"
#import "DdFPadPadViewContants.h"

@interface DdfPadPadDataViewController()
@property (readonly) DdFPadPadPageView *pageView;
-(void)sizeInkView;
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

-(void)viewDidAppear:(BOOL)animated {
    [self sizeInkView];    
}
-(void)sizeInkView {
    self.inkView.frame = DrawableFrameInContainingFrame(self.pageView.frame);
    NSLog(@"inkView size height:%f width:%f",self.inkView.frame.size.height,self.inkView.frame.size.width);
    
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

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self sizeInkView];
    NSLog(@"didRotateFromInterfaceOrientation size height:%f width:%f",self.view.frame.size.height,self.view.frame.size.width);
}
#pragma mark - DdfPadPadDataViewController() 
-(DdFPadPadPageView*)pageView {
    return (DdFPadPadPageView*)self.view;
}

-(void)requiresRedraw {
    [self.pageView requiresRedraw];
}
@end
