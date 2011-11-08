//
//  DdFPadPadViewContants.h
//  PadPad
//
//  Created by David de Florinier on 08/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#define STANDARD_INK_WIDTH 690.0
#define INK_HEIGHT_RATIO 0.75

static inline CGRect DrawableFrameInContainingFrame(CGRect containerFrame) {
    CGFloat inkWidth = MIN(containerFrame.size.width,STANDARD_INK_WIDTH);
    CGFloat offset = (containerFrame.size.width - inkWidth) / 2;
    return CGRectMake(offset, 0, inkWidth, inkWidth/INK_HEIGHT_RATIO);
}