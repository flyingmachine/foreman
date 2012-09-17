//
//  App.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/14/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "App.h"
#import "AppDelegate.h"

@implementation App
+ (AppDelegate *)delegate{
  return (AppDelegate *)[[NSApplication sharedApplication] delegate];
}

+ (CGColorRef)selectedLaunchGroupColor {
  return [[NSColor colorWithCalibratedRed:0.33f
                                    green:0.75f
                                     blue:0.46f
                                    alpha:0.8f] CGColor];
}

+ (CGColorRef)unselectedLaunchGroupColor {
  return [[NSColor colorWithCalibratedRed:0.43f
                                    green:0.50f
                                     blue:0.58f
                                    alpha:0.25f] CGColor];
}

+ (void)restoreFirstResponder {
  [self.delegate.window makeFirstResponder:self.delegate.baseAppView];
}

@end
