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
#import "Log.h"
@interface DdFPadPadInkView()
-(DdFPadPadLine*)line;
@end

@implementation DdFPadPadInkView {
}
@synthesize ink=_ink;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    TRACE(@"DdFPadPadInkView draw");
    [self setBackgroundColor:[UIColor whiteColor]];
    CGContextRef context = UIGraphicsGetCurrentContext();        
    DdFPadPadLine *line = self.line;
    TRACE(@"line:%@",[line DdFJSONRepresentation]);
    [self.line drawLineInContext:context];
}

-(DdFPadPadLine*)line {
    CGFloat y = self.bounds.size.height /2;
    CGFloat x1 = 20;
    CGFloat x2 = self.bounds.size.width - 20;
    DdFPadPadLinePoint *p1 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(x1, y) velocity:CGPointMake(10, 10)];
    DdFPadPadLinePoint *p2 = [[DdFPadPadLinePoint alloc]initWithOrigin:CGPointMake(x2, y) velocity:CGPointMake(10, 10)];

    NSArray *points = [NSArray arrayWithObjects:p1,p2, nil];
    return [[DdFPadPadLine alloc]initWithId:@"mini" Ink:self.ink Points:points];
}
@end
