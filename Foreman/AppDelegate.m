//
//  AppDelegate.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/19/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchGroupController.h"
#import "LaunchGroupView.h"
#import "Headers.h"
#import "NSStatusItem+BCStatusItem.h"
#import "StatusItemView.h"
#import "SafeGroupViewController.h"
#import "BaseAppView.h"
#import "LaunchGroupViewContainer.h"
#import "DDHotKeyCenter.h"

@interface AppDelegate () <StatusItemViewDataProvier>
@end

@implementation AppDelegate {
  NSStatusItem *_statusItem;
  DDHotKeyCenter *_hotKeyCenter;
}

@synthesize appGroups;
@synthesize groupControllers;
@synthesize safeGroup;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [self loadLaunchGroups];
  [self loadSafeGroup];
  groupControllers = [NSMutableArray new];
  
  [self createObservers];
  [self setFreshWindow];
  [self createStatusItem];
  [self registerHotkeys];
  
  if ([self.appGroups count] == 0) {
    [self toggle:nil];
    [self toggle:nil];    
  } else {
    [self toggle:nil];
  }
}

-(void)awakeFromNib
{
	[_window setReleasedWhenClosed:FALSE];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag{

	if(flag==NO){
		[_window makeKeyAndOrderFront:self];
	}
	return YES;
}

- (void)loadLaunchGroups {
  if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathForLaunchGroups]]) {
    appGroups = [NSMutableArray arrayWithContentsOfFile:[self pathForLaunchGroups]];
  } else {
    appGroups = [self defaultAppGroups];
  }
}

- (NSMutableArray *)defaultAppGroups {
  NSMutableArray *groups = [NSMutableArray array];
//  NSMutableArray *apps = [NSMutableArray array];
//  NSString *safariPath = @"/Applications/Safari.app";
//  if ([[NSFileManager defaultManager] fileExistsAtPath:safariPath]) {
//    [apps addObject:safariPath];
//    [groups addObject:@{ @"name" : @"Example", @"apps" : apps }];
//  }
  return groups;
}

- (void)loadSafeGroup {
  if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathForSafeGroup]]) {
    self.safeGroup = [NSMutableDictionary dictionaryWithContentsOfFile:[self pathForSafeGroup]];
  } else {
    self.safeGroup = [NSMutableDictionary dictionary];
    [self.safeGroup setObject:[NSMutableArray array] forKey:@"apps"];
  }
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
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(saveSafeGroup)
                                               name: @"updateSafeGroup"
                                             object: nil];
}

// Used when the app first launches to display the saved app groups
- (void) setFreshWindow {
  NSView *parentView = self.baseAppView.superview;
  [self.baseAppView removeFromSuperview];
  [parentView addSubview:self.baseAppView positioned:NSWindowAbove relativeTo:nil];
  int adjust = 50  - self.baseAppView.frame.size.height;
  [self resize:adjust animate:NO];
  [self displaySafeGroup];
  for(NSDictionary *appGroup in appGroups) {
    [self displayAppGroup:appGroup animate:NO];
  }
  
  
  [self setInitialPosition];
  [App restoreFirstResponder];
}

- (void) setInitialPosition {
  NSScreen *mainScreen = [NSScreen mainScreen];
  NSPoint topLeft = NSMakePoint((mainScreen.visibleFrame.size.width - self.baseAppView.frame.size.width) / 2, mainScreen.visibleFrame.size.height - 50);
  [self.window setFrameTopLeftPoint:topLeft];
}

- (void)createStatusItem {
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	StatusItemView *statusItemView = [[StatusItemView alloc] initWithStatusItem:_statusItem];
  [statusItemView setDataProvider:self];
	[_statusItem setView:statusItemView];
  [_statusItem setMenu:self.statusMenu];
	[[_statusItem menu] setDelegate:statusItemView];
	[_statusItem setHighlightMode:YES];
	[_statusItem setImage:[NSImage imageNamed:@"status"]];
	[_statusItem setAlternateImage:[NSImage imageNamed:@"status-selected"]];
	[_statusItem setViewDelegate:self];
//	[[statusItem view] registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

- (void)registerHotkeys {
  _hotKeyCenter = [[DDHotKeyCenter alloc] init];
  [_hotKeyCenter registerHotKeyWithKeyCode:47
                             modifierFlags:NSCommandKeyMask | NSShiftKeyMask
                                      task:^(NSEvent *e) {
    [self toggle:nil];
  }];
}

#pragma mark SafeGroup

- (void)displaySafeGroup {
  SafeGroupViewController* controller = [[SafeGroupViewController alloc] initWithAppGroup:self.safeGroup];
  [self resize: controller.view.frame.size.height + 3 animate:NO];
  NSRect adjustedFrame = controller.view.frame;
  adjustedFrame.origin.y = 2;
  controller.view.frame = adjustedFrame;
  
  [self.baseAppView addSubview: controller.view];
}

#pragma mark AppGroupManagement

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
  // Todo this should be extracted to better ensure the sync with appGrouns
  LaunchGroupController* controller = [[LaunchGroupController alloc] initWithAppGroup:group];
  [groupControllers addObject:controller];
  [self resize:controller.view.frame.size.height animate:shouldAnimate];
  
  [self.baseAppView addSubview: controller.view];
}

