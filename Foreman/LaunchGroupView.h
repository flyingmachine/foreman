#import <Cocoa/Cocoa.h>

@interface LaunchGroupView : NSView
- (void)shiftUp;
- (BOOL)selected;
- (void)setSelected:(BOOL)selected;
@end
