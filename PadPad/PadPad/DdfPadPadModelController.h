#import <Foundation/Foundation.h>

@class DdfPadPadDataViewController;
@class DdFPadPadBook;

@interface DdfPadPadModelController : NSObject <UIPageViewControllerDataSource>

- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController;

@property (strong,nonatomic) DdFPadPadBook *book;


@end
