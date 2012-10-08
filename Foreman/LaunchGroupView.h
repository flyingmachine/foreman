#import <Cocoa/Cocoa.h>
@class LaunchGroupController;

@interface LaunchGroupView : NSView
@property (assign) IBOutlet LaunchGroupController *controller;
- (BOOL)selected;
- (void)setSelected:(BOOL)selected;
@end
