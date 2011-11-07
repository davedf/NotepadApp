//
//  DdFPadPadPaperRepositoryTests.m
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPaperRepositoryTests.h"
#import "DdFPadPadPaper.h"
#import "DdFPadPadPaperRepository.h"

@implementation DdFPadPadPaperRepositoryTests

-(void)testDefaultPaper {
    DdFPadPadPaper *result = [[DdFPadPadPaperRepository sharedPaperRepository] defaultPaper];
    STAssertNotNil(result, @"Fail");
    DdFPadPadPaper *expected = [[DdFPadPadPaperRepository sharedPaperRepository] paperWithName:CHECKED_IVORY_PAPER_BLACK_LINES];
    STAssertEqualObjects(result, expected, @"Fail");
}


@end
