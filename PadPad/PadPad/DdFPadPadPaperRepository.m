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
#import "DdFPadPadPenRepository.h"
#define DEFAULT_PAPER CHECKED_IVORY_PAPER_BLACK_LINES
@implementation DdFPadPadPaperRepository {
    NSDictionary *_papers;
    NSArray *_sortedNames;
}

-(id)init {
    self = [super init];
    if (self) {
        DdFPadPadInk *blackInk =[[DdFPadPadPenRepository sharedDdFPadPadPenRepository]ink:INK_BLACK_FAINT_PAPER];
        DdFPadPadInk *heavyBlackInk =[[DdFPadPadPenRepository sharedDdFPadPadPenRepository]ink:INK_BLACK_HEAVY_PAPER];
        
        DdFPadPadPageLineInformation *blackCloseRuled = [[DdFPadPadPageLineInformation alloc] initWithLineInk:blackInk LineGap:30];
        DdFPadPadPageLineInformation *blackMinorRuled = [[DdFPadPadPageLineInformation alloc] initWithLineInk:blackInk LineGap:10 MajorLineInk:heavyBlackInk MajorLineInterval:12];
        
        DdFPadPadColor *ivoryPaper = [DdFPadPadColor ivoryPaper];
        DdFPadPadColor *whitePaper = [DdFPadPadColor whitePaper];
        
        _papers = [NSDictionary dictionaryWithObjectsAndKeys:
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:blackCloseRuled PaperColor:ivoryPaper],CHECKED_IVORY_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:blackCloseRuled PaperColor:whitePaper],CHECKED_WHITE_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackMinorRuled Vertical:blackMinorRuled PaperColor:ivoryPaper],MINOR_CHECKED_IVORY_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackMinorRuled Vertical:blackMinorRuled PaperColor:whitePaper],MINOR_CHECKED_WHITE_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:nil PaperColor:ivoryPaper],IVORY_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:blackCloseRuled Vertical:nil PaperColor:whitePaper],WHITE_PAPER_BLACK_LINES,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:nil Vertical:nil PaperColor:whitePaper],WHITE_PAPER,
                   [[DdFPadPadPaper alloc]initWithHoriziontal:nil Vertical:nil PaperColor:ivoryPaper],IVORY_PAPER,
                   nil];
        
        _sortedNames = [NSArray arrayWithObjects:
                        CHECKED_IVORY_PAPER_BLACK_LINES, 
                        CHECKED_WHITE_PAPER_BLACK_LINES,
                        MINOR_CHECKED_IVORY_PAPER_BLACK_LINES,
                        MINOR_CHECKED_WHITE_PAPER_BLACK_LINES,
                        IVORY_PAPER_BLACK_LINES,
                        WHITE_PAPER_BLACK_LINES,
                        IVORY_PAPER,
                        WHITE_PAPER,
                        nil];
    }
    return self;
}

-(NSArray*)paperNames {
    return _sortedNames;
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
