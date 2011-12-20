//
//  DdFPadPadToolRepository.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadToolRepository.h"
#import "DdFPadPadPenToolBuilder.h"
#import "DdFPadPadEraserToolBuilder.h"
#import "DdFPadPadPenRepository.h"
#import "DdFPadPadEraserRepository.h"
#import "DdFGCDSingleton.h"
#import "Log.h"
@implementation DdFPadPadToolRepository {
    DdFPadPadPenToolBuilder *_penToolBuilder;
    DdFPadPadEraserToolBuilder *_eraserToolBuilder;
    NSMutableDictionary *_tools;
}
@synthesize selectedToolBuilder=_selectedToolBuilder;

-(id)init {
    self = [super init];
    if (self) {
        _penToolBuilder = [[DdFPadPadPenToolBuilder alloc]init];
        _penToolBuilder.pen = [[DdFPadPadPenRepository sharedDdFPadPadPenRepository] pen];
        _eraserToolBuilder = [[DdFPadPadEraserToolBuilder alloc]init];
        _eraserToolBuilder.eraser = [DdFPadPadEraserRepository sharedDdFPadPadEraserRepository].eraser;
        _selectedToolBuilder = _penToolBuilder;
        _tools = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(NSObject<DdFPadPadDrawingTool>*)newDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate {
    NSObject<DdFPadPadDrawingTool> *newTool = [_tools objectForKey:toolDelegate.page.pageLabel];
    if (!newTool) {
        newTool = [self.selectedToolBuilder newDrawingToolWithDelegate:toolDelegate];
        [_tools setObject:newTool forKey:toolDelegate.page.pageLabel];
    }    
    return newTool;
}

-(void)disposeDrawingToolForDelegate:(NSObject<DdFPadPadDrawingToolDelegate>*)toolDelegate {
    TRACE(@"disposeDrawingToolForDelegate:%@",toolDelegate.page.pageLabel);
    [_tools removeObjectForKey:toolDelegate.page.pageLabel];
}

-(NSObject<DdFPadPadDrawingToolBuilder>*)penToolBuilder {
    return _penToolBuilder;
}

-(NSObject<DdFPadPadDrawingToolBuilder>*)eraserToolBuilder {
    return _eraserToolBuilder;
}

+(DdFPadPadToolRepository*)sharedDdFPadPadToolRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });

}

@end
