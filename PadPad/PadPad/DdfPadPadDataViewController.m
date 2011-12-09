#import "DdfPadPadDataViewController.h"
#import "DdFPadPadPage.h"
#import "DdFPadPadPageView.h"
#import "DdFPadPadViewContants.h"
#import "DdFCGUtils.h"
#import "DdFPadPadToolView.h"
#import "DdFPadPadDrawingTool.h"
#import "DdFPadPadToolRepository.h"
#import "Log.h"
#import "DdFPadPadApplicationState.h"
#import "DdFPadPadBook.h"
@interface DdfPadPadDataViewController()
//@property (readonly) DdFPadPadPageView *pageView;
-(void)sizeInkView;
@end

@implementation DdfPadPadDataViewController {
    DdFPadPadToolCoordinateAdaptor *_coordinateAdaptor;
    NSObject<DdFPadPadDrawingTool> *_drawingTool;
}

@synthesize dataLabel=_dataLabel,dataObject=_dataObject,inkView=_inkView,panGestureRecogniser=_panGestureRecogniser;

#pragma mark - View lifecycle

-(id)initWithCoder:(NSCoder *)aDecoder {
    TRACE(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        _panGestureRecogniser = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(inkPanned:)];    
        _panGestureRecogniser.delaysTouchesBegan = YES;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TRACE(@"dataObject:%@",self.dataObject);
    self.dataLabel.text = self.dataObject.pageLabel;
    [self.pageView showPage:self.dataObject];
    [self.inkView setBackgroundColor:[UIColor clearColor]];
    [self.inkView addGestureRecognizer:_panGestureRecogniser];
    _coordinateAdaptor = [[DdFPadPadToolCoordinateAdaptor alloc]initWithPageView:self.pageView ToolView:self.inkView];
    _drawingTool = [[DdFPadPadToolRepository sharedDdFPadPadToolRepository] newDrawingToolForDelegate:self];
    self.pageView.coordinateAdaptor = _coordinateAdaptor;
//    [self.inkView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

-(void)viewDidAppear:(BOOL)animated {
    [self sizeInkView];
}

-(void)sizeInkView {
    self.inkView.frame = DrawableFrameInContainingFrame(self.pageView.frame);
    CGRectLog(@"inkView", self.inkView.frame);
    CGRectLog(@"pageView", self.pageView.frame);    
}

-(IBAction)inkPanned:(id)sender {
    if (sender != _panGestureRecogniser) {
        return;
    }
    
    UIGestureRecognizerState state = _panGestureRecogniser.state;
    CGPoint point = [_panGestureRecogniser locationInView:self.inkView];
    CGPoint velocity = [_panGestureRecogniser velocityInView:self.inkView];
    [_drawingTool touchAtPoint:point WithVelocity:velocity];

    if (state == UIGestureRecognizerStateEnded) {
        [_drawingTool newGesture];
    }
}
                                       
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {        
    [self.pageView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];    
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self sizeInkView];
    TRACE(@"didRotateFromInterfaceOrientation size height:%f width:%f",self.view.frame.size.height,self.view.frame.size.width);
}

#pragma mark - DdfPadPadDataViewController() 
-(DdFPadPadPageView*)pageView {
    return (DdFPadPadPageView*)self.view;
}

-(void)requiresRedraw {
    [self.pageView requiresRedraw];
}

#pragma DdFPadPadDrawingToolDelegate()
-(DdFPadPadToolCoordinateAdaptor*)coordinateAdaptor {
    return _coordinateAdaptor;
}

-(DdFPadPadToolView*)toolView {
    return self.inkView;
}

-(DdFPadPadPage*)page {
    return self.dataObject;
}

-(void)pageRedrawRequired {
    [self.pageView requiresRedraw];
}

-(NSUndoManager*)undoManager {
    return [DdFPadPadApplicationState sharedDdFPadPadApplicationState].book.undoManager;
}
@end
