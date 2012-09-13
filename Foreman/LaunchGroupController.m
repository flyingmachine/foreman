//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "LaunchGroupController.h"
#import "IconListView.h"
#import "Headers.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@implementation LaunchGroupController

- (id)initWithAppGroup:(NSDictionary *)appG
{
  self = [super initWithAppGroup:appG];
  if (self) {
    [self.nameField setStringValue:[self.appGroup valueForKey:@"name"]];
  }  
  return self;
}

- (void) mouseUp {
  [self launchApps];
}

- (void) launchApps {
  NSMutableArray *openApps = [[NSMutableArray alloc] init];
  
  for (NSRunningApplication *runningApp in[[NSWorkspace sharedWorkspace] runningApplications]) {
    if ([runningApp bundleURL]) {
      [openApps addObject:[[runningApp bundleURL] path]];
    }
  }
  
  NSLog(@"open apps: %@", openApps);
  
  for (NSString *app in [self.appGroup valueForKey:@"apps"]) {
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
  AppDelegate *appDelegate = [[NSApplication sharedApplication] delegate];
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
          ![[self.appGroup valueForKey:@"apps"] containsObject:bundlePath] &&
          ![[appDelegate.safeGroup valueForKey:@"apps"] containsObject:bundlePath]
          ) {
        
        [appsToClose addObject:bundlePath];
      }
    }
  }
  
  NSLog(@"apps to close: %@", appsToClose);

  NSRunningApplication* currentApplication = [NSRunningApplication currentApplication];
  for (NSRunningApplication *runningApp in [[NSWorkspace sharedWorkspace] runningApplications]) {
    if ([appsToClose containsObject:[[runningApp bundleURL] path]] && !([runningApp isEqual:currentApplication])) {
      [runningApp terminate];
    }
  }
  [currentApplication hide];
}

- (NSString *)viewName {
  return @"LaunchGroupView";
}

- (void) removeAppGroup:(id)sender {
  [(AppDelegate *)[[NSApplication sharedApplication] delegate] removeAppGroup: self];
}

#pragma mark NSTextField Delegate

- (void)saveName {
  [self.appGroup setValue: self.nameField.stringValue forKey:@"name"];
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