//
//  SafeGroupViewController.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/9/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "SafeGroupViewController.h"
#import "AppDelegate.h"

@implementation SafeGroupViewController
{
  NSMutableArray* _safeGroup;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  
  return self;
}

- (void) addApps:(NSArray *)apps {
  NSMutableArray *safeGroup = [(AppDelegate *)[[NSApplication sharedApplication] delegate] safeGroup];
  for (NSString *app in apps) {
    if (![safeGroup containsObject:app]) {
      [safeGroup addObject:app];
    }
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSafeGroup" object:nil userInfo:nil];
}


@end
