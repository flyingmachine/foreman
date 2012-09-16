#import <Cocoa/Cocoa.h>
@class LaunchGroupController;

@interface LaunchGroupView : NSView
@property (assign) IBOutlet LaunchGroupController *controller;
- (void)shiftUp;
- (BOOL)selected;
- (void)setSelected:(BOOL)selected;
@end
