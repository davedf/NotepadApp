//
//  DdFPadPadApplicationState.m
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadApplicationState.h"
#import "DdFGCDSingleton.h"
@implementation DdFPadPadApplicationState

+(DdFPadPadApplicationState*)sharedDdFPadPadApplicationState {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });

}
@end
