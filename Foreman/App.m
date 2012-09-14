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
@end
