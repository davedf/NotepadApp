//
//  DdFPadPadPenRepository.h
//  PadPad
//
//  Created by David de Florinier on 01/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadInk.h"
#import "DdFPadPadPen.h"

@interface DdFPadPadPenRepository : NSObject

@property (readonly,strong) DdFPadPadPen *pen;

+(DdFPadPadPenRepository*)sharedDdFPadPadPenRepository;
@end
