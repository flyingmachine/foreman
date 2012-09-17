//
//  AppListController.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppGroupController.h"
@class DragReceiver;
@class IconListView;
@class IconViewController;
@class LaunchGroupView;
@class ToCloseView;

@interface LaunchGroupController : AppGroupController <NSTextFieldDelegate>

@property (assign) IBOutlet NSTextField *nameField;
@property (assign) IBOutlet LaunchGroupView *launchGroupView;
@property (assign) IBOutlet ToCloseView *toCloseView;


- (void) launchApps;
- (void) launchSelectedApp;
- (BOOL) selected;
- (void) select;
- (void) deselect;

- (void) selectNextApp;
- (void) selectPreviousApp;
- (IconViewController *) selectedApp;
- (IBAction)removeAppGroup:(id)sender;
@end
