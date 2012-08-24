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
  float sideLength = 50.0;
  float leftMargin = -1 * sideLength;
  for(NSString* app in self.appListController.apps) {
    leftMargin += sideLength;
    NSImageView* imgView = [[NSImageView alloc] initWithFrame:NSMakeRect(leftMargin, 0, sideLength, sideLength)];
    NSImage* img = [[NSWorkspace sharedWorkspace] iconForFile:app];
    [img setSize:NSMakeSize(sideLength, sideLength)];
    [imgView setImage:img];
    [newSubViews addObject:imgView];
  }
  [self setSubviews:newSubViews];
  [self setNeedsDisplay:YES];
}

@end
