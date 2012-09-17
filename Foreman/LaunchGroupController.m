//  AppListController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "LaunchGroupController.h"
#import "LaunchGroupView.h"
#import "IconListView.h"
#import "IconViewController.h"
#import "ToCloseView.h"
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
  
  //NSLog(@"open apps: %@", openApps);
  
  for (NSString *app in [self.appGroup valueForKey:@"apps"]) {
    if (![openApps containsObject:app]) {
      [[NSWorkspace sharedWorkspace] launchApplication:app];
    }
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"appsLaunched" object:self userInfo:NULL];
  
  [self closeApps];
}

- (void) closeApps {
  NSRunningApplication* currentApplication = [NSRunningApplication currentApplication];
  [currentApplication hide];
  for (NSRunningApplication *runningApp in [[NSWorkspace sharedWorkspace] runningApplications]) {
    if ([[self appsToClose] containsObject:[[runningApp bundleURL] path]] && !([runningApp isEqual:currentApplication])) {
      [runningApp terminate];
    }
  }
}

- (NSArray *)appsToClose {
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
          [[info valueForKey:@"LSBackgroundOnly"] intValue] != 1 &&
          bundlePath &&
          ![bundlePath hasPrefix:@"/System"] &&
          ![[self.appGroup valueForKey:@"apps"] containsObject:bundlePath] &&
          ![[appDelegate.safeGroup valueForKey:@"apps"] containsObject:bundlePath] &&
          [bundlePath isNotEqualTo: [[NSBundle mainBundle] bundlePath]]
          ) {
        [appsToClose addObject:bundlePath];
      }
    }
  }
  
  NSLog(@"apps to close: %@", appsToClose);
  return appsToClose;
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

#pragma mark Selection

- (BOOL) selected {
  return [(LaunchGroupView *)self.launchGroupView selected];
}

- (void) select {
  [[[App delegate] groupControllers] makeObjectsPerformSelector:@selector(deselect)];
  [(LaunchGroupView *)self.launchGroupView setSelected:YES];
  [self.toCloseView displayApps:[self appsToClose]];
  [self.iconListView.iconViewControllers[0] select];
}

- (void) deselect {
  [(LaunchGroupView *)self.launchGroupView setSelected:NO];
  [self.toCloseView setHidden:YES];
  [[self selectedApp] deselect];
  [self.iconListView.iconViewControllers makeObjectsPerformSelector:@selector(deselect)];

}

- (IconViewController *) selectedApp {
  return (IconViewController *)self.iconListView.iconViewControllers[[self indexOfSelectedApp]];
}


- (NSInteger)indexOfSelectedApp {
  NSUInteger selectedIndex = [self.iconListView.iconViewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return [(LaunchGroupController *)obj selected];
  }];
  
  if (selectedIndex == NSNotFound) {
    return 0;
  } else {
    return selectedIndex;
  }
}


- (void)selectNextApp {
  NSInteger index = [self indexOfSelectedApp];
  if ((index == NSNotFound) || (index >= ([self.iconListView.iconViewControllers count] - 1))) {
    [self selectAppWithIndex: 0];
  } else  {
    [self selectAppWithIndex: index + 1];
  }
}

- (void)selectPreviousApp {
  NSInteger index = [self indexOfSelectedApp];
  if (index == 0 || index == NSNotFound)  {
    [self selectAppWithIndex: [self.iconListView.iconViewControllers count] - 1];
  } else {
    [self selectAppWithIndex: index - 1];
  }
}

- (void)selectAppWithIndex:(NSInteger)index {
  [self.iconListView.iconViewControllers makeObjectsPerformSelector:@selector(deselect)];
  [[self.iconListView.iconViewControllers objectAtIndex:index] select];
}

- (void)launchSelectedApp {
  [[self selectedApp] launch];
}

@end
