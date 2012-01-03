//
//  DdFPadPadLineReplacementInformation.h
//  PadPad
//
//  Created by David de Florinier on 03/01/2012.
//  Copyright (c) 2012 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DdFPadPadLineReplacementInformation : NSObject

-(id)initWithLinestoRemove:(NSArray*)toRemove linesToAdd:(NSArray*)linesToAdd;

@property (strong,readonly) NSArray *toRemove;
@property (strong,readonly) NSArray *toAdd;

@end
