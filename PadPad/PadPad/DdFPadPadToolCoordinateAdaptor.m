//
//  DdFPadPadToolCoordinateAdaptor.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolCoordinateAdaptor.h"
#import "DdFPadPadViewContants.h"
#define IDEAL_PAGE_WIDTH STANDARD_INK_WIDTH
#define IDEAL_PAGE_HEIGHT IDEAL_PAGE_WIDTH / INK_HEIGHT_RATIO

@interface DdFPadPadToolCoordinateAdaptor()
@property (readonly) CGAffineTransform toolViewToIdealTransform;
@property (readonly) CGAffineTransform idealToToolViewTransform;
@property (readonly) CGAffineTransform idealToPageViewTransform;
-(void)calculateTransforms;
@end
// portrait paperFrame:[origin:[39.000000,22.000000] size:[690.000000,920.000000]]
// landscape paperFrame:[origin:[0.000000,12.666656] size:[512.000000,682.666687]]
@implementation DdFPadPadToolCoordinateAdaptor {
    __weak UIView *_toolView;
    __weak UIView *_pageView;
    CGRect _pageViewBounds;
    CGRect _toolViewFrame;
    CGAffineTransform _toolViewToIdealTransform;
    CGAffineTransform _idealToToolViewTransform;
    CGAffineTransform _idealToPageViewTransform;
}
@synthesize idealSize=_idealSize;
-(id)initWithPageView:(UIView*)pageView ToolView:(UIView*)toolView {
    self = [super init];
    if (self) {
        _toolView = toolView;
        _pageView = pageView;
        _idealSize = CGSizeMake(IDEAL_PAGE_WIDTH, IDEAL_PAGE_HEIGHT);
    }
    return self;
}

-(CGPoint)convertToolViewPointToIdealPoint:(CGPoint)toolViewPoint {
    return CGPointApplyAffineTransform(toolViewPoint, self.toolViewToIdealTransform);
}
-(CGPoint)convertIdealPointToToolViewPoint:(CGPoint)idealViewPoint {
    return CGPointApplyAffineTransform(idealViewPoint, self.idealToToolViewTransform);
}
-(CGPoint)convertIdealPointToPageViewPoint:(CGPoint)idealViewPoint {
    return CGPointApplyAffineTransform(idealViewPoint, self.idealToPageViewTransform);
}

#pragma mark DdFPadPadToolCoordinateAdaptor()
-(void)calculateTransforms {
    if (CGRectEqualToRect(_pageViewBounds,_pageView.bounds) && CGRectEqualToRect(_toolViewFrame, _toolView.frame)) {
        return;
    }
    _pageViewBounds = _pageView.bounds;
    _toolViewFrame = _toolView.frame;
    CGRect idealFrame = DrawableFrameInContainingFrame(_pageView.frame);
    
    CGFloat sx = self.idealSize.width / idealFrame.size.width;
    NSLog(@"idealFrame.size.width:%f self.idealSize.width:%f sx:%f",idealFrame.size.width,self.idealSize.width,sx);
    CGFloat sy = self.idealSize.height / idealFrame.size.height;
    NSLog(@"idealFrame.size.height:%f self.idealSize.height:%f sy:%f",idealFrame.size.height,self.idealSize.height,sy);
    CGFloat dx = _toolViewFrame.origin.x - idealFrame.origin.x;
    NSLog(@"_toolViewFrame.origin.x:%f idealFrame.origin.x:%f dx:%f",_toolViewFrame.origin.x,idealFrame.origin.x,dx);
    CGFloat dy = _toolViewFrame.origin.y - idealFrame.origin.y;
    NSLog(@"_toolViewFrame.origin.y:%f idealFrame.origin.y:%f dy:%f",_toolViewFrame.origin.y,idealFrame.origin.y,dy);

    CGPoint toolTranslation = CGPointMake(dx, dy);
    CGAffineTransform t = CGAffineTransformMakeTranslation(toolTranslation.x, toolTranslation.y);
    _toolViewToIdealTransform = CGAffineTransformScale(t, sx, sy);
    
    CGPoint pageTranslation = CGPointMake(-1 * dx, -1 * dy);
    t = CGAffineTransformMakeTranslation(pageTranslation.x, pageTranslation.y);
    _idealToToolViewTransform = CGAffineTransformScale(t, 1/sx, 1/sy);
  
    t = CGAffineTransformMakeTranslation(_toolViewFrame.origin.x ,_toolViewFrame.origin.y);
    _idealToPageViewTransform = CGAffineTransformScale(t, 1/sx, 1/sy);
}

-(CGAffineTransform) toolViewToIdealTransform {
    [self calculateTransforms];
    return _toolViewToIdealTransform;
}

-(CGAffineTransform) idealToToolViewTransform {
    [self calculateTransforms];
    return _idealToToolViewTransform;
}

-(CGAffineTransform) idealToPageViewTransform {
    [self calculateTransforms];
    return _idealToPageViewTransform;
}

@end
