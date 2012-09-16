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
  [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
  for (int i = 0; i < [_apps count]; i++) {
    NSImage *image = [[NSWorkspace sharedWorkspace] iconForFile:_apps[i]];
    [image drawInRect:NSMakeRect(20 * (i % 3), 64 - (20 * (3 - (i / 3))), 20, 20) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
  }
}
@end
