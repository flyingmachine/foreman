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

- (void)awakeFromNib {
  self.wantsLayer = YES;
  self.layer.contents = (id)[NSImage imageNamed:@"bg.png"];

}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
  [controller addAppGroupWithName:@"" andApps:[[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
  return YES;
}


@end
