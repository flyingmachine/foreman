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
{
  BOOL _shiftHeld;
}

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setLayer:[CALayer layer]];
    self.wantsLayer = YES;
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
  }
  
  return self;
}

#pragma mark keyboardEvents

- (void)keyDown:(NSEvent *)theEvent {
  if (NSShiftKeyMask & [theEvent modifierFlags]) {
    _shiftHeld = YES;
  } else {
    _shiftHeld = NO;
  }
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
  [[App delegate] selectPreviousApp];
}

-(IBAction)moveRight:(id)sender
{
  [[App delegate] selectNextApp];
}

- (void)insertNewline:(id)sender {
  if ([[self window] firstResponder] == self) {
    if (_shiftHeld) {
      [[App delegate] launchSelectedLaunchGroup];
    } else {
      [[App delegate] launchSelectedLaunchGroup];
    }
  }
}

- (void)cancelOperation:(id)sender {
  [[App delegate] toggle:sender];
}

@end
