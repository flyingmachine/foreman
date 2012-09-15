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
    [self setLayer:[CALayer layer]];
    self.wantsLayer = YES;
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[NSColor colorWithCalibratedRed:0.14f
                                                        green:0.22f
                                                         blue:0.24f
                                                        alpha:1] CGColor];
    self.layer.backgroundColor = [[NSColor colorWithCalibratedRed:0.43f
                                                            green:0.50f
                                                             blue:0.58f
                                                            alpha:0.25f] CGColor];
  }
  
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor clearColor] setFill];
  NSRectFill(dirtyRect);
}

@end
