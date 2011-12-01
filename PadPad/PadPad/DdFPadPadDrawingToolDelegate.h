//
//  DdFPadPadDrawingToolDelegate.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadPage.h"
#import "DdFPadPadLine.h"
#import "DdFPadPadToolCoordinateAdaptor.h"
#import "DdFPadPadToolView.h"

@protocol DdFPadPadDrawingToolDelegate <NSObject>

@property (readonly) DdFPadPadPage *page;
@property (readonly) DdFPadPadToolView *toolView;
@property (readonly) UIView *pageView;
@property (readonly) DdFPadPadToolCoordinateAdaptor *coordinateAdaptor;
-(void)pageRedrawRequired;

@end
