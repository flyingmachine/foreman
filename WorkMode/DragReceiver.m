//
//  DragReceiver.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "DragReceiver.h"
#import "AppGroupController.h"

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

- (BOOL)acceptsFirstResponder {
  return YES;
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
  NSLog(@"%@", [[sender draggingPasteboard] pasteboardItems]);
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
  [appListController addApps: [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}

@end
