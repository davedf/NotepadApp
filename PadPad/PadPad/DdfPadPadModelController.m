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

@interface DdfPadPadModelController()
@property (readonly, strong, nonatomic) NSMutableArray *pageData;
@property (strong,nonatomic) DdFPadPadBook *book;
-(void)ensurePageToIndex:(NSUInteger)index;
@end

@implementation DdfPadPadModelController

@synthesize pageData=_pageData,book=_book;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        _pageData = [[dateFormatter monthSymbols] copy];
        _pageData= [NSMutableArray array];
        self.book =[[DdFPadPadBookRepository sharedRepository] openDefaultBookWithDelegate:nil CompletionHandler:^(BOOL success) {
            NSLog(@"new book created:%@",success?@"Y":@"N");
        } ];
                    
    }
    return self;
}

-(void)ensurePageToIndex:(NSUInteger)index {
    BOOL added = NO;
    while (self.pageData.count <= index) {
        [self.pageData addObject:[[DdFPadPadPage alloc]init]];
        added = YES;
    }
    if (added) {
        for (NSUInteger i = 0; i < self.pageData.count; i++) {
            DdFPadPadPage *page = [self.pageData objectAtIndex:i];
            page.pageNumber = (i+1);
        }
    }
    
}
- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    [self ensurePageToIndex:index];
    
    // Create a new view controller and pass suitable data.
    DdfPadPadDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DdfPadPadDataViewController"];
    dataViewController.dataObject = [self.pageData objectAtIndex:index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    return [self.pageData indexOfObject:viewController.dataObject];
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
    [self ensurePageToIndex:index];

    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
