//
//  AppIconView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppIconView.h"

@implementation AppIconView
@synthesize app;

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}


- (void)showAppIcon
{
//  NSImage *newImage = [[NSImage alloc] initWithContentsOfFile: app];
  [self setImage:[[NSWorkspace sharedWorkspace] iconForFile:app]];
  [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect
{
  [super drawRect:rect];
  //highlight by overlaying a gray border
  [[NSColor grayColor] set];
  [NSBezierPath setDefaultLineWidth: 5];
  [NSBezierPath strokeRect: rect];
}


@end
