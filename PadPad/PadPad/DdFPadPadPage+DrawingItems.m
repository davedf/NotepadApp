//
//  DdFPadPadPage+DrawingItems.m
//  PadPad
//
//  Created by David de Florinier on 05/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPage+DrawingItems.h"
#import "DdFPadPadLine.h"
#import "DdFPadPadInkDrawingItem.h"
#import "DdFPadPadToolCoordinateAdaptor.h"

@implementation DdFPadPadPage (DrawingItems)

-(NSArray /*<NSObject<DdFPadPadToolViewDrawingItem>*/ *)drawingItemsWithCoordinateAdaptor:(DdFPadPadToolCoordinateAdaptor*)coordinateAdaptor {
    NSMutableArray *items = [[NSMutableArray alloc]initWithCapacity:self.lines.count];
    CGAffineTransform idealToPageViewTransform = coordinateAdaptor.idealToPageViewTransform;
    CGFloat idealToToolLineWidthScale = coordinateAdaptor.idealToToolLineWidthScale;
    for (DdFPadPadLine *line in self.lines) {
        [items addObject:[[DdFPadPadInkDrawingItem alloc]initWithLine:line PointTransformer:idealToPageViewTransform LineWidthScale:idealToToolLineWidthScale]];
    }
    return [NSArray arrayWithArray:items];
}
@end
