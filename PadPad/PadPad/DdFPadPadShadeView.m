//
//  DdFPadPadShadeView.m
//  PadPad
//
//  Created by David de Florinier on 09/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadShadeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DdFPadPadShadeView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor], 
                       (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor],nil];
    gradient.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);        
    [self.layer insertSublayer:gradient atIndex:0];


    CGContextRef context = UIGraphicsGetCurrentContext();        
    CGContextStrokePath(context);
    CGContextSetLineWidth(context, 1); 
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);    
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextStrokePath(context);


}

@end
