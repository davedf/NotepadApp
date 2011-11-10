//
//  DdFPadPadPaperView.h
//  PadPad
//
//  Created by David de Florinier on 10/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DdFPadPadPaper.h"

@interface DdFPadPadPaperView : UIView
@property (readonly,strong) DdFPadPadPaper *paper;

-(void)setPaperToShow:(DdFPadPadPaper *)paper;
@end
