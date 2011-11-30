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
@implementation DdFPadPadToolCoordinateAdaptorTests {
    DdFPadPadToolCoordinateAdaptor *underTest;
    UIView *toolView;
    UIView *pageView;
}

-(void)setUp {
    [super setUp];
    toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 978)];
    pageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1004)];
    [pageView addSubview:toolView];
    underTest = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:pageView ToolView:toolView];
}

-(void)testIdealPageSize {
    CGSize ideal = underTest.idealSize;
    STAssertEquals(CGSizeMake(690, 920), ideal, @"Fail");
}
@end
