//
//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupController.h"
#import "IconListView.h"

@implementation AppGroupController
@synthesize apps;
@synthesize iconListView;

- (id)init
{
  self = [super init];
  if (self) {
    apps = [[NSMutableOrderedSet alloc] init];
  }
  
  return self;
}

- (void) addApps:(NSArray *)appsToAdd {
  [apps addObjectsFromArray: appsToAdd];
  [iconListView showAppIcons];
}

- (void) startApp:(NSString *)app {
  [[NSWorkspace sharedWorkspace] launchApplication:app];
}

@end
