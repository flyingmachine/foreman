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
          [NSColor darkGrayColor]];
}

+ (CGColorRef)unselectedLaunchGroupColor {
  
  return [self NSColorToCGColorRef:
          [NSColor lightGrayColor]];
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


+ (NSColor*)colorWithHexColorString:(NSString*)inColorString
{
  NSColor* result = nil;
  unsigned colorCode = 0;
  unsigned char redByte, greenByte, blueByte;
  
  if (nil != inColorString)
  {
    NSScanner* scanner = [NSScanner scannerWithString:inColorString];
    (void) [scanner scanHexInt:&colorCode]; // ignore error
  }
  redByte = (unsigned char)(colorCode >> 16);
  greenByte = (unsigned char)(colorCode >> 8);
  blueByte = (unsigned char)(colorCode); // masks off high bits
  
  result = [NSColor
            colorWithCalibratedRed:(CGFloat)redByte / 0xff
            green:(CGFloat)greenByte / 0xff
            blue:(CGFloat)blueByte / 0xff
            alpha:1.0];
  return result;
}

@end
