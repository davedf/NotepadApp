//
//  DdFPadPadInkView.m
//  PadPad
//
//  Created by David de Florinier on 06/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadInkView.h"
#import "DdFPadPadLine+CGContextRef.h"
#import "DdFPadPadLinePoint.h"
@interface DdFPadPadInkView()
-(DdFPadPadLine*)line;
@end

@implementation DdFPadPadInkView {
    DdFPadPadLine *_line;
}
@synthesize ink=_ink;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();        
    [self.line drawLineInContext:context];
}

-(DdFPadPadLine*)line {
    if (!_line) {
        CGFloat y = self.bounds.size.height /2;
        CGFloat x1 = 0;
        CGFloat x2 = self.bounds.size.width;
        DdFPadPadLinePoint *p1 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(x1, y) velocity:CGPointMake(10, 10)];
        DdFPadPadLinePoint *p2 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(x2, y) velocity:CGPointMake(10, 10)];
        NSArray *points = [NSArray arrayWithObjects:p1,p2, nil];
        _line = [[DdFPadPadLine alloc]initWithId:@"mini" Ink:self.ink Points:points];
    }
    return _line;
}
@end
