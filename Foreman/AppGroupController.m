//
//  AppGroupController.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/10/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupController.h"
#import "IconListView.h"
#import "AppDelegate.h"
#import "Headers.h"

@implementation AppGroupController
@synthesize appGroup;
@synthesize iconListView;

- (id)initWithAppGroup:(NSDictionary *)appG
{
  self = [self init];
  if (self) {
    self.appGroup = appG;
    [NSBundle loadNibNamed:self.viewName owner:self];
    
    [self.iconListView showAppIcons];
  }
  
  return self;
}

- (void) addApps:(NSArray *)appsToAdd {
  for (NSString *app in appsToAdd) {
    if (![[appGroup valueForKey:@"apps"] containsObject:app]) {
      [[appGroup valueForKey:@"apps"] addObject: app];
    }
  }
  [self.iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (void) removeApp:(NSString *)app {
  [[appGroup valueForKey:@"apps"] removeObject:app];
  [self.iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (NSString *)viewName {
  return nil;
}

- (void)mouseUp {
  
}

@end
