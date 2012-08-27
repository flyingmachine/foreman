//
//  AppDelegate.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppDelegate.h"
#import "AppGroupController.h"

@implementation AppDelegate
@synthesize appGroups;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  appGroups = [[NSMutableArray alloc] init];
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(addAppGroup:)
                                               name: @"addAppGroup"
                                             object: nil];
  [self setEmptyWindow];
}

- (void) setEmptyWindow {
  NSView * v = self.window.contentView;
  int adjust = 50 - v.frame.size.height;
  [self resize:adjust animate:NO];
}

- (void)addAppGroup:(NSNotification *)notification
{
  NSDictionary* group = [notification userInfo];
  [appGroups addObject:group];
  AppGroupController* controller = [[AppGroupController alloc] init];
  [self resize:controller.rootView.frame.size.height animate:YES];
    
  NSView* mainView = self.window.contentView;
  [mainView addSubview: controller.rootView];
  
  if([group valueForKey:@"apps"] != nil){
    [controller addApps:[group valueForKey:@"apps"]];
  }
}

- (void)resize: (int) heightAdjust animate:(BOOL)animate{
  NSRect newWinFrame = self.window.frame;
  newWinFrame.size.height += heightAdjust;
  newWinFrame.origin.y -= heightAdjust;
  [self.window setFrame:newWinFrame display:NO animate:animate];
  
  NSView* mainView = self.window.contentView;
  NSRect newFrame = NSMakeRect(mainView.frame.origin.x, mainView.frame.origin.y, mainView.frame.size.width, mainView.frame.size.height);
  [mainView setFrame:newFrame];
}

@end
