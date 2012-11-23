//
//  BackgroundView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/13/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "BackgroundView.h"
#import "Headers.h"

@implementation BackgroundView

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setLayer:[CALayer layer]];
    self.wantsLayer = YES;
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;

    self.layer.backgroundColor = [App NSColorToCGColorRef:[NSColor colorWithCalibratedRed:0.0f
                                                                                    green:0.0f
                                                                                     blue:0.0f
                                                                                    alpha:0.4f]];
  }
  
  return self;
}
@end
