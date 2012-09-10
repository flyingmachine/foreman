//
//  AppDelegate.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define FILE_LOCATION @"app_groups"
@class AppGroupController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (strong) NSMutableArray* appGroups;
@property (strong) NSMutableArray* safeGroup;

- (void) removeAppGroup: (AppGroupController *)appGroup;

@end
