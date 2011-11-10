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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIImage *bgImage = [UIImage imageNamed:@"tabletop"];
//    UIColor *bgColor = [UIColor colorWithPatternImage:bgImage];
//    [self.view setBackgroundColor:bgColor];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

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


@end
