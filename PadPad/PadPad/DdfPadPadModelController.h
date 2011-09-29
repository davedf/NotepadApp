#import <Foundation/Foundation.h>

@class DdfPadPadDataViewController;

@interface DdfPadPadModelController : NSObject <UIPageViewControllerDataSource>

- (DdfPadPadDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DdfPadPadDataViewController *)viewController;

@end
