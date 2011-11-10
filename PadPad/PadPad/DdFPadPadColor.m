//
//  DdFPadPadColor.m
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadColor.h"
#import "UIColor+DdFJSON.h"
#import "NSDictionary+DdFJSON.h"
#import "JSON.h"

@interface DdFPadPadColor()
-(id)initWithUIColor:(UIColor*)uiColor;
@end

@implementation DdFPadPadColor
@synthesize color=_color;
-(id)initWithUIColor:(UIColor*)uiColor {
    self = [super init];
    if (self) {
        _color = uiColor;
    }
    return self;
}

-(NSDictionary*)DdFJSONRepresentation {
    return [self.color DdFJSONDictionary];
}

-(BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    DdFPadPadColor *other = (DdFPadPadColor*)object;
    if (![self.color isEqual:other.color]) {
        return NO;
    }
    return YES;
}

-(NSString*)description {
    return [[self.color DdFJSONDictionary] JSONRepresentation]; 
}
+(DdFPadPadColor*)colorFromJSONRepresentation:(NSDictionary*)jsonDictionary {
    return [[DdFPadPadColor alloc]initWithUIColor:[jsonDictionary UIColorJSONValue]];
}

+(DdFPadPadColor*)ivoryPaper {
    return [[DdFPadPadColor alloc]initWithUIColor:[UIColor colorWithRed:0.933 green:0.933 blue:0.878 alpha:1]];
}

+(DdFPadPadColor*)whitePaper {
    return [[DdFPadPadColor alloc]initWithUIColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
}

+(DdFPadPadColor*)blackInk {
    return [[DdFPadPadColor alloc]initWithUIColor:[UIColor colorWithRed:0.278 green:0.278 blue:0.278 alpha:0.7]];    
}

+(DdFPadPadColor*)faintBlackInk {
    return [[DdFPadPadColor alloc]initWithUIColor:[UIColor colorWithRed:0.278 green:0.278 blue:0.278 alpha:0.5]];    
}

+(DdFPadPadColor*)totalBlackInk {
    return [[DdFPadPadColor alloc]initWithUIColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];    
}

@end
