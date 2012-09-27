//
//  AppDelegate.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ShortcutRecorder/ShortcutRecorder.h>

#define LAUNCH_GROUPS_FILENAME @"app_groups"
#define SAFE_GROUP_FILENAME @"safe_group"
@class LaunchGroupController;
@class BaseAppView;

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (strong) NSMutableArray *appGroups;
@property (strong) NSMutableArray *groupControllers;
@property (strong) NSMutableDictionary *safeGroup;
@property (assign) IBOutlet BaseAppView *baseAppView;

- (void) removeAppGroup: (LaunchGroupController *)appGroup;
- (void) selectNextLaunchGroup;
- (void) selectPreviousLaunchGroup;
- (void) selectNextApp;
- (void) selectPreviousApp;
- (void) launchSelectedLaunchGroup;
- (LaunchGroupController *)selectedLaunchGroup;
- (void) launchSelectedApp;
- (IBAction)toggle:(id)sender;

@end
