//
//  DdFPadPadEraserTool.m
//  PadPad
//
//  Created by David de Florinier on 15/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadEraserTool.h"
#import "DdFPadPadToolCoordinateAdaptor.h"

@implementation DdFPadPadEraserTool {
    DdFPadPadToolCoordinateAdaptor *_coordinateAdaptor;

}
@synthesize delegate=_delegate;
-(id)initWithDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _coordinateAdaptor = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:delegate.pageView ToolView:delegate.toolView];
    }
    return self;
}

#pragma mark - DdFPadPadDrawingTool()
-(void)newGesture {
    
}
-(void)touchAtPoint:(CGPoint)point WithVelocity:(CGPoint) velocity {
    
}

@end
