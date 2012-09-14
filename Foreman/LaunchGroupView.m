//
//  AppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/31/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "LaunchGroupView.h"
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
  self.selected = YES;
}

- (void)mouseExited:(NSEvent *)theEvent {
  self.selected = NO;
}

- (void)mouseDown:(NSEvent *)theEvent {
  
}


- (void)drawRect:(NSRect)dirtyRect
{
  if (self.selected) {
    [self rk_drawPatternImage:[NSColor colorWithPatternImage:[NSImage imageNamed:@"app-group-bg-highlighted.png"]] inRect:self.bounds];
  } else {
    [self rk_drawPatternImage:[NSColor colorWithPatternImage:[NSImage imageNamed:@"app-group-bg.png"]] inRect:self.bounds];
  }
}

- (void)rk_drawPatternImage:(NSColor*)patternColor inRect:(NSRect)rect
{
  [self rk_drawPatternImage:patternColor inBezierPath:[NSBezierPath bezierPathWithRect:rect]];
}

- (void)rk_drawPatternImage:(NSColor*)patternColor inBezierPath:(NSBezierPath*)path
{
  [NSGraphicsContext saveGraphicsState];
  
  CGFloat yOffset = 65;
  CGFloat xOffset = 65;
  [[NSGraphicsContext currentContext] setPatternPhase:NSMakePoint(xOffset, yOffset)];
  
  [patternColor set];
  [path fill];
  [NSGraphicsContext restoreGraphicsState];
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
  [self setNeedsDisplay:YES];
}


@end
