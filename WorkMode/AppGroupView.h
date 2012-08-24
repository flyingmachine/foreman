//
//  AppGroupView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DragReceiver;
@class IconListView;
@class AppGroupController;

@interface AppGroupView : NSView
{
  IBOutlet NSView* rootView;
}

@property (assign) AppGroupController* controller;
@property (assign) IBOutlet DragReceiver* dragReceiver;
@property (assign) IBOutlet IconListView* iconListView;

@end
