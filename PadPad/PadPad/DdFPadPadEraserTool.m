//
//  DdFPadPadEraserTool.m
//  PadPad
//
//  Created by David de Florinier on 15/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadEraserTool.h"
#import "DdFPadPadToolCoordinateAdaptor.h"
#import "DdFPadPadEraserDrawingItem.h"

@interface DdFPadPadEraserTool()
-(void)drawCurrentEraserState;
@end

@implementation DdFPadPadEraserTool {
    DdFPadPadToolCoordinateAdaptor *_coordinateAdaptor;
    CGPoint _lastIdealEraserPoint;
    DdfPadPadEraser *_eraser;
}
@synthesize delegate=_delegate;
-(id)initWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate Eraser:(DdfPadPadEraser*)eraser {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _coordinateAdaptor = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:delegate.pageView ToolView:delegate.toolView];
        _eraser = eraser;
    }
    return self;
}

#pragma mark - DdFPadPadDrawingTool()
-(void)newGesture {
    [_delegate.toolView draw:nil];
    
}
-(void)touchAtPoint:(CGPoint)point WithVelocity:(CGPoint) velocity {
    _lastIdealEraserPoint = [_coordinateAdaptor convertToolViewPointToIdealPoint:point];
    [self drawCurrentEraserState];
}

-(void)drawCurrentEraserState {
    DdFPadPadEraserDrawingItem *drawingItem = [[DdFPadPadEraserDrawingItem alloc]initWithPoint:_lastIdealEraserPoint size:_eraser.size PointTransformer:_coordinateAdaptor.idealToToolViewTransform LineWidthScale:_coordinateAdaptor.idealToToolLineWidthScale];
    [_delegate.toolView draw:drawingItem];
}
@end
