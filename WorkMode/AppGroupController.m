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
  for (NSString *app in [appGroup valueForKey:@"apps"]) {
    [[NSWorkspace sharedWorkspace] launchApplication:app];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"appsLaunched" object:self userInfo:NULL];
  
//  for (NSRunningApplication *runningApp in [[NSWorkspace sharedWorkspace] runningApplications]) {
//    FSRef ref;
//    CFURLGetFSRef((__bridge CFURLRef)([runningApp bundleURL]), &ref);
//    
//    CFTypeRef tref;
//    LSCopyItemAttribute(&ref, kLSRolesAll, kLSItemDisplayKind, &tref);
//    
//    NSLog(@"%@", tref);
//    
//    LSCopyItemAttribute(&ref, kLSRolesAll, kLSItemDisplayName, &tref);
//    NSLog(@"%@", tref);
//    
//    LSCopyItemAttribute(&ref, kLSRolesAll, kLSItemIsInvisible, &tref);
//    if (tref == kCFBooleanTrue) {
//      NSLog(@"invisible");
//    }
//    
//  }
  [self closeApps];
}

- (void) closeApps {
  NSMutableArray *appsToClose = [[NSMutableArray alloc] initWithArray:@[]];
  NSDictionary *info;
  OSErr err = NO;
  ProcessSerialNumber psn = {0, kNoProcess};
  while (!err)
  {
    err = GetNextProcess(&psn);
    
    if (!err)
    {
      info = (__bridge NSDictionary *)ProcessInformationCopyDictionary(&psn, kProcessDictionaryIncludeAllInformationMask);
      NSLog(@"%@", info);
      NSString *bundlePath = (NSString *)[info valueForKey:@"BundlePath"];
      if (
          [[info valueForKey:@"LSUIElement"] intValue] != 1 &&
          bundlePath &&
          ![bundlePath hasPrefix:@"/System"] &&
          ![[appGroup valueForKey:@"apps"] containsObject:bundlePath]
          ) {
        NSLog(@"lsuielement: %@", [info valueForKey:@"LSUIElement"]);
        
        [appsToClose addObject:bundlePath];
      }
    }
  }
  
  NSLog(@"apps to close: %@", appsToClose);
  
  for (NSRunningApplication *runningApp in [[NSWorkspace sharedWorkspace] runningApplications]) {
    if ([appsToClose containsObject:[[runningApp bundleURL] path]]) {
      [runningApp terminate];
    }
  }
}

@end
