//
//  DragReceiver.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class AppGroupController;

@interface DragReceiver : NSView <NSDraggingDestination>
@property (strong) IBOutlet AppGroupController* controller;
@end
