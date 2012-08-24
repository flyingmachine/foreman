//
//  AddAppGroupControllerViewController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "NewAppGroupViewController.h"
#import "AppDelegate.h"

@implementation NewAppGroupViewController
- (void) addApps:(NSArray *)appsToAdd {
  AppDelegate* delegate = [[NSApplication sharedApplication] delegate];
  [delegate addAppGroupView: appsToAdd];
}
@end
