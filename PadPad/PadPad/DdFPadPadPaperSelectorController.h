//
//  DdFPadPadPaperSelectorController.h
//  PadPad
//
//  Created by David de Florinier on 09/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DdfPadPadDataViewController.h"
#import "DdFPadPadBook.h"
#import "DdFPadPadPaperToChangeController.h"

@protocol DdFPadPadPaperSelectorControllerDelegate <NSObject>

@property (readonly) DdfPadPadDataViewController *leftPageController;
@property (readonly) DdfPadPadDataViewController *rightPageController;
@property (readonly) DdFPadPadBook *book;

@end

@interface DdFPadPadPaperSelectorController : UITableViewController<DdFPadPadPaperToChangeControllerDelegate>
@property (strong) DdFPadPadPaper *selectedPaper;
@property (weak) NSObject<DdFPadPadPaperSelectorControllerDelegate> *delegate;
@end
