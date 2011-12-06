//
//  DdFPadPadPen.m
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPen.h"

@implementation DdFPadPadPen
@synthesize ink=_ink;

-(id)copy {
    DdFPadPadPen *newPen = [[DdFPadPadPen alloc]init];
    newPen.ink = [_ink copy];
    return newPen;
}
@end
