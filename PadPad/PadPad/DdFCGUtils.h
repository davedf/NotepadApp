#import "JSON.h"
#import <UIKit/UIKit.h>

#define X_KEY @"x"
#define Y_KEY @"y"

static inline NSDictionary* CGPointToJSON(CGPoint point) {

    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithFloat:point.x],X_KEY, 
            [NSNumber numberWithFloat:point.y],Y_KEY, 
            nil];
}

static inline CGPoint CGPointFromJSON(NSDictionary *dictionary) {
    
    CGPoint point = CGPointMake([[dictionary objectForKey:X_KEY] floatValue], [[dictionary objectForKey:Y_KEY] floatValue]);
    return point;
}