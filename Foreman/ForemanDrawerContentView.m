//
//  ForemanDrawerContentView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/15/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "ForemanDrawerContentView.h"

@implementation ForemanDrawerContentView
- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSLog(@"window: %@", self.window);
  }
  
  return self;
}

- (void) drawerWillOpen:(NSNotification *)notification {
  NSLog(@"window: %@", self.window);
  [self.window setAcceptsMouseMovedEvents:YES];
  [self.window setOpaque:NO];
  [self.window setStyleMask:NSBorderlessWindowMask];
  [self.window setHasShadow:NO];
  

}
@end
