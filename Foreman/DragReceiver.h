//
//  DragReceiver.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppReceiver.h"
@class LaunchGroupController;


@interface DragReceiver : AppReceiver
@property (strong) IBOutlet LaunchGroupController* controller;
@end
