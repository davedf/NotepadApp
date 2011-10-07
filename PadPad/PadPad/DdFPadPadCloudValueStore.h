//
//  DdFPadPadKeyValueStore.h
//  PadPad
//
//  Created by David de Florinier on 06/10/2011.
//  Copyright (c) 2011 de Florinier Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DdFPadPadCloudValueStore : NSObject

+(void)synchronize;
+(NSURL*)LastOpenedDocumentURL;
+(void)SetLastOpenedDocumentURL:(NSURL*)url;
@end
