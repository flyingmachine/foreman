//
//  IconView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 9/3/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "IconView.h"

@implementation IconView
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
  NSButton* btn = [self.subviews objectAtIndex:0];
  [btn setEnabled:YES];
  [btn setTransparent:NO];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  [self enableDeleteBtn];
}



- (void)cursorUpdate:(NSEvent *)event {
  [self enableDeleteBtn];
}

- (void)mouseExited:(NSEvent *)theEvent {
  NSButton* btn = [self.subviews objectAtIndex:0];
  [btn setEnabled:NO];
  [btn setTransparent:YES];
}

@end
