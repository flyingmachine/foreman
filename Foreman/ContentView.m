//
//  ContentView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/14/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor clearColor] setFill];
  NSRectFill(dirtyRect);
}

@end
