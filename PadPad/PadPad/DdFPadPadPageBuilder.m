//
//  DdFPadPadPageBuilder.m
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPageBuilder.h"
#import "DdFGCDSingleton.h"
#import "DdFStringUtils.h"
#import "DdFPadPadPaperRepository.h"
#import "DdFPadPadPaper.h"

@implementation DdFPadPadPageBuilder
@synthesize selectedPaper=_selectedPaper;

-(id) initWithSelectedPaper:(DdFPadPadPaper*)selectedPaper {
    self = [super init];
    if (self) {
        self.selectedPaper = selectedPaper;
    }
    return self;
}
-(DdFPadPadPage*)pageWithPageNumber:(NSUInteger)pageNumber {
    NSLog(@"pageWithPageNumber:%d",pageNumber);
    return [[DdFPadPadPage alloc]initWithPaper:self.selectedPaper PageNumber:pageNumber Lines:[NSArray array] Identifier:[DdFStringUtils newStringWithUUID]];
}

+(id)sharedPageBuilder {
    
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        DdFPadPadPaper *paper = [[DdFPadPadPaperRepository sharedPaperRepository] defaultPaper]; 
        return [[self alloc] initWithSelectedPaper:paper];
    });
}
@end
