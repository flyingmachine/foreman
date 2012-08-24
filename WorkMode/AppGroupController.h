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

@interface AppGroupController : NSController

@property (strong) NSMutableOrderedSet* apps;
@property (assign) IBOutlet DragReceiver* dragReceiver;
@property (assign) IBOutlet IconListView* iconListView;

- (void) addApps: (NSArray *) app;

@end