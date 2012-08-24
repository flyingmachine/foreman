//
//  AppIconView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AppGroupController;

@interface IconListView : NSView
@property (assign) IBOutlet AppGroupController* appListController;
@property (strong) NSString* app;

- (void)showAppIcons;

@end
