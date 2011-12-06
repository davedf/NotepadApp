//
//  DdFPadPadLineBuilder.m
//  PadPad
//
//  Created by David de Florinier on 30/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#pragma mark - utility structs & functions
struct CGPointChecked {
    CGPoint convertedPoint;
    BOOL tooClose;
    BOOL tooFar;
};

typedef struct CGPointChecked CGPointChecked;

static CGPointChecked CGPointCheckedMake(BOOL tooClose, BOOL tooFar, CGPoint converted) {
    CGPointChecked result;
    result.convertedPoint = converted;
    result.tooClose = tooClose;
    result.tooFar = tooFar;
    return result;
}

#import "DdFPadPadLineBuilder.h"
#import "DdFCGUtils.h"
#import "DdFPadPadLinePoint.h"
#import "Log.h"

@interface DdFPadPadLineBuilder()
-(CGPointChecked)validateAndConvertPoint:(CGPoint)point;
-(void)addCheckedPoint:(CGPointChecked)point WithVelocity:(CGPoint) velocity;
@end

@implementation DdFPadPadLineBuilder {
    CGFloat                                 _granularityMin,_granularityMax;
    NSMutableArray /*<MiDiaryLinePoint>*/ *_linePoints;
    CGPoint                                 _previousPoint;
    BOOL                                    _lastPointIsFinal;

}
@synthesize linePoints=_linePoints;

-(id)initWithGranularityMin:(CGFloat)granularityMin WithGranularityMax:(CGFloat)granularityMax {
    self = [super init];
    if (self) {
        _granularityMax = granularityMax;
        _granularityMin = granularityMin;
        _linePoints = [[NSMutableArray alloc]init];
        _lastPointIsFinal = YES;
    }
    return self;
}
-(void)addPoint:(CGPoint)point WithVelocity:(CGPoint) velocity {
    CGPointChecked checked = [self validateAndConvertPoint:point];
    if (checked.tooFar) {
        return;
    }
    [self addCheckedPoint:checked WithVelocity:velocity]; 
}
-(void)newLine {
    TRACE(@"new Line");
    _linePoints = [[NSMutableArray alloc]init];
    _lastPointIsFinal = YES;    
}

#pragma mark - DdFPadPadLineBuilder()

-(CGPointChecked)validateAndConvertPoint:(CGPoint)point {
    if ([_linePoints count] == 0) {
        return CGPointCheckedMake(NO,NO, point);
    }
    CGFloat distanceFromLastpoint = CGPointDistance(_previousPoint, point);
    return CGPointCheckedMake(distanceFromLastpoint < _granularityMin ,distanceFromLastpoint > _granularityMax , point);
}

-(void)addCheckedPoint:(CGPointChecked)point WithVelocity:(CGPoint) velocity {
    
    DdFPadPadLinePoint *pointToStore = [[DdFPadPadLinePoint alloc]initWithOrigin:point.convertedPoint velocity:velocity];
    if (!_lastPointIsFinal) {
        [_linePoints removeLastObject];
    }
    [_linePoints addObject:pointToStore];        
    if (!point.tooClose) {
        _previousPoint = point.convertedPoint;
        _lastPointIsFinal = YES;
    }
    else {
        _lastPointIsFinal = NO;
    }
}
@end
