//
//  DdFPadPadEraserTool.h
//  PadPad
//
//  Created by David de Florinier on 15/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadDrawingTool.h"
#import "DdfPadPadEraser.h"
@interface DdFPadPadEraserTool : NSObject<DdFPadPadDrawingTool>

-(id)initWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate Eraser:(DdfPadPadEraser*)eraser;
@end
