#import "DdfPadPadDataViewController.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageView.h"
@interface DdfPadPadDataViewController()
@property (readonly) DdFPadPadPageView *pageView;
-(void)setSpineShading;
@end

@implementation DdfPadPadDataViewController

@synthesize dataLabel=_dataLabel,dataObject=_dataObject,inkView=_inkView;

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"dataObject:%@",self.dataObject);
    self.dataLabel.text = self.dataObject.pageLabel;
    [self setSpineShading];
    [self.inkView setBackgroundColor:[UIColor clearColor]];
    [self.inkView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(inkPanned:)]];
}

                                       
-(IBAction)inkPanned:(id)sender {
                                           
}
                                       
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"willRotateToInterfaceOrientation:%@ from:%@",UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? @"Portrait": @"Landscape",UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? @"Portrait": @"Landscape");
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) && !UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        NSLog(@"hidePageSide for page:%d",self.dataObject.pageNumber);
        [self.pageView hidePageSide];
        [self performSelector:@selector(setSpineShading) withObject:nil afterDelay:duration];
        return;
    } 
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) && !UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        NSLog(@"hidePageSide for page:%d",self.dataObject.pageNumber);
        [self.pageView hidePageSide];
        [self performSelector:@selector(setSpineShading) withObject:nil afterDelay:duration + 0.01];
        return;
    } 
}

#pragma mark - DdfPadPadDataViewController() 
-(DdFPadPadPageView*)pageView {
    return (DdFPadPadPageView*)self.view;
}

-(void)setSpineShading {
    NSLog(@"setSpineShading for page:%d orientation:%@",self.dataObject.pageNumber,UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? @"Protrait": @"Landscape");

    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        NSLog(@"setSpineShading:Left for page:%d",self.dataObject.pageNumber);
        [self.pageView setPageSide:kDdFPadPadPageView_Left];
    }       
    else {
        if (self.dataObject.pageNumber % 2 == 0) {
            NSLog(@"setSpineShading:Left for page:%d",self.dataObject.pageNumber);
            [self.pageView setPageSide:kDdFPadPadPageView_Left];            
        }
        else {
            NSLog(@"setSpineShading:Right for page:%d",self.dataObject.pageNumber);
            [self.pageView setPageSide:kDdFPadPadPageView_Right];
        }
    }

}
@end
