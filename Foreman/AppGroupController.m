//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppGroupController.h"
#import "IconListView.h"
#import "Headers.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@implementation AppGroupController
@synthesize appGroup;
@synthesize iconListView;

- (id)initWithAppGroup:(NSDictionary *)appG
{
  self = [self init];
  if (self) {
    appGroup = appG;
    [NSBundle loadNibNamed:@"AppGroupView" owner:self];
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = BOTTOM_PADDING;
    self.view.frame = newFrame;
    [self.nameField setStringValue:[appGroup valueForKey:@"name"]];
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
  [iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (void) removeAppGroup:(id)sender {
  [(AppDelegate *)[[NSApplication sharedApplication] delegate] removeAppGroup: self];
}

- (void) removeApp:(NSString *)app {
  NSLog(@"removing app appgroupcontroller");
  [[appGroup valueForKey:@"apps"] removeObject:app];
  [iconListView showAppIcons];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"addApp" object:self userInfo:NULL];
}

- (void) launchApps {
  NSMutableArray *openApps = [[NSMutableArray alloc] init];
  
  for (NSRunningApplication *runningApp in[[NSWorkspace sharedWorkspace] runningApplications]) {
    if ([runningApp bundleURL]) {
      [openApps addObject:[[runningApp bundleURL] path]];
    }
  }
  
  NSLog(@"open apps: %@", openApps);
  
  for (NSString *app in [appGroup valueForKey:@"apps"]) {
    if (![openApps containsObject:app]) {
      [[NSWorkspace sharedWorkspace] launchApplication:app];
    }
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"appsLaunched" object:self userInfo:NULL];
  
  [self closeApps];
}

- (void) closeApps {
  NSMutableArray *appsToClose = [[NSMutableArray alloc] init];
  NSDictionary *info;
  OSErr err = NO;
  ProcessSerialNumber psn = {0, kNoProcess};
  while (!err)
  {
    err = GetNextProcess(&psn);
    
    if (!err)
    {
      info = (__bridge NSDictionary *)ProcessInformationCopyDictionary(&psn, kProcessDictionaryIncludeAllInformationMask);
      NSString *bundlePath = (NSString *)[info valueForKey:@"BundlePath"];
      if (
          [[info valueForKey:@"LSUIElement"] intValue] != 1 &&
          bundlePath &&
          ![bundlePath hasPrefix:@"/System"] &&
          ![[appGroup valueForKey:@"apps"] containsObject:bundlePath]
          ) {
        
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

#pragma mark NSTextField Delegate

- (void)saveName {
  [appGroup setValue: self.nameField.stringValue forKey:@"name"];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAppGroup" object:self userInfo:NULL];
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSTextField *)fieldEditor {
  [self saveName];
  return YES;
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)command {
  if (command == @selector(cancelOperation:) || command == @selector(insertNewline:)) {
    [[textView window] makeFirstResponder:nil];
    return YES;
  } else {
    return NO;
  }
}

@end
