//
//  DdFPadPadSplashScreenController.m
//  PadPad
//
//  Created by David de Florinier on 25/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadSplashScreenController.h"
#import "DdFPadPadBook.h"
#import "DdFPadPadBookRepository.h"
#import "DdfPadPadRootViewController.h"
#import "Log.h"
@interface DdFPadPadSplashScreenController()
-(void)bookDidfinishLoading:(DdFPadPadBook*)book;
-(void)loadBook;
@end

@implementation DdFPadPadSplashScreenController
@synthesize splashScreen=_splashScreen;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImage *bgImage = [UIImage imageNamed:@"tabletop"];
//    UIColor *bgColor = [UIColor colorWithPatternImage:bgImage];
//    [self.view setBackgroundColor:bgColor];
    
    
    [self.splashScreen setImage:[UIImage imageNamed:@"Default-Portrait"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(loadBook) withObject:nil afterDelay:2];
    
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
-(void)loadBook {
    __block DdFPadPadBook *book =[[DdFPadPadBookRepository sharedRepository] openDefaultBookWithDelegate:nil CompletionHandler:^(BOOL success) {
        
        [self bookDidfinishLoading:book];
        TRACE(@"book loaded:%@",success?@"Y":@"N");
    }];

}
-(void)bookDidfinishLoading:(DdFPadPadBook*)book {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DdfPadPadRootViewController *rootController = (DdfPadPadRootViewController*)  [storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    rootController.book = book;
    [self.view.window setRootViewController:rootController];
    
}

@end
