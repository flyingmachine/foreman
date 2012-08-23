//
//  DragReceiver.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "DragReceiver.h"
#import "AppListController.h"

@implementation DragReceiver
@synthesize appListController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self registerForDraggedTypes:@[NSFilenamesPboardType]];
    }
    
    return self;
}

#pragma mark - Destination Operations

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
  return NSDragOperationCopy;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
  return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [appListController addApp: [[NSURL URLFromPasteboard: [sender draggingPasteboard]] path]];
  return YES;
}

@end
