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
  return [self NSColorToCGColorRef:
          [NSColor colorWithCalibratedRed:0.33f
                                    green:0.75f
                                     blue:0.46f
                                    alpha:0.8f]];
}

+ (CGColorRef)unselectedLaunchGroupColor {
  
  return [self NSColorToCGColorRef:
          [NSColor colorWithCalibratedRed:0.43f
                                     green:0.50f
                                      blue:0.58f
                                     alpha:0.25f]];
}

+ (void)restoreFirstResponder {
  [self.delegate.window makeFirstResponder:(NSResponder *)self.delegate.baseAppView];
}

+ (CGColorRef)NSColorToCGColorRef:(NSColor *)color {
  // Get the r, g, b, a components
  CGFloat colorComponents[4];
  [color getComponents:colorComponents];
  
  // Create the CGColor
  return (__bridge CGColorRef)(__bridge id)CGColorCreateGenericRGB(
                                                            colorComponents[0],
                                                            colorComponents[1],
                                                            colorComponents[2],
                                                            colorComponents[3]);
  
}

@end
