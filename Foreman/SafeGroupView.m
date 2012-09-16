//
//  SafeGroupView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/9/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "SafeGroupView.h"
#import "SafeGroupViewController.h"

@implementation SafeGroupView
- (void)drawRect:(NSRect)dirtyRect {
  // set any NSColor for filling, say white:
  [[NSColor colorWithCalibratedWhite:1 alpha:0.8f] setFill];
  NSRectFill(dirtyRect);
}
@end
