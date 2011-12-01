//
//  DdFPadPadToolViewDrawingItem.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DdFPadPadToolViewDrawingItem <NSObject>

-(void)drawInContext:(CGContextRef)contextRef;
@end
