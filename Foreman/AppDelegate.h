//
//  AppDelegate.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define LAUNCH_GROUPS_FILENAME @"app_groups"
#define SAFE_GROUP_FILENAME @"safe_group"
@class LaunchGroupController;
@class BaseAppView;

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (strong) NSMutableArray *appGroups;
@property (strong) NSMutableDictionary *safeGroup;
@property (assign) IBOutlet BaseAppView *baseAppView;

- (void) removeAppGroup: (LaunchGroupController *)appGroup;
- (void) selectNextLaunchGroup;
- (void) selectPreviousLaunchGroup;
- (void) launchSelectedLaunchGroup;


@end
