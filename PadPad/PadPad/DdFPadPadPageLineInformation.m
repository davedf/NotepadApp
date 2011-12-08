#import "DdFPadPadPageLineInformation.h"
#import "DdFPadPadInk.h"
#import "JSON.h"
#define INK_KEY @"ink"
#define GAP_KEY @"gap"
#define MAJOR_LINE_INK_KEY @"mInk"
#define MAJOR_LINE_INTERVAL_KEY @"mInterval"

@implementation DdFPadPadPageLineInformation 
@synthesize lineInk=_lineInk,lineGap=_lineGap,majorLineInk=_majorLineInk,majorLineInterval=_majorLineInterval;

-(id)initWithLineInk:(DdFPadPadInk*)lineInk LineGap:(CGFloat)lineGap {
    return [self initWithLineInk:lineInk LineGap:lineGap MajorLineInk:nil MajorLineInterval:0];
}

-(id)initWithLineInk:(DdFPadPadInk*)lineInk LineGap:(CGFloat)lineGap MajorLineInk:(DdFPadPadInk*)majorLineInk MajorLineInterval:(NSUInteger)majorLineInterval {
    self = [super init];
    if (self) {
        _lineGap = lineGap;
        _lineInk = lineInk;
        _majorLineInterval = majorLineInterval;
        _majorLineInk = majorLineInk;
    }
    return self;
}

-(BOOL)hasMajorLines {
    return (_majorLineInterval > 0);
}

-(NSDictionary*)DdFJSONRepresentation {
    
    if (self.hasMajorLines) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [_lineInk InkJSONRepresentation],INK_KEY, 
                [NSNumber numberWithFloat:_lineGap],GAP_KEY,
                [_majorLineInk InkJSONRepresentation],MAJOR_LINE_INK_KEY, 
                [NSNumber numberWithInt:_majorLineInterval],MAJOR_LINE_INTERVAL_KEY,
                nil];
    }
    else {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [_lineInk InkJSONRepresentation],INK_KEY, 
                [NSNumber numberWithFloat:_lineGap],GAP_KEY,
                nil];        
    }
    return nil;
}

-(NSString*)description {
    return [[self DdFJSONRepresentation]JSONRepresentation];
}
-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadPageLineInformation *other = (DdFPadPadPageLineInformation*)object;
    if (self.lineGap != other.lineGap) {
        return  NO;
    }
    if (self.majorLineInterval != other.majorLineInterval) {
        return NO;
    }
    if (![self.lineInk isEqual:other.lineInk]) {
        return NO;
    }
    if (self.majorLineInk) {
        if (![self.majorLineInk isEqual:other.majorLineInk]) {
            return NO;
        }
    }
    else {
        if (other.majorLineInk) {
            return NO;
        }
    }
    return YES;
}
+(DdFPadPadPageLineInformation*)pageLineInformationWithJSONRepresentation:(NSDictionary*)jsonRepresentation {
    DdFPadPadInk *lineInk = [DdFPadPadInk inkFromJson:[jsonRepresentation objectForKey:INK_KEY]];
    DdFPadPadInk *majorLineInk = nil;
    NSString *majorInkDictionary = [jsonRepresentation objectForKey:MAJOR_LINE_INK_KEY];
    if (majorInkDictionary ) {
        majorLineInk = [DdFPadPadInk inkFromJson:majorInkDictionary];
    }
    CGFloat lineGap = [[jsonRepresentation objectForKey:GAP_KEY] floatValue];
    NSUInteger majorLineInterval = [[jsonRepresentation objectForKey:MAJOR_LINE_INTERVAL_KEY] intValue];
    return [[DdFPadPadPageLineInformation alloc]initWithLineInk:lineInk LineGap:lineGap MajorLineInk:majorLineInk MajorLineInterval:majorLineInterval];
}
@end
