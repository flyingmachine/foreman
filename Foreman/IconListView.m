//
//  AppIconView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/22/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "IconListView.h"
#import "AppGroupController.h"
#import "IconViewController.h"

@implementation IconListView
@synthesize iconViewControllers;
- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.iconViewControllers = [[NSMutableArray alloc] init];
  }
  
  return self;
}


- (void)showAppIcons
{
  [self.iconViewControllers removeAllObjects];
  
  NSMutableArray* newSubViews = [[NSMutableArray alloc] init];
  float sideLength = 50.0;
  float leftMargin = 0;
  for(NSString* app in [self.controller.appGroup valueForKey:@"apps"]) {
    IconViewController* vc = [[IconViewController alloc] initWithNibName:@"Icon" bundle:nil];
    [iconViewControllers addObject:vc];
    [vc setup:leftMargin app:app appGroupController:self.controller];
    [newSubViews addObject:vc.view];
    leftMargin += sideLength;
  }
  [self setSubviews:newSubViews];
  [self setNeedsDisplay:YES];
}
@end
