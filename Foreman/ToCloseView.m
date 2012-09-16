//
//  ToCloseView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/16/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "ToCloseView.h"
@implementation ToCloseView
{
  NSArray *_apps;
}
-(void)displayApps:(NSArray *)apps{
  _apps = apps;

  [self setHidden:NO];
  [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
  int icon_size = 18;
  for (int i = 0; i < [_apps count]; i++) {
    NSImage *image = [[NSWorkspace sharedWorkspace] iconForFile:_apps[i]];
    [image drawInRect:NSMakeRect(icon_size * (i % 3), 64 - 5 - (icon_size * ((i / 3) + 1)), 20, 20) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
  }
}
@end
