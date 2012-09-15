//
//  IconViewController.m
//  WorkMode
//
//  Created by Daniel Higginbotham on 9/2/12.
//  Copyright (c) 2012 Daniel Higginbotham. All rights reserved.
//

#import "IconViewController.h"
#import "AppGroupController.h"
#import "IconView.h"

@interface IconViewController ()

@end

@implementation IconViewController
@synthesize appGroupController, app;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)setup:(float)leftMargin app:(NSString *)myApp appGroupController:(AppGroupController *)agc {
  self.appGroupController = agc;
  self.app = myApp;
  NSRect f = self.view.frame;
  f.origin.x = leftMargin;
  self.view.frame = f;
  NSImage* img = [[NSWorkspace sharedWorkspace] iconForFile:self.app];
  [img setSize:NSMakeSize(50, 50)];
  [(IconView *)self.view setIcon:img];
  [self.view setNeedsDisplay:YES];
}

- (IBAction)removeApp:(id)sender {
  [appGroupController removeApp:app];
}

- (BOOL) selected {
  return [(IconView *)self.view selected];
}

- (void) select {
  [(IconView *)self.view setSelected:YES];
}

- (void) deselect {
  [(IconView *)self.view setSelected:NO];
}

- (void) launch {
  [[NSWorkspace sharedWorkspace] launchApplication:app];
}

@end
