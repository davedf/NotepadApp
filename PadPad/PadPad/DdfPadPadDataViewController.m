#import "DdfPadPadDataViewController.h"

@implementation DdfPadPadDataViewController

@synthesize dataLabel=_dataLabel,dataObject=_dataObject;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
