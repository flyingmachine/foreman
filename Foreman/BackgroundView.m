//
//  BackgroundView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/13/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
  }
  
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  // set any NSColor for filling, say white:
  self.layer.cornerRadius = 20.0f;
  self.layer.masksToBounds = YES;
  [[NSColor colorWithCalibratedRed:0.43f
                             green:0.50f
                              blue:0.58f
                             alpha:0.7f] setFill];
  NSRectFill(dirtyRect);
}

@end
