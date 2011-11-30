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
@protocol DdFPadPadDrawingToolDelegate <NSObject>

-(void)drawInProgressLine:(DdFPadPadLine*)line;
-(void)drawCompletedLine:(DdFPadPadLine*)line;

@end
