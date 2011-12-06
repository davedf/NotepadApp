//
//  DdFPadPadToolCoordinateAdaptorTests.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolCoordinateAdaptorTests.h"
#import "DdFPadPadToolCoordinateAdaptor.h"
#import <UIKit/UIKit.h>
#import "DdFPadPadViewContants.h"

#define PORTRAIT_WIDTH 690.0
#define PORTRAIT_HEIGHT 920.0

#define PAGE_PORTRAIT_WIDTH 768.0
#define PAGE_PORTRAIT_HEIGHT 964.0

#define PAGE_PORTRAIT_X 39.0
#define PAGE_PORTRAIT_Y 22.0

#define LANDSCAPE_WIDTH 512.0
#define LANDSCAPE_HEIGHT 682.666687

#define PAGE_LANDSCAPE_WIDTH 512.0
#define PAGE_LANDSCAPE_HEIGHT 708.0

#define PAGE_LANDSCAPE_X 0.0
#define PAGE_LANDSCAPE_Y 12.666656

@interface DdFPadPadToolCoordinateAdaptorTests()
-(void)changeToLandscape;
@end

@implementation DdFPadPadToolCoordinateAdaptorTests {
    DdFPadPadToolCoordinateAdaptor *underTest;
    UIView *toolView;
    UIView *pageView;
}

-(void)changeToLandscape {
    //inkView:[origin:[0.000000,12.666656] size:[512.000000,682.666687]
    //pageView:[origin:[0.000000,0.000000] size:[512.000000,708.000000]                                           
    pageView.frame = CGRectMake(0, 0, PAGE_LANDSCAPE_WIDTH, PAGE_LANDSCAPE_HEIGHT);
    toolView.frame = DrawableFrameInContainingFrame(pageView.frame);
}

-(void)setUp {
    [super setUp];
    toolView = [[UIView alloc]initWithFrame:CGRectMake(PAGE_PORTRAIT_X, PAGE_PORTRAIT_Y, PORTRAIT_WIDTH, PORTRAIT_HEIGHT)];
    pageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PAGE_PORTRAIT_WIDTH, PAGE_PORTRAIT_HEIGHT)];
    [pageView addSubview:toolView];
    toolView.frame = DrawableFrameInContainingFrame(pageView.frame);
    CGRectLog(@"toolView.frame", toolView.frame);
    underTest = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:pageView ToolView:toolView];
}

-(void)testIdealPageSize {
    CGSize ideal = underTest.idealSize;
    STAssertEquals(CGSizeMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT), ideal, @"Fail");
}

-(void)testTransformsToolViewTopLeftInPortrait {
    CGPoint p = CGPointMake(0, 0);
    CGPoint idealPoint = [underTest convertToolViewPointToIdealPoint:p];
    STAssertEquals(idealPoint, CGPointMake(0, 0), @"Fail");
}

-(void)testTransformsToolViewPointBottomRightInPortrait {
    CGPoint p = CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT);
    CGPoint idealPoint = [underTest convertToolViewPointToIdealPoint:p];
    STAssertEquals(idealPoint, CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT), @"Fail");    
}

-(void)testTransformIdealPointToToolViewPointTopLeftInPortrait {
    CGPoint p = CGPointMake(0, 0);
    CGPoint toolPoint = [underTest convertIdealPointToToolViewPoint:p];
    STAssertEquals(toolPoint, CGPointMake(0, 0), @"Fail");    
}

-(void)testTransformIdealPointToToolViewPointBottomRightInPortrait {
    CGPoint p = CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT);
    CGPoint toolPoint = [underTest convertIdealPointToToolViewPoint:p];
    STAssertEquals(toolPoint, CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT), @"Fail");    
}

-(void)testTransformIdealPointToPageViewPointTopLeftInPortrait {
    CGPoint p = CGPointMake(0, 0);
    CGPoint pagePoint = [underTest convertIdealPointToPageViewPoint:p];
    STAssertEquals(pagePoint, CGPointMake(PAGE_PORTRAIT_X, PAGE_PORTRAIT_Y), @"Fail");    
}
-(void)testTransformIdealPointToPageViewPointBottomRightInPortrait {
    CGPoint p = CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT);
    CGPoint toolPoint = [underTest convertIdealPointToPageViewPoint:p];
    STAssertEquals(toolPoint, CGPointMake(PORTRAIT_WIDTH+PAGE_PORTRAIT_X, PORTRAIT_HEIGHT+PAGE_PORTRAIT_Y), @"Fail");    
}




-(void)testTransformsToolViewTopLeftInLandscape {
    [self changeToLandscape];
    CGPoint p = CGPointMake(0, 0);
    CGPoint idealPoint = [underTest convertToolViewPointToIdealPoint:p];
    STAssertEquals(idealPoint, CGPointMake(0, 0), @"Fail");
}

-(void)testTransformsToolViewPointBottomRightInLandscape {    
    [self changeToLandscape];
    CGPoint p = CGPointMake(LANDSCAPE_WIDTH, LANDSCAPE_HEIGHT);
    CGPoint idealPoint = [underTest convertToolViewPointToIdealPoint:p];
    STAssertEquals(idealPoint, CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT), @"Fail");    
}

-(void)testTransformIdealPointToToolViewPointTopLeftInLandscape {
    [self changeToLandscape];
    CGPoint p = CGPointMake(0, 0);
    CGPoint toolPoint = [underTest convertIdealPointToToolViewPoint:p];
    STAssertEquals(toolPoint, CGPointMake(0, 0), @"Fail");    
}

-(void)testTransformIdealPointToToolViewPointBottomRightInLandscape {
    [self changeToLandscape];
    CGPoint p = CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT);
    CGPoint toolPoint = [underTest convertIdealPointToToolViewPoint:p];
    STAssertEquals(toolPoint, CGPointMake(LANDSCAPE_WIDTH, LANDSCAPE_HEIGHT), @"Fail");    
}

-(void)testTransformIdealPointToPageViewPointTopLeftInLandscape {
    [self changeToLandscape];
    CGPoint p = CGPointMake(0, 0);
    CGPoint pagePoint = [underTest convertIdealPointToPageViewPoint:p];
    STAssertEqualsWithAccuracy(pagePoint.x, (CGFloat)PAGE_LANDSCAPE_X, 0.0001, @"Fail");
    STAssertEqualsWithAccuracy(pagePoint.y, (CGFloat)PAGE_LANDSCAPE_Y, 0.0001, @"Fail");
}
-(void)testTransformIdealPointToPageViewPointBottomRightInLandscape {
    [self changeToLandscape];
    CGPoint p = CGPointMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT);
    CGPoint toolPoint = [underTest convertIdealPointToPageViewPoint:p];
    STAssertEqualsWithAccuracy(toolPoint.x, (CGFloat)(LANDSCAPE_WIDTH+PAGE_LANDSCAPE_X), 0.0001, @"Fail");
    STAssertEqualsWithAccuracy(toolPoint.y, (CGFloat)(LANDSCAPE_HEIGHT+PAGE_LANDSCAPE_Y), 0.0001, @"Fail");

}

@end
