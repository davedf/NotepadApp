//
//  DdFPadPadPaperToChangeController.m
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadPaperToChangeController.h"
#import "Log.h"

@interface DdFPadPadPaperToChangeController()
@property (readonly) NSArray *options;

@end

@implementation DdFPadPadPaperToChangeController {
    NSArray *_landscape;
    NSArray *_portrait;
    UIInterfaceOrientation _orientation;
}

@synthesize delegate=_delegate;

-(NSArray*)options {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        return _portrait;
    }       
    return _landscape;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _orientation = [[UIApplication sharedApplication] statusBarOrientation];

    _portrait = [NSArray arrayWithObjects:WHOLE_BOOK,CURRENT_PAGE, nil];
    _landscape = [NSArray arrayWithObjects:WHOLE_BOOK,BOTH_PAGES,LEFT_PAGE,RIGHT_PAGE, nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}


-(void)orientationChanged:(id)sender {
    TRACE(@"orientationChanged");
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    if (orientation == _orientation) {
        return;
    }
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
    _orientation = [[UIApplication sharedApplication] statusBarOrientation];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self.options objectAtIndex:indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self.options objectAtIndex:indexPath.row];
    TRACE(@"selected:%@",cellIdentifier);
    [self.delegate DidSelectToChange:cellIdentifier];
}

@end
