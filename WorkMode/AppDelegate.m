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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (void)addAppGroupView:(NSArray *)apps
{
  AppGroupController* controller = [[AppGroupController alloc] init];
  NSRect rootFrame = controller.rootView.frame;
  
  NSRect newWinFrame = self.window.frame;
  newWinFrame.size.height += rootFrame.size.height;
  [self.window setFrame:newWinFrame display:YES];
  
  NSView* mainView = self.window.contentView;
  NSRect newFrame = NSMakeRect(mainView.frame.origin.x, mainView.frame.origin.y, mainView.frame.size.width, mainView.frame.size.height);
  [mainView setFrame:newFrame];
  [mainView addSubview: controller.rootView];
  
  if(apps != nil){
    [controller addApps:apps];
  }
}

@end
