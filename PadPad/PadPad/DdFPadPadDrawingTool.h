//
//  DdFPadPadDrawingTool.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadDrawingToolDelegate.h"

@protocol DdFPadPadDrawingTool <NSObject>

@property (weak) NSObject<DdFPadPadDrawingToolDelegate> *delegate;
-(void)newGesture;
-(void)touchAtPoint:(CGPoint)point WithVelocity:(CGPoint) velocity;


@end
