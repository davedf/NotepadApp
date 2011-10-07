#import <Foundation/Foundation.h>

@interface NSMutableArray (DdFPadPadPageOrder)

-(NSData*)NSDataRepresentation;
-(NSFileWrapper*)NSFileWrapperRepresentation;

-(void)AddFromNSFileWrapper:(NSFileWrapper*)fileWrapper;

-(BOOL)recognises:(NSFileWrapper*)fileWrapper;
@end
