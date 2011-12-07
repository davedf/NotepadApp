//
//  DdFPadPadColor.h
//  PadPad
//
//  Created by David de Florinier on 07/11/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DdFPadPadColor : NSObject
@property (readonly, strong) UIColor *color;

-(NSDictionary*)DdFJSONRepresentation;

+(DdFPadPadColor*)colorFromJSONRepresentation:(NSDictionary*)jsonDictionary;

+(DdFPadPadColor*)ivoryPaper;
+(DdFPadPadColor*)whitePaper;
+(DdFPadPadColor*)blackInk;
+(DdFPadPadColor*)blueInk;
+(DdFPadPadColor*)redInk;
+(DdFPadPadColor*)yellowHighlightInk;
+(DdFPadPadColor*)faintBlackInk;
+(DdFPadPadColor*)totalBlackInk;
@end
