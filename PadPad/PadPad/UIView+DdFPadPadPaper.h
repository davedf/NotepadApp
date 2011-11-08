//
//  UIView+DdFPadPadPaper.h
//  PadPad
//
//  Created by David de Florinier on 08/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DdFPadPadPaper.h"

@interface UIView (DdFPadPadPaper)
-(void)drawPaper:(DdFPadPadPaper*)paper InContext:(CGContextRef)context WithFrame:(CGRect)paperFrame;
@end
