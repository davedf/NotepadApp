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
@implementation DdFPadPadInkSelectorController

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DdFPadPadPenRepository sharedDdFPadPadPenRepository].inkNames.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Table view delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadPenRepository *repo = [DdFPadPadPenRepository sharedDdFPadPadPenRepository];
    NSString *inkName = [repo.inkNames objectAtIndex:indexPath.row];
    DdFPadPadInk *ink = [repo ink:inkName];
    DdFPadPadInkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InkTypeCell"];
    DdFPadPadInkView *iv = cell.inkView;
    iv.ink = ink;
    [cell setNeedsLayout];
    [cell.inkView setNeedsDisplay];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadInkTableViewCell *tcell = (DdFPadPadInkTableViewCell*)cell;
    if (tcell.inkView.ink == [DdFPadPadPenRepository sharedDdFPadPadPenRepository].pen.ink) {
        [cell setSelected:YES];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    else {
        [cell setSelected:NO];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DdFPadPadPenRepository *repo = [DdFPadPadPenRepository sharedDdFPadPadPenRepository];
    NSString *inkName = [repo.inkNames objectAtIndex:indexPath.row];
    if (inkName) {
        TRACE(@"selected ink:%@",inkName);
        repo.pen.ink = [repo ink:inkName];
    }
}

@end
