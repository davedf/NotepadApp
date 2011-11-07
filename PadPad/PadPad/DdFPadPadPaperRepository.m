//
//  DdFPadPadPaperRepository.m
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPaperRepository.h"
#import "DdFGCDSingleton.h"
#import "DdFPadPadInk.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadColor.h"
#import "DdFPadPadPageLineInformation.h"

#define DEFAULT_PAPER CHECKED_IVORY_PAPER_BLACK_LINES
@implementation DdFPadPadPaperRepository {
    NSDictionary *_papers;
}

-(id)init {
    self = [super init];
    if (self) {
        DdFPadPadInk *blackInk =[[DdFPadPadInk alloc]initWithColor:[DdFPadPadColor blackInk] Size:2 Type:kFeltTip ];
        
        DdFPadPadPageLineInformation *blackCloseRuled = [[DdFPadPadPageLineInformation alloc] initWithLineInk:blackInk LineGap:10];
        
        DdFPadPadColor *ivoryPaper = [DdFPadPadColor ivoryPaper];
        
        _papers = [NSDictionary dictionaryWithObjectsAndKeys:
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:blackCloseRuled PaperColor:ivoryPaper],CHECKED_IVORY_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:nil PaperColor:ivoryPaper],IVORY_PAPER_BLACK_LINES,
                   nil];
    }
    return self;
}

-(NSArray*)paperNames {
    return [_papers allKeys];
}
-(DdFPadPadPaper*)defaultPaper {
    return [self paperWithName:DEFAULT_PAPER];
}

-(DdFPadPadPaper*)paperWithName:(NSString *)paperName {
    return [_papers objectForKey:paperName];
}

+(DdFPadPadPaperRepository*)sharedPaperRepository {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
@end
