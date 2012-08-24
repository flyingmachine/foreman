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

- (NSString *)draggedFilePath:(id<NSDraggingInfo>)sender
{
  return [[NSURL URLFromPasteboard:[sender draggingPasteboard]] path];
}


- (BOOL)appDragged:(id<NSDraggingInfo>)sender
{
  return [[NSWorkspace sharedWorkspace] isFilePackageAtPath: [self draggedFilePath:sender]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
  if ([self appDragged:sender]) {
    return NSDragOperationCopy;
  } else {
    return NSDragOperationNone;
  }
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
  return [self appDragged: sender];
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [appListController addApp: [[NSURL URLFromPasteboard: [sender draggingPasteboard]] path]];
  return YES;
}

@end
