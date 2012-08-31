//
//  AppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/31/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupView.h"
#define BORDER_WIDTH 3

@implementation AppGroupView
{
  BOOL _hasMouse;
}

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc]
                                    initWithRect: frame
                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways )
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
    [[NSColor selectedTextBackgroundColor] setFill];
  } else {
    [[NSColor windowBackgroundColor] setFill];
  }
  NSRectFill(dirtyRect);
//  [self drawBorder:dirtyRect];
}


-(void)drawBorder:(NSRect)rect{
  //  NSRect rect = [self bounds];
  NSRect frameRect = [self bounds];
  
  if(rect.size.height < frameRect.size.height)
    return;
  NSRect newRect = NSMakeRect(rect.origin.x+2, rect.origin.y+2, rect.size.width-3, rect.size.height-3);
  
  NSBezierPath *textViewSurround = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:10 yRadius:10];
  [textViewSurround setLineWidth:BORDER_WIDTH];
  if (_hasMouse) {
    [[NSColor whiteColor] set];
  } else {
    [[NSColor windowBackgroundColor] set];
  }
  
  [textViewSurround stroke];
  [textViewSurround fill];
}


@end
