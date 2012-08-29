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
@synthesize appGroup;
@synthesize iconListView;

- (id)initWithAppGroup:(NSDictionary *)appG
{
  self = [self init];
  if (self) {
    appGroup = appG;
    [NSBundle loadNibNamed:@"AppGroupView" owner:self];
    [iconListView showAppIcons];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
  }
  
  return self;
}

- (void) addApps:(NSArray *)appsToAdd {
  for (NSString *app in appsToAdd) {
    if (![[appGroup valueForKey:@"apps"] containsObject:app]) {
      [[appGroup valueForKey:@"apps"] addObject: app];
    }
  }
  NSLog(@"add apps");
  [iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (void) launchApps {
  
}

- (void) startApp:(NSString *)app {
  [[NSWorkspace sharedWorkspace] launchApplication:app];
}

@end
