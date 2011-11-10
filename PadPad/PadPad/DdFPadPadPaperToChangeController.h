//
//  DdFPadPadPaperToChangeController.h
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WHOLE_BOOK @"WholeBookCell"
#define CURRENT_PAGE @"CurrentPageCell"
#define BOTH_PAGES @"BothPagesCell"
#define LEFT_PAGE @"LeftPageCell"
#define RIGHT_PAGE @"RightPageCell"

@protocol DdFPadPadPaperToChangeControllerDelegate <NSObject>
-(void) DidSelectToChange:(NSString*)pagesToChange;
@end

@interface DdFPadPadPaperToChangeController : UITableViewController
@property (weak) NSObject<DdFPadPadPaperToChangeControllerDelegate> *delegate;


@end

