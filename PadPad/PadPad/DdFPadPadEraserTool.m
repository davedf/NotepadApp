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
#import "DdFPadPadLineIntersectionResult.h"
#import "DdFPadPadLine+Intersection.h"
#import "DdFTimeSource.h"

@interface DdFPadPadEraserTool()
-(void)drawCurrentEraserState;
-(NSArray *) touchAtPoint:(CGPoint)point OnMiDiaryLineIntersectionResult:(DdFPadPadLineIntersectionResult*)intersection;
@end

@implementation DdFPadPadEraserTool {
    DdFPadPadToolCoordinateAdaptor *_coordinateAdaptor;
    CGPoint _lastIdealEraserPoint;
    DdfPadPadEraser *_eraser;
    NSDate *_eraseredLinesLastUpdated;
    NSMutableArray *_eraseredLines;
    NSMutableArray *_removedLines;
}

@synthesize delegate=_delegate;
-(id)initWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate Eraser:(DdfPadPadEraser*)eraser {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _coordinateAdaptor = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:delegate.pageView ToolView:delegate.toolView];
        _eraser = eraser;
        _eraseredLines = [NSMutableArray array];
        _removedLines = [NSMutableArray array];
    }
    return self;
}

#pragma mark - DdFPadPadDrawingTool()
-(void)newGesture {
    [self.delegate.page replaceLines:_removedLines WithNewLines:_eraseredLines undoManager:self.delegate.undoManager];
    [_eraseredLines removeAllObjects];
    [_removedLines removeAllObjects];
    [self drawCurrentEraserState];
    [_delegate pageRedrawRequired];

}

-(void)touchAtPoint:(CGPoint)point WithVelocity:(CGPoint) velocity {
    _lastIdealEraserPoint = [_coordinateAdaptor convertToolViewPointToIdealPoint:point];
    NSMutableArray *toAdd = [[NSMutableArray alloc] init] ;
    NSMutableArray *toRemove = [[NSMutableArray alloc] init] ;

    for (DdFPadPadLine *line in _eraseredLines) {
        DdFPadPadLineIntersectionResult *result = [line linesAfterIntersectionOfPoint:point WithRange:_eraser.size];
        if (result.erased) {
            [toRemove addObject:line];
            [toAdd addObjectsFromArray:[self touchAtPoint:point OnMiDiaryLineIntersectionResult:result]];
        }
    }
    if ([toRemove count] > 0 || [toAdd count] > 0) {
        _eraseredLinesLastUpdated = [DdFTimeSource time];
    }
    
    for (DdFPadPadLine *line in toRemove) {
        [_eraseredLines removeObject:line];
    }
    for (DdFPadPadLine *line in toAdd) {
        [_eraseredLines addObject:line];
    }
    [toAdd removeAllObjects];
    [toRemove removeAllObjects];
    
    for (DdFPadPadLine *line in _delegate.page.lines) {
        DdFPadPadLineIntersectionResult *result = [line linesAfterIntersectionOfPoint:point WithRange:_eraser.size];
        if (result.erased) {            
            [toRemove addObject:line];
            [toAdd addObjectsFromArray:[self touchAtPoint:point OnMiDiaryLineIntersectionResult:result]];
        }
    }
    
    if ([toAdd count] > 0) {
        _eraseredLinesLastUpdated = [DdFTimeSource time];
    }
    for (DdFPadPadLine *line in toRemove) {
        [_delegate.page removeLine:line.lineId];
    }
    for (DdFPadPadLine *line in toAdd) {
        [_eraseredLines addObject:line];
    }
    [self drawCurrentEraserState];
    if (toRemove.count > 0) {
        [_removedLines addObjectsFromArray:toRemove];
        [_delegate pageRedrawRequired];
    }
}

-(void)drawCurrentEraserState {
    DdFPadPadEraserDrawingItem *drawingItem = [[DdFPadPadEraserDrawingItem alloc]initWithPoint:_lastIdealEraserPoint size:_eraser.size PointTransformer:_coordinateAdaptor.idealToToolViewTransform LineWidthScale:_coordinateAdaptor.idealToToolLineWidthScale];
    [_delegate.toolView draw:drawingItem];
}

-(NSArray *) touchAtPoint:(CGPoint)point OnMiDiaryLineIntersectionResult:(DdFPadPadLineIntersectionResult*)intersection {
    NSMutableArray *out = [[NSMutableArray alloc] init];
    if (intersection.count > 0)  {
        
        DdFPadPadLineIntersectionResult *result = [intersection.line1 linesAfterIntersectionOfPoint:point WithRange:_eraser.size];
        if (result.erased) {
            [out addObjectsFromArray:[self touchAtPoint:point OnMiDiaryLineIntersectionResult:result]];
        }
        else {
            [out addObject:intersection.line1];
        }
    }
    if (intersection.count > 1) {
        DdFPadPadLineIntersectionResult *result = [intersection.line2 linesAfterIntersectionOfPoint:point WithRange:_eraser.size];
        if (result.erased) {
            [out addObjectsFromArray:[self touchAtPoint:point OnMiDiaryLineIntersectionResult:result]];
        }
        else {
            [out addObject:intersection.line2];
        }
    }
    return  out;
    
}
@end
