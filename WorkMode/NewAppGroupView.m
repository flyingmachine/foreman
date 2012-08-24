//
//  NewAppGroupView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "NewAppGroupView.h"
#import "NewAppGroupViewController.h"

@implementation NewAppGroupView
@synthesize controller;
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [controller addApps: [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}

@end
