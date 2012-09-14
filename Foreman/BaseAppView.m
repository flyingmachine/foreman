//
//  BaseAppView.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 8/31/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "BaseAppView.h"
#import "App.h"
#import "AppDelegate.h"

@implementation BaseAppView
- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  
  return self;
}

#pragma mark keyboardEvents

- (void)keyDown:(NSEvent *)theEvent {
  [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];

}

-(IBAction)moveUp:(id)sender
{
  [[App delegate] selectPreviousLaunchGroup];
}

-(IBAction)moveDown:(id)sender
{
  [[App delegate] selectNextLaunchGroup];
}

-(IBAction)moveLeft:(id)sender
{
}

-(IBAction)moveRight:(id)sender
{
}

- (void)insertNewline:(id)sender {
  if ([[self window] firstResponder] == self) {
    [[App delegate] launchSelectedLaunchGroup];
  }
}

- (void)cancelOperation:(id)sender {
  [self.window close];
}

@end
