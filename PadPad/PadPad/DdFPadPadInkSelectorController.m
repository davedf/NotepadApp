//
//  DdFPadPadInkSelectorController.m
//  PadPad
//
//  Created by David de Florinier on 06/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadInkSelectorController.h"
#import "DdFPadPadPenRepository.h"
#import "DdFPadPadInkTableViewCell.h"
#import "Log.h"
#import "DdFPadPadApplicationState.h"
@implementation DdFPadPadInkSelectorController

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 :  [DdFPadPadPenRepository sharedDdFPadPadPenRepository].inkNames.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - Table view delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadPenRepository *repo = [DdFPadPadPenRepository sharedDdFPadPadPenRepository];
    DdFPadPadInkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InkTypeCell"];
    if (indexPath.section == 0) {
        cell.inkView.ink = repo.pen.ink;
    }
    else {
        NSString *inkName = [repo.inkNames objectAtIndex:indexPath.row];
        cell.inkView.ink = [repo ink:inkName];
    }
    [cell setNeedsLayout];
    [cell.inkView setNeedsDisplay];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    
    TRACE(@"parentViewController class:%@", [self.parentViewController class]);
    TRACE(@"presentingViewController class:%@", [self.parentViewController.presentingViewController class]);
    DdFPadPadPenRepository *repo = [DdFPadPadPenRepository sharedDdFPadPadPenRepository];
    NSString *inkName = [repo.inkNames objectAtIndex:indexPath.row];
    if (inkName) {
        TRACE(@"selected ink:%@",inkName);
        repo.pen.ink = [repo ink:inkName];
    }
    [[DdFPadPadApplicationState sharedDdFPadPadApplicationState] hidePopover];
}

@end
