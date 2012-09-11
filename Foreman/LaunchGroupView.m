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
  BOOL _hasMouse;
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
  _hasMouse = YES;
  [self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {
  _hasMouse = NO;
  [self setNeedsDisplay:YES];
}



- (void)drawRect:(NSRect)dirtyRect
{
  if (_hasMouse) {
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
  
  CGFloat yOffset = NSMaxY([self convertRect:self.bounds toView:nil]);
  CGFloat xOffset = NSMinX([self convertRect:self.bounds toView:nil]);
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


@end
