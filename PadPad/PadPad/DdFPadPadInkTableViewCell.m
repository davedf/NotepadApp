//
//  DdFPadPadInkView.m
//  PadPad
//
//  Created by David de Florinier on 06/12/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import "DdFPadPadInkTableViewCell.h"

@implementation DdFPadPadInkTableViewCell
@synthesize inkView=_inkView;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self setBackgroundColor:[UIColor blueColor]];        
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
