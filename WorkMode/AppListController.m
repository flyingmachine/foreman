//
//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppListController.h"
#import "AppIconView.h"

@implementation AppListController
@synthesize apps;
@synthesize appIconView;

- (id)init
{
  self = [super init];
  if (self) {
    apps = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void) addApp:(NSString *)app {
  [apps addObject: app];
  appIconView.app = app;
  [appIconView showAppIcon];
  NSLog(@"%@", apps);
}

@end
