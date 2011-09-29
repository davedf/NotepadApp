#import "DdfPadPadDataViewController.h"

@implementation DdfPadPadDataViewController

@synthesize dataLabel=_dataLabel,dataObject=_dataObject,inkView=_inkView;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
    [self.inkView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(inkPanned:)]];
}

                                       
-(IBAction)inkPanned:(id)sender {
                                           
}
                                       
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
