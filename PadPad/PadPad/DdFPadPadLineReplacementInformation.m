//
//  DdFPadPadLineReplacementInformation.m
//  PadPad
//
//  Created by David de Florinier on 03/01/2012.
//  Copyright (c) 2012 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadLineReplacementInformation.h"

@implementation DdFPadPadLineReplacementInformation
@synthesize toRemove=_toRemove,toAdd=_toAdd;

-(id)initWithLinestoRemove:(NSArray*)toRemove linesToAdd:(NSArray*)linesToAdd {
    self = [super init];
    if (self) {
        _toAdd = [NSArray arrayWithArray:toRemove];
        _toRemove = [NSArray arrayWithArray:toRemove];
    }
    return self;
}
@end
