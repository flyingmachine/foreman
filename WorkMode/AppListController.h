//
//  AppListController.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DragReceiver;
@class AppIconView;

@interface AppListController : NSController
@property (assign) IBOutlet DragReceiver* dragReceiver;
@property (assign) IBOutlet AppIconView* appIconView;

@end
