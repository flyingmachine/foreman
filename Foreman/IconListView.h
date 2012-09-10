//
//  AppIconView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LaunchGroupController;

@interface IconListView : NSView
@property (strong) IBOutlet LaunchGroupController* controller;
@property (strong) NSString* app;
@property (strong) NSMutableArray* iconViewControllers;

- (void)showAppIcons;

@end
