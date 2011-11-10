//
//  DdFPadPadPaperView.m
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPaperView.h"
#import "UIView+DdFPadPadPaper.h"
#import "DdFPadPadColor.h"

@implementation DdFPadPadPaperView
@synthesize paper=_paper;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();        
    [self setBackgroundColor:self.paper.paperColor.color];
    [self drawPaper:self.paper InContext:context WithFrame:CGRectOffset(CGRectInset(self.bounds, 5, 5), 0, 2) ];

    CGContextStrokePath(context);
    CGContextSetLineWidth(context, 1); 
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);

}

-(void)setPaperToShow:(DdFPadPadPaper *)paper {
    _paper = paper;
    [self setBackgroundColor:self.paper.paperColor.color];
}
@end
