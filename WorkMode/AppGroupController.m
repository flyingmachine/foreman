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
    NSLog(@"%@", appGroup);
    [NSBundle loadNibNamed:@"AppGroupView" owner:self];
    [iconListView showAppIcons];
  }
  
  return self;
}

- (void) addApps:(NSArray *)appsToAdd {
  [[appGroup valueForKey:@"apps"] addObjectsFromArray: appsToAdd];
  [iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (void) startApp:(NSString *)app {
  [[NSWorkspace sharedWorkspace] launchApplication:app];
}

@end
