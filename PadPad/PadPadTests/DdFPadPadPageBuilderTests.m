//
//  DdFPadPadPageBuilderTests.m
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPageBuilderTests.h"
#import "DdFPadPadPageBuilder.h"
#import "DdFPadPadPaperRepository.h"

@implementation DdFPadPadPageBuilderTests

-(void)testShared {
    DdFPadPadPageBuilder *once= [DdFPadPadPageBuilder sharedPageBuilder];
    DdFPadPadPageBuilder *twice= [DdFPadPadPageBuilder sharedPageBuilder];
    
    STAssertEqualObjects(once.selectedPaper, [[DdFPadPadPaperRepository sharedPaperRepository] defaultPaper], @"Fail");
    STAssertEquals(once, twice, @"Fail");
    
    DdFPadPadPaper *currentPaper = once.selectedPaper;
    DdFPadPadPaper *newPaper = [[DdFPadPadPaperRepository sharedPaperRepository] paperWithName:IVORY_PAPER_BLACK_LINES];
    STAssertFalse([currentPaper isEqual:newPaper], @"Fail");
    once.selectedPaper = newPaper;
    
    STAssertEqualObjects(twice.selectedPaper, newPaper, @"Fail");
    
    once.selectedPaper = currentPaper;
}

-(void)testPageHasCorrectPageNumber {
    DdFPadPadPage *page = [[DdFPadPadPageBuilder sharedPageBuilder] pageWithPageNumber:1 Paper:nil];
    STAssertEquals((NSUInteger)1,page.pageNumber,@"Fail");
    page = [[DdFPadPadPageBuilder sharedPageBuilder] pageWithPageNumber:2  Paper:nil];
    STAssertEquals((NSUInteger)2,page.pageNumber,@"Fail");
}

-(void)testPageHasIdentifier {
    DdFPadPadPage *page = [[DdFPadPadPageBuilder sharedPageBuilder] pageWithPageNumber:1  Paper:nil];
    STAssertNotNil(page.identifier, @"Fail");
}

-(void)testPageHasCurrentlySelectedPaper {
    DdFPadPadPage *page = [[DdFPadPadPageBuilder sharedPageBuilder] pageWithPageNumber:1  Paper:nil];
    STAssertEqualObjects(page.paper, [[DdFPadPadPageBuilder sharedPageBuilder] selectedPaper], @"Fail");
}
@end
