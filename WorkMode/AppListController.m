//
//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppListController.h"
#import "IconListView.h"

@implementation AppListController
@synthesize apps;
@synthesize iconListView;

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
  [iconListView showAppIcons];
}

- (void) startApp:(NSString *)app {
  [[NSWorkspace sharedWorkspace] launchApplication:app];
}

@end
