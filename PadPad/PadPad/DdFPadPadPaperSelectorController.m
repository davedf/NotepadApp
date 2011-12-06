//
//  DdFPadPadPaperSelectorController.m
//  PadPad
//
//  Created by David de Florinier on 09/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPaperSelectorController.h"
#import "DdFPadPadPaperRepository.h"
#import "DdFPadPadPaperTableViewCell.h"
#import "DdFPadPadApplicationState.h"
#import "DdFPadPadPageBuilder.h"
#import "Log.h"

@implementation DdFPadPadPaperSelectorController
@synthesize delegate=_delegate,selectedPaper=_selectedPaper;

#pragma mark - View lifecycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PaperToChange"]) {
        DdFPadPadPaperToChangeController *ctl = segue.destinationViewController;
        ctl.delegate = self;
    }
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DdFPadPadPaperRepository sharedPaperRepository].paperNames.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Table view delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadPaperRepository *repo = [DdFPadPadPaperRepository sharedPaperRepository];
    NSString *paperName = [repo.paperNames objectAtIndex:indexPath.row];
    DdFPadPadPaper *paper = [repo paperWithName:paperName];
    DdFPadPadPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaperTypeCell"];
    [cell.paperMiniView setPaperToShow:paper];
    [cell setNeedsLayout];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadPaperRepository *repo = [DdFPadPadPaperRepository sharedPaperRepository];
    NSString *paperName = [repo.paperNames objectAtIndex:indexPath.row];
    TRACE(@"selected paper:%@",paperName);
    self.selectedPaper = [repo paperWithName:paperName];
}


#pragma mark - DdFPadPadPaperSelectorControllerDelegate

-(void)DidSelectToChange:(NSString *)pagesToChange {
    TRACE(@"DidSelectToChange:%@",pagesToChange);
    DdFPadPadApplicationState *state = [DdFPadPadApplicationState sharedDdFPadPadApplicationState];
    [DdFPadPadPageBuilder sharedPageBuilder].selectedPaper = self.selectedPaper;
    if ([pagesToChange isEqualToString:LEFT_PAGE] | [pagesToChange isEqualToString:CURRENT_PAGE]) {
        [state.book changePaper:self.selectedPaper ForPages:[NSArray arrayWithObjects:state.leftPageController.dataObject, nil]];
        [state.leftPageController requiresRedraw];        
    }
    else if ([pagesToChange isEqualToString:RIGHT_PAGE]) {
        [state.book changePaper:self.selectedPaper ForPages:[NSArray arrayWithObjects:state.rightPageController.dataObject, nil]];
        [state.rightPageController requiresRedraw];                
    }
    else if ([pagesToChange isEqualToString:BOTH_PAGES]) {
        [state.book changePaper:self.selectedPaper ForPages:[NSArray arrayWithObjects:state.leftPageController.dataObject,state.rightPageController.dataObject, nil]];
        [state.leftPageController requiresRedraw];        
        [state.rightPageController requiresRedraw];                
        
    }
    else if ([pagesToChange isEqualToString:WHOLE_BOOK]) {
        [state.book changePaper:self.selectedPaper ForPages:nil];
        [state.leftPageController requiresRedraw];        
        [state.rightPageController requiresRedraw];                
        
    }
}
@end
