//
//  DdFPadPadToolCoordinateAdaptor.h
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DdFPadPadToolCoordinateAdaptor : NSObject

@property (readonly) CGSize idealSize;
@property (readonly) CGAffineTransform idealToToolViewTransform;
@property (readonly) CGAffineTransform idealToPageViewTransform;
@property (readonly) CGFloat idealToToolLineWidthScale;
-(id)initWithPageView:(UIView*)pageView ToolView:(UIView*)toolView;

-(CGPoint)convertToolViewPointToIdealPoint:(CGPoint)toolViewPoint;
-(CGPoint)convertToolViewVelocityToIdealVelocity:(CGPoint)toolViewPoint;
-(CGPoint)convertIdealPointToToolViewPoint:(CGPoint)idealViewPoint;
-(CGPoint)convertIdealPointToPageViewPoint:(CGPoint)idealViewPoint;

@end
