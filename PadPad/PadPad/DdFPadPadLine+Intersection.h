//
//  DdFPadPadLine+Intersection.h
//  PadPad
//
//  Created by David de Florinier on 03/01/2012.
//  Copyright (c) 2012 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLine.h"
#import "DdFCGUtils.h"
#import "DdFPadPadLineIntersectionResult.h"

@interface DdFPadPadLine (Intersection)

-(DdFPadPadLineIntersectionResult*) linesAfterIntersectionOfPoint:(CGPoint )point WithRange:(CGFloat)range;
-(DdFPadPadLineIntersectionResult*)tryEraseEndOfLine:(NSArray *) line WithCircle:(Circle )c Reverse:(BOOL ) reverse;

@end
