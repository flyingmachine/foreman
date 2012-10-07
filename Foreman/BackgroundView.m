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
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [App NSColorToCGColorRef:[NSColor colorWithCalibratedRed:0.33f
                                                                                green:0.40f
                                                                                 blue:0.48f
                                                                                alpha:1.0f]];

    self.layer.backgroundColor = [App NSColorToCGColorRef:[NSColor colorWithCalibratedRed:0.43f
                                                                                    green:0.50f
                                                                                     blue:0.58f
                                                                                    alpha:0.25f]];
  }
  
  return self;
}
@end
