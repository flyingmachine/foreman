//
//  ForemainMainWindow.m
//  Foreman
//
//  Created by Daniel Higginbotham on 9/13/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "ForemainMainWindow.h"
#import "AppDelegate.h"
#import "BaseAppView.h"

@implementation ForemainMainWindow

@synthesize initialLocation;


- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag {
  // Using NSBorderlessWindowMask results in a window without a title bar.
  self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask
                            backing:NSBackingStoreBuffered
                              defer:NO];
  if (self != nil) {
    [self setAcceptsMouseMovedEvents:YES];
    [self setOpaque:NO];
    self.backgroundColor = [NSColor clearColor];
  }
  return self;
}

- (BOOL)acceptsMouseMovedEvents {
  return YES;
}

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (BOOL)canBecomeMainWindow {
  return YES;
}

- (CGRect) unmovableBounds {
  return [[(AppDelegate *)[[NSApplication sharedApplication] delegate] baseAppView]frame];
}

- (void)mouseMoved:(NSEvent *)event
{
  //set movableByWindowBackground to YES **ONLY** when the mouse is on the title bar
  NSPoint mouseLocation = [event locationInWindow];
  if (!NSPointInRect(mouseLocation, [self unmovableBounds])){
    [self setMovableByWindowBackground:YES];
  }else{
    [self setMovableByWindowBackground:NO];
  }
  
  //This is a good place to set the appropriate cursor too
}

- (void)mouseDown:(NSEvent *)event
{
  //Just in case there was no mouse movement before the click AND
  //is inside the title bar frame then setMovableByWindowBackground:YES
  NSPoint mouseLocation = [event locationInWindow];
  if (!NSPointInRect(mouseLocation, [self unmovableBounds])){
    [self setMovableByWindowBackground:YES];
  }
}

- (void)mouseUp:(NSEvent *)event
{
  //movableByBackground must be set to YES **ONLY**
  //when the mouse is inside the titlebar.
  //Disable it here :)
  [self setMovableByWindowBackground:NO];
}

@end
