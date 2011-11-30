//
//  DdFPadPadDrawingToolBuilder.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadDrawingTool.h"

@protocol DdFPadPadDrawingToolBuilder <NSObject>
-(NSObject<DdFPadPadDrawingTool>*)newDrawingTool;
@end
