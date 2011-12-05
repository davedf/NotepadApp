//
//  DdFPadPadPage+DrawingItems.h
//  PadPad
//
//  Created by David de Florinier on 05/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPage.h"
@class DdFPadPadToolCoordinateAdaptor;
@interface DdFPadPadPage (DrawingItems)
-(NSArray /*<NSObject<DdFPadPadToolViewDrawingItem>*/ *)drawingItemsWithCoordinateAdaptor:(DdFPadPadToolCoordinateAdaptor*)coordinateAdaptor;

@end
