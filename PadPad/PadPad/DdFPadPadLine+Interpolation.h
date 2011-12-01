//
//  DdFPadPadLine+Interpolation.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLine.h"
#import "DdFPadPadLinePoint.h"
@interface DdFPadPadLine (Interpolation)

-(void)genHermiteInterpolationToPoints:(CGPoint*)vertices Interpolated:(NSUInteger) interpolated;
-(NSUInteger)sizeAfterInterpolation:(NSUInteger) interpolated;
-(DdFPadPadLinePoint*)getMiDiaryLinePointForInterpolatedPointIndex:(NSUInteger)index Interpolated:(NSUInteger)interpolated;

@end
