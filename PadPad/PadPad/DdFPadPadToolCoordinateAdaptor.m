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
@property (readonly) CGAffineTransform toolViewVelocityToIdealVelocityTransform;
-(void)calculateTransforms;
@end


@implementation DdFPadPadToolCoordinateAdaptor {
    __weak UIView *_toolView;
    __weak UIView *_pageView;
    CGRect _pageViewBounds;
    CGRect _toolViewFrame;
    CGAffineTransform _toolViewToIdealTransform;
    CGAffineTransform _toolViewVelocityToIdealVelocityTransform;
    CGAffineTransform _idealToToolViewTransform;
    CGAffineTransform _idealToPageViewTransform;
    CGFloat _idealToToolLineWidthScale;
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

-(CGPoint)convertToolViewVelocityToIdealVelocity:(CGPoint)toolViewVelocity {
    return CGPointApplyAffineTransform(toolViewVelocity, self.toolViewVelocityToIdealVelocityTransform);
}
#pragma mark DdFPadPadToolCoordinateAdaptor()
-(void)calculateTransforms {
    if (CGRectEqualToRect(_pageViewBounds,_pageView.frame) && CGRectEqualToRect(_toolViewFrame, _toolView.frame)) {
        return;
    }
    _pageViewBounds = _pageView.frame;
    _toolViewFrame = _toolView.frame;
    CGRect idealFrame = DrawableFrameInContainingFrame(_pageView.frame);
    NSLog(@"calculateTransforms -START ----------------");
    CGRectNSLog(@"idealFrame", idealFrame);
    CGFloat sx = self.idealSize.width / idealFrame.size.width;
    NSLog(@"idealFrame.size.width:%f self.idealSize.width:%f sx:%f",idealFrame.size.width,self.idealSize.width,sx);
    CGFloat sy = self.idealSize.height / idealFrame.size.height;
    NSLog(@"idealFrame.size.height:%f self.idealSize.height:%f sy:%f",idealFrame.size.height,self.idealSize.height,sy);
    CGRectNSLog(@"_pageViewBounds",_pageViewBounds);
    CGFloat dx = (_toolViewFrame.origin.x - _pageViewBounds.origin.x) - idealFrame.origin.x;
    NSLog(@"_toolViewFrame.origin.x:%f idealFrame.origin.x:%f dx:%f",_toolViewFrame.origin.x,idealFrame.origin.x,dx);
    CGFloat dy = (_toolViewFrame.origin.y - _pageViewBounds.origin.y) - idealFrame.origin.y;
    NSLog(@"_toolViewFrame.origin.y:%f idealFrame.origin.y:%f dy:%f",_toolViewFrame.origin.y,idealFrame.origin.y,dy);
    NSLog(@"calculateTransforms -END ----------------");

    CGPoint toolTranslation = CGPointMake(dx, dy);
    CGAffineTransform t = CGAffineTransformMakeTranslation(toolTranslation.x, toolTranslation.y);
    _toolViewToIdealTransform = CGAffineTransformScale(t, sx, sy);
    _toolViewVelocityToIdealVelocityTransform = CGAffineTransformMakeScale(sx, sy);
    CGPoint pageTranslation = CGPointMake(-1 * dx, -1 * dy);
    t = CGAffineTransformMakeTranslation(pageTranslation.x, pageTranslation.y);
    _idealToToolViewTransform = CGAffineTransformScale(t, 1/sx, 1/sy);
    _idealToToolLineWidthScale = 1/sx;
    t = CGAffineTransformMakeTranslation(_pageViewBounds.origin.x + _toolViewFrame.origin.x + idealFrame.origin.x, _pageViewBounds.origin.y + _toolViewFrame.origin.y + idealFrame.origin.y);
    _idealToPageViewTransform = CGAffineTransformScale(t, 1/sx, 1/sy);
    
    
}

-(CGFloat) idealToToolLineWidthScale {
    [self calculateTransforms];
    return _idealToToolLineWidthScale;
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

-(CGAffineTransform) toolViewVelocityToIdealVelocityTransform {
    [self calculateTransforms];
    return _toolViewVelocityToIdealVelocityTransform;
}

@end
