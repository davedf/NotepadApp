#import <Foundation/Foundation.h>

@class DdfPadPadDataViewController;
@class DdFPadPadBook;

@interface DdfPadPadModelController : NSObject <UIPageViewControllerDataSource>

- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard pageViewController:(UIPageViewController*)pageViewController;
- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController;

@property (strong,nonatomic) DdFPadPadBook *book;

-(id)initWithBook:(DdFPadPadBook*)book;
@end
