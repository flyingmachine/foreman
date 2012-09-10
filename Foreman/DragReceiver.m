//
//  DragReceiver.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "DragReceiver.h"
#import "LaunchGroupController.h"

@implementation DragReceiver
@synthesize controller;

- (BOOL)acceptsFirstResponder {
  return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{  
  [controller addApps: [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}

- (void)mouseUp:(NSEvent *)theEvent {
  if ([self.controller respondsToSelector:@selector(mouseUp)]) {
    [self.controller mouseUp];
  }
}

@end
