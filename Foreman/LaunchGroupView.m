//
//  AppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/31/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "LaunchGroupView.h"
#import "LaunchGroupController.h"
#import "Headers.h"
#define BORDER_WIDTH 3

@implementation LaunchGroupView
{
  BOOL _selected;
}

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc]
                                    initWithRect: frame
                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                    owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
    [self setLayer:[CALayer layer]];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [App unselectedLaunchGroupColor];
    [self.layer setNeedsDisplay];
  }
  
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  // set any NSColor for filling, say white:
  [[NSColor colorWithCalibratedWhite:1 alpha:0.8f] setFill];
  NSRectFill(dirtyRect);
}


- (void)mouseEntered:(NSEvent *)theEvent {
  [self.controller select];
}

- (void)mouseExited:(NSEvent *)theEvent {
  [self.controller deselect];
}

- (void)mouseDown:(NSEvent *)theEvent {
  
}

-(void)shiftUp {
  NSRect frameRect = self.frame;
  frameRect.origin.y += frameRect.size.height;
  self.frame = frameRect;
}

-(BOOL)selected {
  return _selected;
}

-(void)setSelected:(BOOL)sel {
  _selected = sel;
  if (_selected) {
    self.layer.backgroundColor = [App selectedLaunchGroupColor];
  } else {
    self.layer.backgroundColor = [App unselectedLaunchGroupColor];
  }
  [self.layer setNeedsDisplay];
}


@end
