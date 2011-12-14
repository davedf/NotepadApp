#import "DdfPadPadRootViewController.h"
#import "DdfPadPadDataViewController.h"
#import "DdFPadPadApplicationState.h"
#import "DdFPadPadBook.h"
#import "DdFPadPadBookRepository.h"
#import "Log.h"

@implementation DdfPadPadRootViewController
@synthesize pageViewController=_pageViewController,modelController=_modelController,book=_book,popController=_popController,undoButton=_undoButton;

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    
    [super viewDidLoad];
    _modelController = [[DdfPadPadModelController alloc] initWithBook:self.book];
    [DdFPadPadApplicationState sharedDdFPadPadApplicationState].rootController = self;
    UIImage *bgImage = [UIImage imageNamed:@"tabletop"];
    UIColor *bgColor = [UIColor colorWithPatternImage:bgImage];
    [self.view setBackgroundColor:bgColor];
    // Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self.modelController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    DdfPadPadDataViewController *startingViewController = [self.modelController viewControllerAtIndex:self.book.lastChangedPage storyboard:self.storyboard pageViewController:self.pageViewController];
    NSArray *viewControllers = [NSArray arrayWithObject:startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectOffset(CGRectInset(pageViewRect, 0.0, 20.0), 0, 20) ;
    self.pageViewController.view.frame = pageViewRect;
    for (UIGestureRecognizer *recogniser in self.pageViewController.gestureRecognizers) {
        if ([recogniser class] == [UIPanGestureRecognizer class]) {
            recogniser.enabled = NO;
        }
    }
    [self.pageViewController didMoveToParentViewController:self];    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue class] == [UIStoryboardPopoverSegue class]) {
        UIStoryboardPopoverSegue *popSegue = (UIStoryboardPopoverSegue*)segue;
        _popController = popSegue.popoverController;
    }
}

-(IBAction)undoButtonClicked:(id)sender {
    if (self.book.undoManager.canUndo) {
        [self.book.undoManager undo];
        for (DdfPadPadDataViewController *dataViewController in self.pageViewController.viewControllers) {
            [dataViewController pageRedrawRequired];
        }
    }
}
#pragma mark - UIPageViewController delegate methods


- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    TRACE(@"spineLocationForInterfaceOrientation");
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }

    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DdfPadPadDataViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
    }

    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];


    return UIPageViewControllerSpineLocationMid;
}

@end
