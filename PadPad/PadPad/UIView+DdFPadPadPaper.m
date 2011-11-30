//
//  UIView+DdFPadPadPaper.m
//  PadPad
//
//  Created by David de Florinier on 08/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "UIView+DdFPadPadPaper.h"
#import "DdFPadPadPageLineInformation.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadColor.h"
#import "UIView+DdFPadPadPaper.h"
#import "DdFPadPadViewContants.h"
@implementation UIView (DdFPadPadPaper)

-(void)drawPaper:(DdFPadPadPaper*)paper InContext:(CGContextRef)context WithFrame:(CGRect)paperFrame {
    CGFloat x = paperFrame.origin.x;
    CGFloat y = paperFrame.origin.y;
    CGFloat maxY = y + paperFrame.size.height;
    CGFloat scale = paperFrame.size.width / STANDARD_INK_WIDTH;
    CGFloat maxX = x + paperFrame.size.width;
    NSLog(@"paperFrame:[origin:[%f,%f] size:[%f,%f]]",paperFrame.origin.x,paperFrame.origin.y, paperFrame.size.width,paperFrame.size.height);
    if (paper.horizontal) {
        CGContextStrokePath(context);
        UIColor *penColor = paper.horizontal.lineInk.color.color;
        CGContextSetStrokeColorWithColor(context, [penColor CGColor]);    
        NSUInteger lineIndex = 0;
        CGFloat lineGap = paper.horizontal.lineGap * scale;
        CGFloat maxYDrawn = maxY;
        while (y <= maxY) {
            if (paper.horizontal.hasMajorLines && ((lineIndex % paper.horizontal.majorLineInterval) == 0)) {
                CGContextSetLineWidth(context, paper.horizontal.majorLineInk.inkSize * scale); 
            }
            else {
                CGContextSetLineWidth(context, paper.horizontal.lineInk.inkSize * scale); 
            }
            CGContextMoveToPoint(context, x, y);
            CGContextAddLineToPoint(context, maxX, y);
            CGContextStrokePath(context);
            maxYDrawn = y;
            y+=lineGap;
            lineIndex++;
        }
        maxY = maxYDrawn;
    }
    y = paperFrame.origin.y;
    if (paper.vertical) {
        CGContextStrokePath(context);
        UIColor *penColor = paper.vertical.lineInk.color.color;
        CGContextSetStrokeColorWithColor(context, [penColor CGColor]);    
        NSUInteger lineIndex = 0;
        CGFloat lineGap = paper.vertical.lineGap * scale;
        while (x <= maxX) {
            if (paper.vertical.hasMajorLines && ((lineIndex % paper.vertical.majorLineInterval) == 0)) {
                CGContextSetLineWidth(context, paper.vertical.majorLineInk.inkSize * scale); 
            }
            else {
                CGContextSetLineWidth(context, paper.vertical.lineInk.inkSize * scale); 
            }
            CGContextMoveToPoint(context, x, y);
            CGContextAddLineToPoint(context, x, maxY);
            CGContextStrokePath(context);
            x+=lineGap;
            lineIndex++;
        }

    }
}
@end
