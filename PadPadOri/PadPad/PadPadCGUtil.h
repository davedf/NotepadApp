#import <UIKit/UIKit.h>

static inline NSString* CGSizeToString(CGSize size) {
    return [NSString stringWithFormat:@"[%f,%f]",size.width,size.height];
}

static inline NSString* CGPointToString(CGPoint point) {
    return [NSString stringWithFormat:@"[%f,%f]",point.x,point.y];
}

static inline NSString* CGRectToString(CGRect rec) {
    return [NSString stringWithFormat:@"[origin:%@ size:%@]",CGPointToString(rec.origin),CGSizeToString(rec.size)];
}



