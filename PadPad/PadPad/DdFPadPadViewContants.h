//
//  DdFPadPadViewContants.h
//  PadPad
//
//  Created by David de Florinier on 08/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#define STANDARD_INK_WIDTH 690.0
#define INK_HEIGHT_RATIO 0.75
#import "DdFCGUtils.h"

static inline CGRect DrawableFrameInContainingFrame(CGRect containerFrame) {
    CGRectNSLog(@"containerFrame", containerFrame);
    CGFloat inkWidth = MIN(containerFrame.size.width,STANDARD_INK_WIDTH);
    CGFloat inkHeight = inkWidth / INK_HEIGHT_RATIO;
    CGFloat xOffset = (containerFrame.size.width - inkWidth) / 2;
    CGFloat yOffset = (containerFrame.size.height - inkHeight) /2;
    CGRect drawableFrame = CGRectMake(xOffset, yOffset, inkWidth, inkHeight);
    CGRectNSLog(@"drawableFrame", drawableFrame);
    return drawableFrame;
    
}