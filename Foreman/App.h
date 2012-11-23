//
//  App.h
//  Foreman
//
//  Created by Daniel Higginbotham on 9/14/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppDelegate;

@interface App : NSObject
+ (AppDelegate *)delegate;
+ (CGColorRef)selectedLaunchGroupColor;
+ (CGColorRef)unselectedLaunchGroupColor;
+ (CGColorRef)NSColorToCGColorRef:(NSColor *)color;
+ (NSColor *)colorWithHexColorString:(NSString *)inColorString;
+ (void)restoreFirstResponder;
@end
