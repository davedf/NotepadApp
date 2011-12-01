//
//  DdFPadPadInkDrawingItem.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadToolViewDrawingItem.h"
#import "DdFPadPadLine.h"
@interface DdFPadPadInkDrawingItem : NSObject<DdFPadPadToolViewDrawingItem>

-(id)initWithLine:(DdFPadPadLine*)line PointTransformer:(CGAffineTransform)pointTransform LineWidthScale:(CGFloat)lineWidthScale;
@end
