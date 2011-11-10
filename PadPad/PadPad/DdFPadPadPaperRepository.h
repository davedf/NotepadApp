//
//  DdFPadPadPaperRepository.h
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadPaper.h"

#define CHECKED_IVORY_PAPER_BLACK_LINES @"checked ivory black lines"
#define CHECKED_WHITE_PAPER_BLACK_LINES @"checked white black lines"

#define IVORY_PAPER_BLACK_LINES @"unchecked ivory black lines"
#define WHITE_PAPER_BLACK_LINES @"unchecked white black lines"

#define IVORY_PAPER @"ivory"
#define WHITE_PAPER @"white"

@interface DdFPadPadPaperRepository : NSObject
@property (readonly) DdFPadPadPaper *defaultPaper;
@property (readonly,strong) NSArray *paperNames;

-(DdFPadPadPaper*)paperWithName:(NSString*)paperName;


+(DdFPadPadPaperRepository*)sharedPaperRepository;
@end
