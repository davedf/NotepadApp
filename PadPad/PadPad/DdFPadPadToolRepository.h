//
//  DdFPadPadToolRepository.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DdFPadPadDrawingTool.h"
#import "DdFPadPadDrawingToolBuilder.h"
#import "DdFPadPadDrawingToolDelegate.h"
#import "DdFPadPadToolCoordinateAdaptor.h"

@interface DdFPadPadToolRepository : NSObject

@property (readonly, strong) NSObject<DdFPadPadDrawingToolBuilder> *selectedToolBuilder;
@property (readonly) NSObject<DdFPadPadDrawingToolBuilder> *penToolBuilder;
@property (readonly) NSObject<DdFPadPadDrawingToolBuilder> *eraserToolBuilder;

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate;
-(void)disposeDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate;

-(void)changeSelectedToolBuilder:(NSObject<DdFPadPadDrawingToolBuilder>*)selectedToolBuilder;
+(DdFPadPadToolRepository*)sharedDdFPadPadToolRepository;
@end