- (void)saveAppGroups {
  [self.appGroups writeToFile:[self pathForLaunchGroups] atomically:YES];
  [self.safeGroup writeToFile:[self pathForSafeGroup] atomically:YES];
}

- (void)resize: (int) heightAdjust animate:(BOOL)animate{
  NSRect newWinFrame = self.window.frame;
  newWinFrame.size.height += heightAdjust;
  newWinFrame.origin.y -= heightAdjust;
  [self.window setFrame:newWinFrame display:NO animate:animate];
  
  NSRect newFrame = NSMakeRect(15, 13, self.baseAppView.frame.size.width, self.baseAppView.frame.size.height);
  [self.baseAppView setFrame:newFrame];
}

- (void)removeAppGroup:(LaunchGroupController *)launchGroupController {
  [appGroups removeObject:launchGroupController.appGroup];
  
  NSLog(@"launch group view: %@", launchGroupController.view);
  
  for (int i = [[self.baseAppView subviews] indexOfObject: launchGroupController.view];
       i < [[self.baseAppView subviews] count];
       i++) {
    [(LaunchGroupViewContainer *)[[self.baseAppView subviews] objectAtIndex:i] shiftUp];
  }
  
  [launchGroupController.view removeFromSuperview];
  
  [self resize: -65 animate:YES];
  
  [self saveAppGroups];
}

#pragma mark storage

- (NSString *) pathForDataFile:(NSString *)filename
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
  return [folder stringByAppendingPathComponent: filename];
}

- (NSString *)pathForLaunchGroups {
  return [self pathForDataFile:LAUNCH_GROUPS_FILENAME];
}

- (NSString *)pathForSafeGroup
{
  return [self pathForDataFile:SAFE_GROUP_FILENAME];
}

#pragma mark StatusItemViewDataProvier

- (NSArray*)groupNamesForStatusItemView:(StatusItemView *)view {
  NSMutableArray *names = [NSMutableArray new];
  [appGroups enumerateObjectsUsingBlock:^(NSDictionary* group, NSUInteger idx, BOOL *stop) {
    [names addObject:[group valueForKey:@"name"]];
  }];
  return names;
}

- (void)statusItemView:(StatusItemView *)view didSelectGroupAtIndex:(NSInteger)index {
  LaunchGroupController *controller = groupControllers[index];
  [controller launchApps];
}

#pragma mark LaunchGroupSelection
- (NSInteger)indexOfSelectedLaunchGroup {
  return [groupControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return [(LaunchGroupController *)obj selected];
  }];
}

- (void)selectNextLaunchGroup {
  NSInteger index = [self indexOfSelectedLaunchGroup];
  if ((index == NSNotFound) || (index >= ([groupControllers count] - 1))) {
    [self selectLaunchGroupWithIndex:0];
  } else  {
    [self selectLaunchGroupWithIndex: index + 1];
  }
}

- (void)selectPreviousLaunchGroup {
  NSInteger index = [self indexOfSelectedLaunchGroup];
  if (index == 0 || index == NSNotFound)  {
    [self selectLaunchGroupWithIndex: [groupControllers count] - 1];
  } else {
    [self selectLaunchGroupWithIndex: index - 1];
  }
}

- (void)selectLaunchGroupWithIndex:(NSInteger)index {
  [(LaunchGroupController *)[groupControllers objectAtIndex:index] select];
}

- (LaunchGroupController *)selectedLaunchGroup {
  NSInteger index = [self indexOfSelectedLaunchGroup];
  if (index != NSNotFound) {
    return [groupControllers objectAtIndex:index];
  } else {
    return nil;
  }
}

- (void)launchSelectedLaunchGroup {
  [[self selectedLaunchGroup] launchApps];
}

#pragma mark appSelection

- (void)selectNextApp {
  [[self selectedLaunchGroup] selectNextApp];
}

- (void)selectPreviousApp {
  [[self selectedLaunchGroup] selectPreviousApp];
}



- (void)launchSelectedApp {
  [[self selectedLaunchGroup] launchSelectedApp];
}

#pragma mark systemEvents
- (void)applicationWillBecomeActive:(NSNotification *)notification {
  [_window makeKeyAndOrderFront:self];
  // re-select to ensure preview is accurate
  [[self selectedLaunchGroup] select];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
  //[[NSRunningApplication currentApplication] hide];
}

- (IBAction)toggle:(id)sender {
  NSApplication *currentApp = [NSApplication sharedApplication];
  if ([currentApp isActive]) {
    [currentApp deactivate];
    [currentApp hide:nil];
  } else {
    [currentApp activateIgnoringOtherApps:YES];
  }
}
@end
