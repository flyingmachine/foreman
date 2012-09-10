//
//  AppListController.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DragReceiver;
@class IconListView;

@interface LaunchGroupController : NSViewController <NSTextFieldDelegate>

@property (strong) NSDictionary* appGroup;
@property (assign) IBOutlet DragReceiver *dragReceiver;
@property (assign) IBOutlet IconListView *iconListView;
@property (assign) IBOutlet NSTextField *nameField;

- (void) addApps: (NSArray *) app;
- (void) launchApps;
- (IBAction)removeAppGroup:(id)sender;
- (void)removeApp:(id)app;
- (LaunchGroupController *) initWithAppGroup: (NSDictionary *) appGroup;

@end
