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
{
  NSImage *_bg;
}
@synthesize controller;


- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [controller addAppGroupWithName:@"" andApps:[[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
  [[NSColor colorWithPatternImage:[NSImage imageNamed:@"crisp_paper_ruffles.png"]] setFill];
  NSRectFill(dirtyRect);
}

@end
