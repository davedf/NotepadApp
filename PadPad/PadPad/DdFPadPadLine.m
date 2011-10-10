#import "DdFPadPadLine.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadLinePoint.h"
#import "JSON.h"

#define INK_KEY @"ink"
#define POINTS_KEY @"points"

@interface DdFPadPadLine()
-(void)calculateBounds;

@end

@implementation DdFPadPadLine {
    DdFPadPadInk *_ink;
    NSArray *_points;
    CGRect _bounds;
    NSString *_lineId;
    BOOL _requiresBoundsCalculation;
}
@synthesize ink=_ink, points=_points,lineId=_lineId;

-(id)initWithId:(NSString*)lineId Ink:(DdFPadPadInk*)ink Points:(NSArray*)points {
    self = [super init];
    if (self) {
        _lineId = lineId;
        _ink = ink;
        _points = points;
        if (!_points) {
            _points = [NSArray array];
        }
        _requiresBoundsCalculation = YES;
    }
    return self;
}

-(void)addPoint:(DdFPadPadLinePoint*) point {
    _points = [_points arrayByAddingObject:point];
    _requiresBoundsCalculation = YES;
}

-(CGRect)bounds {
    if (_requiresBoundsCalculation) {
        [self calculateBounds];        
    }
    return _bounds;
}


#pragma mark - DdFPadPadLine()
-(void)calculateBounds {
    BOOL first = YES;
    CGFloat maxX = 0;
    CGFloat maxY = 0;
    CGFloat minX = 0;
    CGFloat minY = 0;
    for (DdFPadPadLinePoint *point in _points) {
        if (point.origin.x > maxX) {
            maxX = point.origin.x;
        }
        if (point.origin.y > maxY) {
            maxY = point.origin.y;
        }
        if (first) {
            first= NO;
            minX = point.origin.x;
            minY = point.origin.y;
        }
        else {
            if (point.origin.x < minX) {
                minX = point.origin.x;
            }
            if (point.origin.y < minY) {
                minY = point.origin.y;
            }
        }
    }
    _bounds = CGRectMake(minX, minY, maxX - minX, maxY - minY);    
    _requiresBoundsCalculation = NO;
}

-(NSArray*)PointsJSONArray {
    NSMutableArray *json = [[NSMutableArray alloc]initWithCapacity:self.points.count];
    for (DdFPadPadLinePoint *point in self.points) {
        [json addObject:[point DdFJSONRepresentation]];
    }
    return [NSArray arrayWithArray:json];
}
-(NSString*)DdFJSONRepresentation {
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                          [_ink InkJSONDictionary], INK_KEY, 
                          [self PointsJSONArray],POINTS_KEY,
                          nil];
    return [json JSONRepresentation];
}
-(NSFileWrapper*)NSFileWrapperRepresentation {
    NSString *json = [self DdFJSONRepresentation];
    NSData *data = [NSData dataWithBytes:[json UTF8String] length:[json length]];

    NSFileWrapper *wrapper = [[NSFileWrapper alloc]initRegularFileWithContents:data];
    [wrapper setPreferredFilename:[NSString stringWithFormat:@"%@.line",self.lineId]];
    return wrapper;
}

+(DdFPadPadLine*)lineFromNSFileWrapper:(NSFileWrapper*)wrapper {
    NSString *json = [[NSString alloc]initWithBytes:[wrapper.regularFileContents bytes] length:[wrapper.regularFileContents length] encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [json JSONValue];
    DdFPadPadInk *ink = [[DdFPadPadInk alloc]initWithJSONDictionary:[jsonDictionary objectForKey:INK_KEY]];
    return [[DdFPadPadLine alloc]initWithId:[wrapper.filename stringByReplacingOccurrencesOfString:@".line" withString:@""] Ink:ink Points:[DdFPadPadLine JSONArrayToPoints:[jsonDictionary objectForKey:POINTS_KEY]]];
}

+(NSArray*)JSONArrayToPoints:(NSArray*)jsonArray {
    NSMutableArray *points = [[NSMutableArray alloc]initWithCapacity:jsonArray.count];

    for (NSDictionary *pointDictionary in jsonArray) {
        [points addObject:[[DdFPadPadLinePoint alloc]initWithJSONRepresentation:pointDictionary]];
        
    }
    return [NSArray arrayWithArray:points];
}
@end
