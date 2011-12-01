//
//  DdFPadPadPenTool.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPenTool.h"
#import "DdFPadPadToolCoordinateAdaptor.h"
#import "DdFPadPadLineBuilder.h"
#import "DdFPadPadLine.h"
#import "DdFStringUtils.h"
#import "DdFPadPadInkDrawingItem.h"

#define GRANULARITY_MIN 20
#define GRANULARITY_MAX 200

@interface DdFPadPadPenTool()
-(void)drawCurrentLine;
@property (readonly) DdFPadPadLine *currentLine;
@end

@implementation DdFPadPadPenTool {
    DdFPadPadToolCoordinateAdaptor *_coordinateAdaptor;
    DdFPadPadLineBuilder *_lineBuilder;
    DdFPadPadPen *_pen;
}
@synthesize delegate=_delegate;

-(id)initWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate Pen:(DdFPadPadPen*)pen {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _coordinateAdaptor = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:delegate.pageView ToolView:delegate.pageView];
        _lineBuilder = [[DdFPadPadLineBuilder alloc]initWithGranularityMin:GRANULARITY_MIN WithGranularityMax:GRANULARITY_MAX];
        _pen = pen;
    }
    return self;
}

-(void)newGesture {
    DdFPadPadLine *newLine = [[DdFPadPadLine alloc]initWithId:[DdFStringUtils newStringWithUUID] Ink:_pen.ink Points:_lineBuilder.linePoints];
    [_delegate.page addLine:newLine];
    [_lineBuilder newLine];
    [_delegate pageRedrawRequired];
    [self drawCurrentLine];
}

-(void)touchAtPoint:(CGPoint)point WithVelocity:(CGPoint) velocity {
    CGPoint idealPoint = [_coordinateAdaptor convertToolViewPointToIdealPoint:point];
    CGPoint idealVelocity = [_coordinateAdaptor convertToolViewVelocityToIdealVelocity:velocity];
    [_lineBuilder addPoint:idealPoint WithVelocity:idealVelocity];
    [self drawCurrentLine];
}

-(DdFPadPadLine*)currentLine {
    return [[DdFPadPadLine alloc]initWithId:@"current" Ink:_pen.ink Points:_lineBuilder.linePoints];
}

-(void)drawCurrentLine {    
    DdFPadPadInkDrawingItem *drawingItem = [[DdFPadPadInkDrawingItem alloc]initWithLine:self.currentLine PointTransformer:_coordinateAdaptor.idealToToolViewTransform LineWidthScale:_coordinateAdaptor.idealToToolLineWidthScale];
    [_delegate.toolView draw:drawingItem];
    
}
@end
