//
//  AppReceiver.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/24/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppReceiver.h"
@implementation AppReceiver

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
  NSLog(@"drag entered");
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
@end
