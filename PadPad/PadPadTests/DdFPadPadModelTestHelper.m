#import "DdFPadPadModelTestHelper.h"
#import "JSON.h"

@implementation DdFPadPadModelTestHelper

+(DdFPadPadInk*)ink  {
    return [[DdFPadPadInk alloc]initWithColorRed:1 Green:1 Blue:1 Alpha:1 Size:2 Type:kFeltTip];
}
+(DdFPadPadLine*)line {
    return [[DdFPadPadLine alloc]initWithId:@"foo" Ink:[DdFPadPadModelTestHelper ink] Points:[NSArray array]];

}
+(DdFPadPadLine*)lineWithPoints {
    DdFPadPadLine *line = [DdFPadPadModelTestHelper line];
    [line addPoint:[DdFPadPadModelTestHelper point:CGPointMake(1, 1)]];
    [line addPoint:[DdFPadPadModelTestHelper point:CGPointMake(2, 2)]];
    return line;
}
+(DdFPadPadLinePoint*)point:(CGPoint)point; {
    return [[DdFPadPadLinePoint alloc]initWithOrigin:point  velocity:CGPointMake(1, 1)];
}

+(DdFPadPadPaper*)paper {
    DdFPadPadPageLineInformation *h = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_MAJOR_LINES JSONValue]];
    DdFPadPadPageLineInformation *v = [DdFPadPadPageLineInformation pageLineInformationWithJSONRepresentation:[JSON_NO_MAJOR_LINES JSONValue]];
    
    return [[DdFPadPadPaper alloc]initWithHoriziontal:h Vertical:v];

}
@end
