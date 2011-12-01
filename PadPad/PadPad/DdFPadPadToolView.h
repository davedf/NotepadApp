//
//  DdFPadPadToolView.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DdFPadPadToolViewDrawingItem.h"

@interface DdFPadPadToolView : UIView


-(void)draw:(NSObject<DdFPadPadToolViewDrawingItem>*)drawingItem;
@end
