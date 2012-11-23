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
  }
  
  return self;
}



- (void)mouseEntered:(NSEvent *)theEvent {
  [self.controller select];
}

- (void)mouseExited:(NSEvent *)theEvent {
  [self.controller deselect];
}

- (void)mouseDown:(NSEvent *)theEvent {
  
}

-(BOOL)selected {
  return _selected;
}

-(void)setSelected:(BOOL)sel {
  _selected = sel;
  [self setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)dirtyRect {
  if (_selected) {
    [[App colorWithHexColorString:@"b0cae6"] setFill];
  } else {
    [[NSColor colorWithCalibratedWhite:0.85 alpha:1.0f] setFill];
  }
  NSRectFill(dirtyRect);
}


@end
