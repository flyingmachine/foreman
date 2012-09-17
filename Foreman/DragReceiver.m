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
@synthesize controller;

- (BOOL)acceptsFirstResponder {
  return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [self.controller addApps: [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
}

- (void)mouseUp:(NSEvent *)event {
  NSPoint mouseLocation = [event locationInWindow];
  if (NSPointInRect([self convertPoint:mouseLocation fromView:nil], self.frame)) {
    [self.controller mouseUp:event];
  }
}

@end
