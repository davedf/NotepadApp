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

-(id)initWithPageView:(UIView*)pageView ToolView:(UIView*)toolView {
    self = [super init];
    if (self) {
        _toolView = toolView;
        _pageView = pageView;
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

-(CGSize)idealSize {
    return CGSizeMake(IDEAL_PAGE_WIDTH, IDEAL_PAGE_HEIGHT);
}

#pragma mark DdFPadPadToolCoordinateAdaptor()
-(void)calculateTransforms {
    if (CGRectEqualToRect(_pageViewBounds,_pageView.bounds) && CGRectEqualToRect(_toolViewFrame, _toolView.frame)) {
        return;
    }
    _pageViewBounds = _pageView.bounds;
    _toolViewFrame = _toolViewFrame;
    
    CGFloat sx = _pageViewBounds.size.width / IDEAL_PAGE_WIDTH;
    CGFloat sy = _pageViewBounds.size.height / IDEAL_PAGE_HEIGHT;
    CGRect idealFrame = DrawableFrameInContainingFrame(_pageView.frame);
    CGPoint toolTranslation = CGPointMake(_toolViewFrame.origin.x - idealFrame.origin.x, _toolViewFrame.origin.y - idealFrame.origin.y);
    CGAffineTransform t = CGAffineTransformMakeTranslation(toolTranslation.x, toolTranslation.y);
    _toolViewToIdealTransform = CGAffineTransformScale(t, sx, sy);
    
    t= CGAffineTransformMakeScale(1/sx, 1/sy);    
    CGPoint pageTranslation = CGPointMake(-1 * (idealFrame.origin.x), -1 * (idealFrame.origin.y));
    _idealToToolViewTransform = CGAffineTransformTranslate(t, pageTranslation.x, pageTranslation.y);
    _idealToPageViewTransform = t;

}

-(CGAffineTransform) toolViewToIdealTransform {
    [self calculateTransforms];
    return _toolViewToIdealTransform;
}

-(CGAffineTransform) idealToToolViewTransform {
    [self calculateTransforms];
    return _toolViewToIdealTransform;
}

-(CGAffineTransform) idealToPageViewTransform {
    [self calculateTransforms];
    return _toolViewToIdealTransform;
}

@end
