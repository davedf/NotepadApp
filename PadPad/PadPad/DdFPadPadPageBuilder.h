//
//  DdFPadPadPageBuilder.h
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DdFPadPadPaper.h"
#import "DdFPadPadPage.h"


@interface DdFPadPadPageBuilder : NSObject
@property (strong) DdFPadPadPaper *selectedPaper;
-(id) initWithSelectedPaper:(DdFPadPadPaper*)selectedPaper;
-(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber;
+(DdFPadPadPageBuilder*)sharedPageBuilder;
@end
