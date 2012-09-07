//
//  AppDelegate.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppDelegate.h"
#import "AppGroupController.h"
#import "AppGroupView.h"
#import "Headers.h"


@implementation AppDelegate
@synthesize appGroups;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathForDataFile]]) {
    appGroups = [NSMutableArray arrayWithContentsOfFile:[self pathForDataFile]];
  } else {
    appGroups = [[NSMutableArray alloc] init];
  }
  
  [self createObservers];
  [self setFreshWindow];
}

- (void) createObservers {
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(addAppGroup:)
                                               name: @"addAppGroup"
                                             object: nil];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(saveAppGroups)
                                               name: @"addApp"
                                             object: nil];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(saveAppGroups)
                                               name: @"updateAppGroup"
                                             object: nil];

}

- (void) setFreshWindow {
  NSView * v = self.window.contentView;
  int adjust = (50 + BOTTOM_PADDING) - v.frame.size.height;
  [self resize:adjust animate:NO];
  for(NSDictionary *appGroup in appGroups) {
    [self displayAppGroup:appGroup animate:NO];
  }
}

- (void)addAppGroup:(NSNotification *)notification
{
  NSMutableDictionary* group = [[NSMutableDictionary alloc] initWithDictionary:[notification userInfo]];
  [appGroups addObject:group];
  [self displayAppGroup:group];
  [self saveAppGroups];
}

- (void)displayAppGroup:(NSDictionary *)group {
  [self displayAppGroup:group animate:YES];
}

- (void)displayAppGroup:(NSDictionary *)group animate:(BOOL)shouldAnimate {
  AppGroupController* controller = [[AppGroupController alloc] initWithAppGroup:group];
  [self resize:controller.view.frame.size.height animate:shouldAnimate];
  
  NSView* mainView = self.window.contentView;
  [mainView addSubview: controller.view];
  NSLog(@"%f", controller.view.frame.origin.y);
}

- (void)saveAppGroups {
  [appGroups writeToFile:[self pathForDataFile] atomically:YES];
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

- (void)removeAppGroup:(AppGroupController *)appGroupController {
  [appGroups removeObject:appGroupController.appGroup];
  
  NSMutableArray * toShift = [[NSMutableArray alloc] init];
  
  BOOL isAfter = NO;
  for (NSView * subv in [self.window.contentView subviews]) {
    if (subv == appGroupController.view) {
      isAfter = YES;
    }
    
    if ([subv class] == [AppGroupView class] && isAfter) {
      [toShift addObject:subv];
    }
  }
  
  [appGroupController.view removeFromSuperview];
  for (AppGroupView * subv in toShift) {
    [subv shiftUp];
  }
  
  [self resize: -65 animate:YES];
  
  [self saveAppGroups];
}

#pragma mark storage

- (NSString *) pathForDataFile
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  NSString *folder = @"~/Library/Application Support/Foreman/";
  folder = [folder stringByExpandingTildeInPath];
  
  NSError *error = nil;
  
  if ([fileManager fileExistsAtPath: folder] == NO)
  {
    [fileManager createDirectoryAtPath: folder
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
  }
  return [folder stringByAppendingPathComponent: FILE_LOCATION];
}

@end
