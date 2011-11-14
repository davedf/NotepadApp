#import "DdfPadPadModelController.h"

#import "DdfPadPadDataViewController.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadBookRepository.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@implementation DdfPadPadModelController

@synthesize book=_book;

-(id)initWithBook:(DdFPadPadBook*)book
{
    self = [super init];
    if (self) {
        // Create the data model.
        self.book =book;                    
    }
    return self;
}

- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    // Create a new view controller and pass suitable data.
    DdfPadPadDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DdfPadPadDataViewController"];
    dataViewController.dataObject = [self.book pageForIndex:index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    return [self.book indexOfPage:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DdfPadPadDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DdfPadPadDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }    
    index++;

    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
