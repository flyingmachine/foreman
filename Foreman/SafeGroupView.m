//
//  SafeGroupView.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/9/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "SafeGroupView.h"
#import "SafeGroupViewController.h"

@implementation SafeGroupView
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [self.controller addApps:[[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}
@end
