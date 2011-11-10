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


@implementation DdFPadPadPaperSelectorController
@synthesize delegate=_delegate,selectedPaper=_selectedPaper;

#pragma mark - View lifecycle

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DdFPadPadPaperRepository sharedPaperRepository].paperNames.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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
    NSLog(@"selected paper:%@",paperName);
    self.selectedPaper = [repo paperWithName:paperName];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PaperToChange"]) {
        DdFPadPadPaperToChangeController *ctl = segue.destinationViewController;
        ctl.delegate = self;
    }
}

#pragma mark - DdFPadPadPaperSelectorControllerDelegate
-(void)DidSelectToChange:(NSString *)pagesToChange {
    NSLog(@"DidSelectToChange:%@",pagesToChange);
}
@end
