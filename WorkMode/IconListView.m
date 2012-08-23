//
//  AppIconView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "IconListView.h"
#import "AppListController.h"

@implementation IconListView

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
  }
  
  return self;
}


- (void)showAppIcons
{
  NSMutableArray* newSubViews = [[NSMutableArray alloc] init];
  float i = -30.0;
  for(NSString* app in self.appListController.apps) {
    i += 30;
    NSImageView* img = [[NSImageView alloc] initWithFrame:NSMakeRect(i, 0, 30, 30)];
    [img setImage:[[NSWorkspace sharedWorkspace] iconForFile:app]];
    [newSubViews addObject:img];
  }
  [self setSubviews:newSubViews];
  [self setNeedsDisplay:YES];
}

@end
