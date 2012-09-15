//
//  IconView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 9/3/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "IconView.h"

@implementation IconView
{
  NSImage *_image;
  BOOL _selected;
}
@synthesize btn;
- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc]
                                    initWithRect: frame
                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                    owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
  }
  
  return self;
}

- (void)enableDeleteBtn {
  [self.btn setEnabled:YES];
  [self.btn setHidden:NO];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  [self enableDeleteBtn];
}



- (void)cursorUpdate:(NSEvent *)event {
  [self enableDeleteBtn];
}

- (void)mouseExited:(NSEvent *)theEvent {
  [self.btn setEnabled:NO];
  [self.btn setHidden:YES];
}

- (void)setIcon:(NSImage *)image {
  // create the image somehow, load from file, draw into it...
  _image = image;
  [self setNeedsDisplay:YES];
//  NSRect rect = self.frame;
//  rect.origin = NSMakePoint(0, 0);
//  CALayer *imageLayer = [CALayer layer];
//  imageLayer.frame = NSMakeRect(0, 0, 50, 50);
//  imageLayer.contents = (id)[image CGImageForProposedRect:&rect context:nil hints:nil];
//  NSLog(@"set icon: %@", image);
//  
//  [self.layer.contents insertSublayer:imageLayer above:self.layer];
//  [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
  [_image drawInRect:[self bounds] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
}

#pragma mark selection
-(BOOL)selected {
  return _selected;
}

-(void)setSelected:(BOOL)sel {
  _selected = sel;
  [self setNeedsDisplay:YES];
}

@end
