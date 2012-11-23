//
//  SafeGroupView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/9/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "SafeGroupView.h"
#import "SafeGroupViewController.h"
#import "App.h"

@implementation SafeGroupView
- (void)drawRect:(NSRect)dirtyRect {
  // set any NSColor for filling, say white:
  [[App colorWithHexColorString:@"b7e7b0"] setFill];
  NSRectFill(dirtyRect);
}
@end
