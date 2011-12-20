//
//  DdFPadPadEraserToolBuilder.h
//  PadPad
//
//  Created by David de Florinier on 20/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadDrawingToolBuilder.h"
#import "DdfPadPadEraser.h"
@interface DdFPadPadEraserToolBuilder : NSObject<DdFPadPadDrawingToolBuilder>

@property (strong) DdfPadPadEraser *eraser;

@end
