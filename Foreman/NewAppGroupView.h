//
//  NewAppGroupView.h
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppReceiver.h"

@class NewAppGroupViewController;

@interface NewAppGroupView : AppReceiver
@property (strong) IBOutlet NewAppGroupViewController* controller;
@end