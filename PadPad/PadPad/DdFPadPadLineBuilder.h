//
//  DdFPadPadLineBuilder.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DdFPadPadLineBuilder : NSObject

-(id)initWithGranularityMin:(CGFloat)granularityMin WithGranularityMax:(CGFloat)granularityMax;
-(void)addPoint:(CGPoint)point WithVelocity:(CGPoint) velocity;
-(void)newLine;

@property (readonly) NSArray /*<DdFPadPadLinePoint>*/ *linePoints;

@end
