//
//  DdFPadPadEraserDrawingItem.h
//  PadPad
//
//  Created by David de Florinier on 19/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadToolViewDrawingItem.h"

@interface DdFPadPadEraserDrawingItem : NSObject<DdFPadPadToolViewDrawingItem>

-(id)initWithPoint:(CGPoint)point size:(CGFloat)size;
@end
